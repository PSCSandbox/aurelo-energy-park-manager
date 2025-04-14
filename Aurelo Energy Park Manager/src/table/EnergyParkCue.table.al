table 55002 "Energy Park Cue"
{
    Caption = 'Corporation Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
        }
        field(10; "Purchase Invoices"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Invoice), "Shortcut Dimension 1 Code" = field("Dimension Filter")));
            Caption = 'Purchase Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Sales Invoices"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Invoice), "Shortcut Dimension 1 Code" = field("Dimension Filter")));
            Caption = 'Sales Invoices';
            Editable = false;
            FieldClass = FlowField;
        }

        field(30; "Dimension Filter"; Code[20])
        {
            Caption = 'Dimension Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}

