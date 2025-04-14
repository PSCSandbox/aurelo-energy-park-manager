page 55007 "Energy Park Manager Activities"
{
    Permissions = tabledata "Application User Settings" = RIMD;
    ApplicationArea = All;
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Energy Park Cue";

    layout
    {
        area(content)
        {
            cuegroup(Invoicing)
            {
                Caption = 'Invoicing';
                field("Purchase Invoices"; Rec."Purchase Invoices")
                {
                    DrillDownPageID = "Purchase Invoices";
                }
                field("Sales Invoices"; Rec."Sales Invoices")
                {
                    DrillDownPageID = "Sales Invoice List";
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        applicationUserSettings: Record "Application User Settings";
        energyPark: Record "Corporation";
    begin
        if applicationUserSettings.Get(UserSecurityId()) then;
        if energyPark.Get(applicationUserSettings."Active Corporation") then;

        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.SetFilter("Dimension Filter", energyPark."Dimension Value");
    end;

}