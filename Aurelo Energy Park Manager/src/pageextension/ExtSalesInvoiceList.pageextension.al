pageextension 55000 "Ext Sales Invoice List" extends "Sales Invoice List"
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