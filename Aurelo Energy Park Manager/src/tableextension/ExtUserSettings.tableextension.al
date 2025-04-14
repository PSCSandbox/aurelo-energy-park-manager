tableextension 55001 "Ext User Settings" extends "User Settings"
{
    fields
    {
        field(50000; "Active Corporation"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Active Corporation';
            TableRelation = "Corporation"."No.";
        }
    }
}