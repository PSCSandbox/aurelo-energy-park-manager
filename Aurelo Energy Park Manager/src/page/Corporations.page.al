/// <summary>
/// Lists all corporations.
/// </summary>
page 55001 "Corporations"
{
    ApplicationArea = All;
    Caption = 'Corporations';
    PageType = List;
    SourceTable = "Corporation";
    UsageCategory = Administration;
    Editable = false;
    CardPageId = "Corporation Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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

}
