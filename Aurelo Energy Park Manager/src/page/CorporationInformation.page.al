page 55003 "Corporation Information"
{
    Permissions = tabledata "Application User Settings" = RIMD;
    AdditionalSearchTerms = 'change experience,suite,user interface,company badge';
    ApplicationArea = All;
    Caption = 'Corporation Information';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Company Information";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Name; Rec.Name)
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the company''s name and corporate form. For example, Inc. or Ltd.';
                }
                field(Address; Rec.Address)
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the company''s address.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field(City; Rec.City)
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the company''s city.';
                }
                group(CountyGroup)
                {
                    ShowCaption = false;
                    Visible = CountyVisible;
                    field(County; Rec.County)
                    {
                        ToolTip = 'Specifies the state, province or county of the company''s address.';
                    }
                }
                field("Post Code"; Rec."Post Code")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the postal code.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {

                    ShowMandatory = true;
                    ToolTip = 'Specifies the country/region of the address.';

                    trigger OnValidate()
                    begin
                        CountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
                    end;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    Caption = 'Contact Name';
                    ToolTip = 'Specifies the name of the contact person in your company.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the company''s telephone number.';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = VAT;
                    ToolTip = 'Specifies the company''s VAT registration number.';

                    trigger OnDrillDown()
                    var
                        VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
                    begin
                        VATRegistrationLogMgt.AssistEditCompanyInfoVATReg();
                    end;

                    trigger OnValidate()
                    var
                        FeatureTelemetry: Codeunit "Feature Telemetry";
                        RegTok: Label 'DACH Include Company Reg. Number On Reports', Locked = true;
                    begin
                        FeatureTelemetry.LogUptake('0001Q0U', RegTok, Enum::"Feature Uptake Status"::Discovered);
                    end;
                }
                field("VAT Representative"; Rec."VAT Representative")
                {
                    ApplicationArea = VAT;
                    ToolTip = 'Specifies the responsible person who will be contacted by the tax authorities when general questions occur.';
                }
                field(GLN; Rec.GLN)
                {
                    ToolTip = 'Specifies your company in connection with electronic document exchange.';
                }
                field("Use GLN in Electronic Document"; Rec."Use GLN in Electronic Document")
                {
                    ToolTip = 'Specifies whether the GLN is used in electronic documents as a party identification number.';
                }
                field("EORI Number"; Rec."EORI Number")
                {
                    ToolTip = 'Specifies the Economic Operators Registration and Identification number that is used when you exchange information with the customs authorities due to trade into or out of the European Union.';
                }
                field("Industrial Classification"; Rec."Industrial Classification")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the company''s industrial classification code.';
                }
                field("Participant No."; Rec."Participant No.")
                {
                    ToolTip = 'Specifies the company registration number for submitting VAT-VIES tax reports electronically.';
                }
                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Specifies the picture that has been set up for the company, such as a company logo.';

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No.2"; Rec."Phone No.")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the company''s telephone number.';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the company''s fax number.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the company''s email address.';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ToolTip = 'Specifies your company''s web site.';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("Allow Blank Payment Info."; Rec."Allow Blank Payment Info.")
                {

                    ToolTip = 'Specifies if you are allowed to create a sales invoice without filling the setup fields on this FastTab.';
                }
                field("Bank Name"; Rec."Bank Name")
                {

                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the bank the company uses.';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {

                    ShowMandatory = IBANMissing;
                    ToolTip = 'Specifies the bank''s branch number.';

                    trigger OnValidate()
                    begin
                        SetShowMandatoryConditions();
                    end;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {

                    ShowMandatory = IBANMissing;
                    ToolTip = 'Specifies the company''s bank account number.';

                    trigger OnValidate()
                    begin
                        SetShowMandatoryConditions();
                    end;
                }
                field("Payment Routing No."; Rec."Payment Routing No.")
                {

                    ToolTip = 'Specifies the company''s payment routing number.';
                }
                field("Giro No."; Rec."Giro No.")
                {

                    ToolTip = 'Specifies the company''s giro number.';
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {

                    ToolTip = 'Specifies the SWIFT code (international bank identifier code) of your primary bank.';

                    trigger OnValidate()
                    begin
                        SetShowMandatoryConditions();
                    end;
                }
                field(IBAN; Rec.IBAN)
                {

                    ShowMandatory = BankBranchNoOrAccountNoMissing;
                    ToolTip = 'Specifies the international bank account number of your primary bank account.';

                    trigger OnValidate()
                    begin
                        SetShowMandatoryConditions();
                    end;
                }
                field(BankAccountPostingGroup; BankAcctPostingGroup)
                {

                    Caption = 'Bank Account Posting Group';
                    Lookup = true;
                    TableRelation = "Bank Account Posting Group".Code;
                    ToolTip = 'Specifies a code for the bank account posting group for the company''s bank account.';

                    trigger OnValidate()
                    var
                        BankAccount: Record "Bank Account";
                    begin
                        CompanyInformationMgt.UpdateCompanyBankAccount(Rec, BankAcctPostingGroup, BankAccount);
                    end;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {

                    ToolTip = 'Specifies the name of the location to which items for the company should be shipped.';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {

                    ToolTip = 'Specifies the address of the location to which items for the company should be shipped.';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {

                    ToolTip = 'Specifies an additional part of the ship-to address, in case it is a long address.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {

                    ToolTip = 'Specifies the city of the company''s ship-to address.';
                }
                group(ShipToCounty)
                {
                    ShowCaption = false;
                    Visible = IsShipToCountyVisible;
                    field("Ship-to County"; Rec."Ship-to County")
                    {

                        Caption = 'Ship-to County';
                        ToolTip = 'Specifies the county of the company''s shipping address.';
                    }
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address that the items are shipped to.';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address that the items are shipped to.';
                    trigger OnValidate()
                    begin
                        IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
                    end;
                }
                field("Ship-to Phone No."; Rec."Ship-to Phone No.")
                {
                    ToolTip = 'Specifies the telephone number of the company''s shipping address.';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the contact person at the address that the items are shipped to.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the location code that corresponds to the company''s ship-to address.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the code for the default responsibility center.';
                }
                field("Check-Avail. Period Calc."; Rec."Check-Avail. Period Calc.")
                {
                    ApplicationArea = OrderPromising;
                    ToolTip = 'Specifies a date formula that defines the length of the period after the planned shipment date on demand lines in which the system checks availability for the demand line in question.';
                }
                field("Check-Avail. Time Bucket"; Rec."Check-Avail. Time Bucket")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies how frequently the system checks supply-demand events to discover if the item on the demand line is available on its shipment date.';
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = Suite;
                    DrillDown = false;
                    ToolTip = 'Specifies the code for the base calendar that you want to assign to your company.';
                }
                field("Customized Calendar"; format(CalendarMgmt.CustomizedChangesExist(Rec)))
                {
                    ApplicationArea = Suite;
                    Caption = 'Customized Calendar';
                    DrillDown = true;
                    Editable = false;
                    ToolTip = 'Specifies whether or not your company has set up a customized calendar.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord();
                        Rec.TestField("Base Calendar Code");
                        CalendarMgmt.ShowCustomizedCalendar(Rec);
                    end;
                }
                field("Cal. Convergence Time Frame"; Rec."Cal. Convergence Time Frame")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies how dates based on calendar and calendar-related documents are calculated.';
                }
            }
            group(Intrastat)
            {
                Caption = 'Intrastat';
                field("Area"; Rec.Area)
                {
                    ToolTip = 'Specifies the area in which your company has to pay sales tax.';
                }
                field("Company No."; Rec."Company No.")
                {
                    ToolTip = 'Specifies the authorized number from Intrastat (XML).';
                }
                field("Agency No."; Rec."Agency No.")
                {
                    ToolTip = 'Specifies the number of the person who is the company contact for Intrastat.';
                }
                field("Special Agreement"; Rec."Special Agreement")
                {
                    ToolTip = 'Specifies the number issued by the Federal Office of Statistics if it is an Intrastat special agreement.';
                }
                field("Sales Authorized No."; Rec."Sales Authorized No.")
                {
                    ToolTip = 'Specifies the authorized number from Intrastat for shipments (ASCII).';
                }
                field("Purch. Authorized No."; Rec."Purch. Authorized No.")
                {
                    ToolTip = 'Specifies the authorized number from Intrastat for receipts (ASCII).';
                }
                field("Statistic No."; Rec."Statistic No.")
                {
                    ToolTip = 'Specifies that a statistic number is issued for the delivery of the Intrastat report in Austria.';
                }
                field("Control No."; Rec."Control No.")
                {
                    ToolTip = 'Specifies that a control number is issued for the delivery of the Intrastat report in Austria.';
                }
                field("DVR Number"; Rec."DVR Number")
                {
                    ToolTip = 'Specifies the DVR number only for information.';
                }
            }
            group("Tax Office")
            {
                Caption = 'Tax Office';
                field("Tax Office Number"; Rec."Tax Office Number")
                {
                    ToolTip = 'Specifies the 4 digits (Germany) or 2 digits (Austria) long number of your tax office.';
                }
                field("Registration No."; Rec."Registration No.")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the company''s registration number. You can enter a maximum of 20 characters, both numbers and letters.';
                }
                field("Tax Office Name"; Rec."Tax Office Name")
                {
                    ToolTip = 'Specifies the name of the responsible tax office.';
                }
                field("Tax Office Address"; Rec."Tax Office Address")
                {
                    ToolTip = 'Specifies the address of the responsible tax office.';
                }
                field("Tax Office Address 2"; Rec."Tax Office Address 2")
                {
                    ToolTip = 'Specifies additional Tax Office Address information.';
                }
                field("Tax Office Post Code"; Rec."Tax Office Post Code")
                {
                    Caption = 'Tax Office Post Code/City';
                    ToolTip = 'Specifies the postal code of the address.';
                }
                field("Tax Office City"; Rec."Tax Office City")
                {
                    ToolTip = 'Specifies the city of the address.';
                }
                field("Tax Office Country/Region Code"; Rec."Tax Office Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                }
                field("Tax Office Area"; Rec."Tax Office Area")
                {
                    ToolTip = 'Specifies areas that show data for each single area.';
                }
            }
            group("System Indicator")
            {
                Caption = 'Company Badge';
                field("Company Badge"; Rec."System Indicator")
                {
                    ApplicationArea = Suite;
                    Caption = 'Company Badge';
                    ToolTip = 'Specifies how you want to use the Company Badge when you are working with different companies of Business Central.';

                    trigger OnValidate()
                    begin
                        SystemIndicatorOnAfterValidate();
                    end;
                }
                field("System Indicator Style"; Rec."System Indicator Style")
                {
                    ApplicationArea = Suite;
                    Caption = 'Company Badge Style';
                    ToolTip = 'Specifies if you want to apply a certain style to the Company Badge. Having different styles on badges can make it easier to recognize the company that you are currently working with.';
                    OptionCaption = 'Dark Blue,Light Blue,Dark Green,Light Green,Dark Yellow,Light Yellow,Red,Orange,Deep Purple,Bright Purple';

                    trigger OnValidate()
                    begin
                        SystemIndicatorOnAfterValidate();
                    end;
                }
                field("System Indicator Text"; SystemIndicatorText)
                {
                    ApplicationArea = Suite;
                    Caption = 'Company Badge Text';
                    Editable = SystemIndicatorTextEditable;
                    ToolTip = 'Specifies text that you want to use in the Company Badge. Only the first 6 characters will be shown in the badge.';

                    trigger OnValidate()
                    begin
                        Rec."Custom System Indicator Text" := SystemIndicatorText;
                        SystemIndicatorOnAfterValidate();
                    end;
                }
            }
            group("User Experience")
            {
                Caption = 'User Experience';
                field(Experience; Experience)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Caption = 'Experience';
                    Editable = false;
                    ToolTip = 'Specifies which UI elements are displayed and which features are available. The setting applies to all users. Essential: Shows all actions and fields for all common business functionality. Premium: Shows all actions and fields for all business functionality, including Manufacturing and Service Management.';

                    trigger OnAssistEdit()
                    var
                        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
                    begin
                        ApplicationAreaMgmtFacade.LookupExperienceTier(Experience);
                    end;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Responsibility Centers")
            {
                ApplicationArea = Advanced;
                Caption = 'Responsibility Centers';
                Image = Position;
                RunObject = Page "Responsibility Center List";
                ToolTip = 'Set up responsibility centers to administer business operations that cover multiple locations, such as a sales offices or a purchasing departments.';
            }
            action("Report Layouts")
            {
                ApplicationArea = Advanced;
                Caption = 'Report Layouts';
                Image = "Report";
                RunObject = Page "Report Layout Selection";
                ToolTip = 'Specify the layout to use on reports when viewing, printing, and saving them. The layout defines things like text font, field placement, or background.';
            }
            group("Application Settings")
            {
                Caption = 'Application Settings';
                group(Setup)
                {
                    Caption = 'Setup';
                    Image = Setup;
                    action("General Ledger Setup")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'General Ledger Setup';
                        Image = JournalSetup;
                        RunObject = Page "General Ledger Setup";
                        ToolTip = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.';
                    }
                    action("Sales & Receivables Setup")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Sales & Receivables Setup';
                        Image = ReceivablesPayablesSetup;
                        RunObject = Page "Sales & Receivables Setup";
                        ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                    }
                    action("Purchases & Payables Setup")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Purchases & Payables Setup';
                        Image = Purchase;
                        RunObject = Page "Purchases & Payables Setup";
                        ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                    }
                    action("Inventory Setup")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Inventory Setup';
                        Image = InventorySetup;
                        RunObject = Page "Inventory Setup";
                        ToolTip = 'Define your general inventory policies, such as whether to allow negative inventory and how to post and adjust item costs. Set up your number series for creating new inventory items or services.';
                    }
                    action("Fixed Assets Setup")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Fixed Assets Setup';
                        Image = FixedAssets;
                        RunObject = Page "Fixed Asset Setup";
                        ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
                    }
                    action("Human Resources Setup")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Human Resources Setup';
                        Image = HRSetup;
                        RunObject = Page "Human Resources Setup";
                        ToolTip = 'Set up number series for creating new employee cards and define if employment time is measured by days or hours.';
                    }
                    action("Jobs Setup")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Projects Setup';
                        Image = Job;
                        RunObject = Page "Jobs Setup";
                        ToolTip = 'Define your accounting policies for projects, such as which WIP method to use and whether to update project item costs automatically.';
                    }
                }
                action("No. Series")
                {
                    ApplicationArea = Advanced;
                    Caption = 'No. Series';
                    Image = NumberSetup;
                    RunObject = Page "No. Series";
                    ToolTip = 'Set up the number series from which a new number is automatically assigned to new cards and documents, such as item cards and sales invoices.';
                }
            }
            group("System Settings")
            {
                Caption = 'System Settings';
                action(Users)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Users';
                    Image = Users;
                    RunObject = Page Users;
                    ToolTip = 'Set up the employees who will work in this company.';
                }
                action("Permission Sets")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Permission Sets';
                    Image = Permission;
                    RunObject = Page "Permission Sets";
                    ToolTip = 'View or edit which feature objects that users need to access and set up the related permissions in permission sets that you can assign to the users of the database.';
                }
            }
            group(Currencies)
            {
                Caption = 'Currencies';
                action(Action27)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Currencies';
                    Image = Currencies;
                    RunObject = Page Currencies;
                    ToolTip = 'Set up the different currencies that you trade in by defining which general ledger accounts the involved transactions are posted to and how the foreign currency amounts are rounded.';
                }
            }
            group("Regional Settings")
            {
                Caption = 'Regional Settings';
                action("Countries/Regions")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Countries/Regions';
                    Image = CountryRegion;
                    RunObject = Page "Countries/Regions";
                    ToolTip = 'Set up the country/regions where your different business partners are located, so that you can assign Country/Region codes to business partners where special local procedures are required.';
                }
                action("Post Codes")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Post Codes';
                    Image = MailSetup;
                    RunObject = Page "Post Codes";
                    ToolTip = 'Set up the post codes of cities where your business partners are located.';
                }
                action("Online Map Setup")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Online Map Setup';
                    Image = MapSetup;
                    RunObject = Page "Online Map Setup";
                    ToolTip = 'Define which map provider to use and how routes and distances are displayed when you choose the Online Map field on business documents.';
                }
                action(Languages)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Languages';
                    Image = Language;
                    RunObject = Page Languages;
                    ToolTip = 'Set up the languages that are spoken by your different business partners, so that you can print item names or descriptions in the relevant language.';
                }
            }
            group(Codes)
            {
                Caption = 'Codes';
                action("Source Codes")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Source Codes';
                    Image = CodesList;
                    RunObject = Page "Source Codes";
                    ToolTip = 'Set up codes for your different types of business transactions, so that you can track the source of the transactions in an audit.';
                }
                action("Reason Codes")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Reason Codes';
                    Image = CodesList;
                    RunObject = Page "Reason Codes";
                    ToolTip = 'View or set up codes that specify reasons why entries were created, such as Return, to specify why a purchase credit memo was posted.';
                }
            }
        }
        area(Promoted)
        {
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';

                actionref("Report Layouts_Promoted"; "Report Layouts")
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Application Settings', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref("General Ledger Setup_Promoted"; "General Ledger Setup")
                {
                }
                actionref("No. Series_Promoted"; "No. Series")
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'System Settings', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(Users_Promoted; Users)
                {
                }
            }
            group(Category_Category6)
            {
                Caption = 'Currencies', Comment = 'Generated from the PromotedActionCategories property index 5.';

                actionref(Action27_Promoted; Action27)
                {
                }
            }
            group(Category_Category7)
            {
                Caption = 'Codes', Comment = 'Generated from the PromotedActionCategories property index 6.';

                actionref(Languages_Promoted; Languages)
                {
                }
            }
            group(Category_Category8)
            {
                Caption = 'Regional Settings', Comment = 'Generated from the PromotedActionCategories property index 7.';

                actionref("Post Codes_Promoted"; "Post Codes")
                {
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateSystemIndicator();
    end;

    trigger OnClosePage()
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.SaveExperienceTierCurrentCompany(Experience) then
            RestartSession();

        if SystemIndicatorChanged then begin
            Message(CompanyBadgeRefreshPageTxt);
            RestartSession();
        end;
    end;

    trigger OnInit()
    begin
        SetShowMandatoryConditions();
    end;

    trigger OnOpenPage()
    var
        applicationUserSettings: Record "Application User Settings";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        MonitorSensitiveField: Codeunit "Monitor Sensitive Field";
    begin
        if Rec.GetFilter("Primary Key") = '' then begin
            applicationUserSettings.Get(UserSecurityId());
            Rec.Get(applicationUserSettings."Active Corporation");
        end;

        ActivateFields();
        ApplicationAreaMgmtFacade.GetExperienceTierCurrentCompany(Experience);
        MonitorSensitiveField.ShowPromoteMonitorSensitiveFieldNotification();

        BankAcctPostingGroup := CompanyInformationMgt.GetCompanyBankAccountPostingGroup();
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        CompanyInformationMgt: Codeunit "Company Information Mgt.";
        FormatAddress: Codeunit "Format Address";
        Experience: Text;
        SystemIndicatorText: Code[6];
        SystemIndicatorTextEditable: Boolean;
        IBANMissing: Boolean;
        BankBranchNoOrAccountNoMissing: Boolean;
        BankAcctPostingGroup: Code[20];
        CountyVisible: Boolean;
        IsShipToCountyVisible: Boolean;
        CompanyBadgeRefreshPageTxt: Label 'The Company Badge settings have changed. Refresh the browser (Ctrl+F5) to update the badge.';
        CompanyBadgeChangedLbl: Label 'The Company badge settings have changed by UserSecurityId %1.', Locked = true;

    protected var
        SystemIndicatorChanged: Boolean;

    local procedure UpdateSystemIndicator()
    var
        CustomSystemIndicatorText: Text[250];
        IndicatorStyle: Option;
    begin
        Rec.GetSystemIndicator(CustomSystemIndicatorText, IndicatorStyle); // IndicatorStyle is not used
        SystemIndicatorText := CopyStr(CustomSystemIndicatorText, 1, 6);
        SystemIndicatorTextEditable := CurrPage.Editable and (Rec."System Indicator" = Rec."System Indicator"::"Custom");
    end;

    local procedure SystemIndicatorOnAfterValidate()
    var
        CompanyBadgeChangedLbl: Label 'Company badge changed.', Locked = true;
    begin
        SystemIndicatorChanged := true;
        UpdateSystemIndicator();
    end;

    local procedure ActivateFields()
    begin
        CountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
        IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
    end;

    local procedure SetShowMandatoryConditions()
    begin
        BankBranchNoOrAccountNoMissing := (Rec."Bank Branch No." = '') or (Rec."Bank Account No." = '');
        IBANMissing := Rec.IBAN = ''
    end;

    local procedure RestartSession()
    var
        SessionSetting: SessionSettings;
    begin
        SessionSetting.Init();
        SessionSetting.RequestSessionUpdate(false);
    end;
}

