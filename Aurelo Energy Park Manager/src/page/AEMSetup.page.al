page 55009 "AEM Setup"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "AEM Setup";
    Caption = 'Aurelo Energy Park Manager Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Energy Park Company Dimension"; Rec."Corporation Dimension")
                {
                    Caption = 'Corporation Company Dimension';
                    TableRelation = Dimension.Code;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;
}
