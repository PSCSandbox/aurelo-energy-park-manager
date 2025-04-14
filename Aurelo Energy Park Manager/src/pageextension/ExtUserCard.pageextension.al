pageextension 55001 "Ext User Card" extends "User Card"
{
    actions
    {
        addlast(processing)
        {
            action("User Corporations")
            {
                Caption = 'Corporations';
                ApplicationArea = All;
                Image = Company;
                RunObject = page "User Corporations";
                RunPageLink = "User Security ID" = field("User Security ID");
            }
        }
        addafter("Sent Emails_Promoted")
        {
            actionref(UserEnergyParksPromoted; "User Corporations")
            {
            }
        }
    }
}
