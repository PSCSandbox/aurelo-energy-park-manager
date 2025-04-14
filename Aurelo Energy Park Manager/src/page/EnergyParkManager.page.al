page 55005 "Energy Park Manager"
{
    ApplicationArea = All;
    PageType = RoleCenter;
    Caption = 'Energy Park Manager';

    layout
    {
        area(RoleCenter)
        {
            part(Headline; "Headline Energy Park Manager")
            {
            }
            part(Activities; "Energy Park Manager Activities")
            {
            }
            part("Power BI Report Spinner Part"; "Power BI Embedded Report Part")
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ChangeEnergyPark)
            {
                Caption = 'Change Corporation';
                ToolTip = 'Change the active Corporation';
                Image = SwitchCompanies;
                RunObject = page "Change Corporation";
            }
            action(EnergyParkInfo)
            {
                Caption = 'Corporation Information';
                ToolTip = 'Show Information';
                Image = CompanyInformation;
                RunObject = page "Corporation Information";
            }
        }

        area(Sections)
        {
            group(Setup)
            {
                action("Aurelo Energy Park Manager Setup")
                {
                    RunPageMode = view;
                    Caption = 'Aurelo Energy Park Manager Setup';
                    ToolTip = 'Setup the Aurelo Energy Park Manager';
                    Image = List;
                    RunObject = page "AEM Setup";
                }
                action("Corporations")
                {
                    RunPageMode = view;
                    Caption = 'Corporations';
                    ToolTip = 'Show all Corporations';
                    Image = List;
                    RunObject = page "Corporations";
                }
            }
        }
    }

}