pageextension 55008 "Ext Users" extends Users
{
    actions
    {
        addlast(navigation)
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
        addafter("Update users from Office_Promoted")
        {
            actionref(UserEnergyParksPromoted; "User Corporations")
            {
            }
        }
    }
}