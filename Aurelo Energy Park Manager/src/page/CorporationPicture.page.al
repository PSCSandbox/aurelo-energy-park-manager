page 55004 "Corporation Picture"
{
    ApplicationArea = All;
    Caption = 'Corporation Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Corporation";

    layout
    {
        area(content)
        {
            field(Picture; Rec.Image)
            {
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the Corporation.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                Caption = 'Take';
                Image = Camera;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportPicture)
            {
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                begin
                    ImportFromDevice();
                end;
            }
            action(DeletePicture)
            {
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                begin
                    DeleteItemPicture();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    var
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;
        MustSpecifyNameErr: Label 'You must add a name to the Corporation before you can import a picture.';

    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
        InStr: InStream;
    begin
        Rec.Find();
        Rec.TestField("No.");
        if Rec.Name = '' then
            Error(MustSpecifyNameErr);

        if Rec.Image.HasValue() then
            if not Confirm(OverrideImageQst) then
                Error('');

        ClientFileName := '';
        UploadIntoStream(SelectPictureTxt, '', '', ClientFileName, InStr);
        if ClientFileName <> '' then
            FileName := FileManagement.GetFileName(ClientFileName);
        if FileName = '' then
            Error('');

        Clear(Rec.Image);
        Rec.Image.ImportStream(InStr, FileName);
        Rec.Modify(true);
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Image.HasValue();
    end;

    procedure DeleteItemPicture()
    begin
        Rec.TestField("No.");

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec.Image);
        Rec.Modify(true);
    end;

    procedure TakeNewPicture()
    var
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        MimeTypeTok: Label 'image/jpeg', Locked = true;
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.TestField("No.");
        Rec.TestField(Name);

        if Rec.Image.HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec.Image);
            Rec.Image.ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true)
        end;
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;
}
