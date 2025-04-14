table 55000 "Corporation"
{
    Caption = 'Corporation';
    DataClassification = CustomerContent;
    LookupPageId = "Corporations";
    DrillDownPageId = "Corporation Card";
    DataCaptionFields = Type, Name;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(15; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Company,Group;
            OptionCaption = 'Energy Park, Management';
        }
        field(10; "Name"; Text[100])
        {
            Caption = 'Name';
        }
        field(20; "Corporation Dimension"; Code[20])
        {
            Caption = 'Corporation Dimension';
            TableRelation = Dimension.Code;
        }
        field(30; "Dimension Value"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Corporation Dimension"));
            Caption = 'Dimension Value';
        }
        field(1000; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(5000; "Posted Sales Invoice Nos."; Code[20])
        {
            Caption = 'Posted Sales Invoice Nos.';
            TableRelation = "No. Series";
            ToolTip = 'Specifies the code for the number series that will be used to assign numbers to posted sales invoices.';
        }
        field(5010; "Posted Sales Credit Memo Nos."; Code[20])
        {
            Caption = 'Posted Sales Credit Memo Nos.';
            TableRelation = "No. Series";
            ToolTip = 'Specifies the code for the number series that will be used to assign numbers to posted sales credit memos.';
        }
        field(5020; "Posted Purch. Invoice Nos."; Code[20])
        {
            Caption = 'Posted Purchase Invoice Nos.';
            TableRelation = "No. Series";
            ToolTip = 'Specifies the code for the number series that will be used to assign numbers to posted purchase invoices.';
        }
        field(5030; "Posted Purch. Credit Memo Nos."; Code[20])
        {
            Caption = 'Posted Purchase Credit Memo Nos.';
            TableRelation = "No. Series";
            ToolTip = 'Specifies the code for the number series that will be used to assign numbers to posted purchase credit memos.';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "No.", Name, Image)
        {
        }
    }

    var
        PostCode: Record "Post Code";
}