page 55006 "Headline Energy Park Manager"
{
    Permissions = tabledata "Application User Settings" = RIMD;
    Caption = 'Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(EnergyParkHeadline)
            {
                ShowCaption = false;
                Visible = UserGreetingVisible;
                field(GreetingText; GetGreetingText())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Greeting headline';
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"Headline RC Project Manager");
        DefaultFieldsVisible := RCHeadlinesPageCommon.AreDefaultFieldsVisible();
        UserGreetingVisible := RCHeadlinesPageCommon.IsUserGreetingVisible();
    end;

    local procedure GetGreetingText(): Text[250]
    var
        applicationUserSettings: Record "Application User Settings";
        energyPark: Record "Corporation";
        greetingLbl: Label 'Welcome to Corporation ~%1~', Comment = 'Corporation Name';
    begin
        if applicationUserSettings.Get(UserSecurityId()) then;
        if energyPark.Get(applicationUserSettings."Active Corporation") then;

        exit(StrSubstNo(greetingLbl, energyPark.Name));
    end;

    var
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";
        DefaultFieldsVisible: Boolean;
        UserGreetingVisible: Boolean;
}

