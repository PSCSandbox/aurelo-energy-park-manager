codeunit 55000 "Corporation Dimension Mgt."
{
    Permissions = tabledata "User Settings" = RIMD, tabledata "Application User Settings" = RIMD;

    var
        AemSetup: Record "AEM Setup";

    procedure BuildUserAssignedDimensionFlowFilter(var currRecord: RecordRef)
    var
        globalDimeFieldRef: FieldRef;
    begin
        GetGlobalDimension1FilterFieldRef(currRecord, globalDimeFieldRef);
        BuildUserAssignedFilter(currRecord, globalDimeFieldRef);
    end;

    procedure BuildUserAssignedDimensionFilter(var currRecord: RecordRef)
    var
        globalDimeFieldRef: FieldRef;
    begin
        GetGlobalDimension1FilterFieldRef(currRecord, globalDimeFieldRef);
        BuildUserAssignedFilter(currRecord, globalDimeFieldRef);
    end;

    procedure BuildUserAssignedFilter(var currRecord: RecordRef; var globalDimeFieldRef: FieldRef)
    var
        dimensionValue: Record "Dimension Value";
        generalLedgerSetup: Record "General Ledger Setup";
        applicationUserSettings: Record "Application User Settings";
        energyPark: Record "Corporation";
        energyParkDimensionMgt: Codeunit "Corporation Dimension Mgt.";
        dimensionValueFilter: Text;
        currentFilterGroup: Integer;
    begin
        AemSetup.GetRecordOnce();
        generalLedgerSetup.Get();

        if generalLedgerSetup."Global Dimension 1 Code" <> AemSetup."Corporation Dimension" then
            exit;

        if applicationUserSettings.Get(UserSecurityId()) then;

        if applicationUserSettings."Active Corporation" = '' then begin
            dimensionValueFilter := BuildUserAssignedDimensionFilter();
        end else begin
            energyPark.Get(applicationUserSettings."Active Corporation");
            dimensionValueFilter := energyPark."Dimension Value";
        end;

        if dimensionValueFilter <> '' then begin
            // currentFilterGroup := currRecord.FilterGroup();
            // currRecord.FilterGroup(6);
            globalDimeFieldRef.SetFilter(dimensionValueFilter);
            // currRecord.FilterGroup(currentFilterGroup);
        end;
    end;

    procedure BuildUserAssignedDimensionFilter() dimensionValueFilter: Text
    var
        userEnergyPark: Record "User Corporation";
        energyPark: Record "Corporation";
    begin
        userEnergyPark.SetRange("User Security ID", UserSecurityId());

        if userEnergyPark.FindSet() then begin
            repeat
                energyPark.Get(userEnergyPark."Corporation No.");
                if energyPark."Dimension Value" <> '' then
                    dimensionValueFilter += energyPark."Dimension Value" + '|';
            until userEnergyPark.Next() = 0;
            dimensionValueFilter := dimensionValueFilter.TrimEnd('|');
        end;
    end;

    local procedure GetShortCutDimension1CodeFieldRef(var currRecord: RecordRef; var globalDimensionFieldRef: FieldRef): Boolean
    var
        tableField: Record Field;
    begin
        tableField.SetRange(TableNo, currRecord.Number());
        tableField.SetRange(FieldName, 'Shortcut Dimension 1 Code');

        if not tableField.FindFirst() then
            exit(false);

        globalDimensionFieldRef := currRecord.Field(tableField."No.");

        exit(true);
    end;

    local procedure GetGlobalDimension1FilterFieldRef(var currRecord: RecordRef; var globalDimensionFilterFieldRef: FieldRef): Boolean
    var
        tableField: Record Field;
    begin
        tableField.SetRange(TableNo, currRecord.Number());
        tableField.SetRange(FieldName, 'Global Dimension 1 Filter');

        if not tableField.FindFirst() then
            exit(false);

        globalDimensionFilterFieldRef := currRecord.Field(tableField."No.");

        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"User Settings", OnAfterGetUserSettings, '', false, false)]
    local procedure OnUserSettingsOnAfterGetUserSettings(var userSettings: Record "User Settings" temporary)
    var
        applicationUserSettings: Record "Application User Settings";
    begin
        AemSetup.GetRecordOnce();

        if not applicationUserSettings.Get(UserSecurityId()) then
            exit;

        userSettings."Active Corporation" := applicationUserSettings."Active Corporation";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"User Settings", OnUpdateUserSettings, '', false, false)]
    local procedure UserSettingsOnUpdateUserSettings(oldSettings: Record "User Settings" temporary; newSettings: Record "User Settings" temporary)
    var
        applicationUserSettings: Record "Application User Settings";
    begin
        if not applicationUserSettings.Get(UserSecurityId()) then
            exit;

        applicationUserSettings."Active Corporation" := newSettings."Active Corporation";
        applicationUserSettings.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", 'OnDatabaseInsert', '', false, false)]
    local procedure OnGlobalTriggersOnDatabaseInsert(recRef: RecordRef)
    var
        globalDimensionFieldRef: FieldRef;
        applicationUserSettings: Record "Application User Settings";
    begin
        if not applicationUserSettings.Get(UserSecurityId()) then
            exit;

        if not GetShortCutDimension1CodeFieldRef(recRef, globalDimensionFieldRef) then
            exit;

        applicationUserSettings.TestField("Active Corporation"); //TODO: Beatiful error message
        globalDimensionFieldRef.Value(applicationUserSettings."Active Corporation");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", GetDatabaseTableTriggerSetup, '', false, false)]
    local procedure GetDatabaseTableTriggerSetup(tableId: Integer; var onDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean)
    begin
        if (tableId = Database::"Purchase Header") or (tableId = Database::"Sales Header") then begin //TODO: List of all tables that need to be updated with the Corporation Dimension
            onDatabaseInsert := true;
        end;
    end;

}