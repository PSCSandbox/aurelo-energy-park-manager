page 55008 "Change Corporation"
{
    Caption = 'Change Corporation';
    Permissions = tabledata "Application User Settings" = RIMD;
    PageType = ConfirmationDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Application User Settings";

    layout
    {
        area(Content)
        {
            field(Name; Rec."Active Corporation")
            {
            }
        }
    }
}