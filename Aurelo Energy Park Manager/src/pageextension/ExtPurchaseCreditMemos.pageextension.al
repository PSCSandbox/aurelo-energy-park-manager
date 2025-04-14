pageextension 55006 "Ext Purchase Credit Memos" extends "Purchase Credit Memos"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }

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