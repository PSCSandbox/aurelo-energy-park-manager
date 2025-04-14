pageextension 55007 "Ext User Settings" extends "User Settings"
{
    layout
    {
        addlast("User Settings")
        {
            field("Active Corporation"; Rec."Active Corporation")
            {
                ApplicationArea = All;
            }

        }
    }

}