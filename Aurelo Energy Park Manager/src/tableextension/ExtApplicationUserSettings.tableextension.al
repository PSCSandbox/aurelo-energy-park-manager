tableextension 55002 "Ext Application User Settings" extends "Application User Settings"
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