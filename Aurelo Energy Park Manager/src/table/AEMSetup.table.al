table 55003 "AEM Setup"
{
    Caption = 'AEM Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }

        field(10; "Corporation Dimension"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Corporation Dimension';
            TableRelation = Dimension.Code;
        }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;

        Get();
        RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;


}