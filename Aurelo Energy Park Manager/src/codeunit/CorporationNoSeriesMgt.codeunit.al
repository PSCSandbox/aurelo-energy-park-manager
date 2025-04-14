codeunit 55001 "Corporation No. Series Mgt."
{
    Permissions = tabledata "User Settings" = RIMD, tabledata "Application User Settings" = RIMD;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterInitPostingNoSeries, '', false, false)]
    local procedure OnSalesHeaderOnBeforeGetPostingNoSeriesCode(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        energyPark: Record "Corporation";
    begin
        energyPark.SetRange("Dimension Value", SalesHeader."Shortcut Dimension 1 Code");

        if not energyPark.FindFirst() then
            exit;

        if SalesHeader.IsCreditDocType() then
            SalesHeader."Posting No. Series" := energyPark."Posted Sales Credit Memo Nos."
        else
            SalesHeader."Posting No. Series" := energyPark."Posted Sales Invoice Nos.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterInitPostingNoSeries, '', false, false)]
    local procedure OnPurchaseHeaderOnBeforeGetPostingNoSeriesCode(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    var
        applicationUserSettings: Record "Application User Settings";
        energyPark: Record "Corporation";
    begin
        if not applicationUserSettings.Get(UserSecurityId()) then
            exit;

        energyPark.Get(applicationUserSettings."Active Corporation");

        if PurchaseHeader.IsCreditDocType() then
            PurchaseHeader."Posting No. Series" := energyPark."Posted Purch. Credit Memo Nos."
        else
            PurchaseHeader."Posting No. Series" := energyPark."Posted Purch. Invoice Nos.";
    end;

}