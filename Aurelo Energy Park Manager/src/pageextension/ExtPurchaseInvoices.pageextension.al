pageextension 55003 "Ext Purchase Invoices" extends "Purchase Invoices"
{
    layout
    {
        movefirst(Control1; "Shortcut Dimension 1 Code")
    }

    trigger OnOpenPage()
    var
        energyParkDimensionMgt: Codeunit "Corporation Dimension Mgt.";
        currRecord: RecordRef;
    begin
        currRecord.GetTable(Rec);
        energyParkDimensionMgt.BuildUserAssignedDimensionFilter(currRecord);
        currRecord.SetTable(Rec);
    end;
}