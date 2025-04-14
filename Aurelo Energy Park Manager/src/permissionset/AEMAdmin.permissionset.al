permissionset 55000 "AEM-Admin"
{
    Assignable = true;
    Permissions = tabledata "AEM Setup" = RIMD,
        tabledata Corporation = RIMD,
        tabledata "Energy Park Cue" = RIMD,
        tabledata "User Corporation" = RIMD,
        table "AEM Setup" = X,
        table Corporation = X,
        table "Energy Park Cue" = X,
        table "User Corporation" = X;
}