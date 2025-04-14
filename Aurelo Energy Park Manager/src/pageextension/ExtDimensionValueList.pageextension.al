pageextension 55002 "Ext Dimension Value List" extends "Dimension Value List"
{
    trigger OnOpenPage()
    var
        aemSetup: Record "AEM Setup";
        generalLedgerSetup: Record "General Ledger Setup";
        energyParkDimensionMgt: Codeunit "Corporation Dimension Mgt.";
    begin
        aemSetup.GetRecordOnce();
        generalLedgerSetup.Get();

        if generalLedgerSetup."Global Dimension 1 Code" <> aemSetup."Corporation Dimension" then
            exit;

        if (Rec.GetFilter("Global Dimension No.") = '1') then
            Rec.SetFilter(Code, energyParkDimensionMgt.BuildUserAssignedDimensionFilter());
    end;
}