page 55002 "Corporation Card"
{
    ApplicationArea = All;
    Caption = 'Corporation Card';
    PageType = Card;
    SourceTable = "Corporation";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Dimension Value"; Rec."Dimension Value")
                {
                }
            }
            group("No. Series")
            {
                Caption = 'No. Series';

                group(Sales)
                {
                    Caption = 'Sales';
                    field("Posted Sales Invoice Nos."; Rec."Posted Sales Invoice Nos.")
                    {
                    }
                    field("Posted Sales Credit Memo Nos."; Rec."Posted Sales Credit Memo Nos.")
                    {
                    }
                }
                group(Purchase)
                {
                    Caption = 'Purchase';

                    field("Posted Purch. Invoice Nos."; Rec."Posted Purch. Invoice Nos.")
                    {
                    }
                    field("Posted Purch. Credit Memo Nos."; Rec."Posted Purch. Credit Memo Nos.")
                    {
                    }
                }
            }
        }
        area(FactBoxes)
        {
            part(ImageFactBox; "Corporation Picture")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(CompanyInfo)
            {
                Caption = 'Company Information';
                Image = Company;

                trigger OnAction()
                var
                    companyInfo: Record "Company Information";
                    energyParkInformation: Page "Corporation Information";
                begin
                    if not companyInfo.Get(Rec."No.") then begin
                        companyInfo."Primary Key" := Rec."No.";
                        companyInfo.Name := Rec.Name;
                        companyInfo.Insert();
                        Commit();
                    end;

                    companyInfo.SetRecFilter();

                    energyParkInformation.SetTableView(companyInfo);
                    energyParkInformation.RunModal();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(CompanyInfoRef; CompanyInfo)
                {
                }
            }
        }
    }

    trigger OnNewRecord(belowxRec: Boolean)
    var
        aemSetup: Record "AEM Setup";
    begin
        aemSetup.GetRecordOnce();
        Rec."Corporation Dimension" := aemSetup."Corporation Dimension";
    end;
}
