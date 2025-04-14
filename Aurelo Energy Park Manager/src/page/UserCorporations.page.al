page 55000 "User Corporations"
{
    ApplicationArea = All;
    Caption = 'User Corporations';
    PageType = List;
    SourceTable = "User Corporation";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Corporation No."; Rec."Corporation No.")
                {
                }
                field("Corporation Name"; Rec."Corporation Name")
                {
                }
            }
        }
    }
}
