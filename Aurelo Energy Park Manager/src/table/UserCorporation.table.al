table 55001 "User Corporation"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User Security ID"; Guid)
        {
            TableRelation = User."User Security ID";
            Caption = 'User Security ID';
        }
        field(2; "Corporation No."; Code[20])
        {
            TableRelation = "Corporation"."No.";
            Caption = 'Corporation No.';
        }
        field(3; "Corporation Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Corporation"."Name" where("No." = field("Corporation No.")));
            Caption = 'Corporation Name';
            Editable = false;
        }
        field(4; "Corporation Image"; Media)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Corporation".Image where("No." = field("Corporation No.")));
            Caption = 'Corporation Image';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "User Security ID", "Corporation No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(Brick; "Corporation Name", "Corporation Image")
        {
        }
    }
}