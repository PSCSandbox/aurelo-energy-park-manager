pageextension 55000 "Ext Customer List" extends "Customer List"
{
    trigger OnOpenPage()
    var
        energyParkDimensionMgt: Codeunit "Corporation Dimension Mgt.";
        currRecord: RecordRef;
    begin
        currRecord.GetTable(Rec);
        energyParkDimensionMgt.BuildUserAssignedDimensionFlowFilter(currRecord);
        currRecord.SetTable(Rec);
    end;
}