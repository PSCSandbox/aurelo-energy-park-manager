pageextension 55005 "Ext Sales Order List" extends "Sales Order List"
{
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