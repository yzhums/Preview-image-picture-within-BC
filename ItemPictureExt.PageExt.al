pageextension 50111 ItemPictureExt extends "Item Picture"
{
    actions
    {
        addafter(ExportFile)
        {
            action(PreviewImage)
            {
                Caption = 'Preview Image';
                ApplicationArea = All;
                Image = View;

                trigger OnAction()
                var
                    PreviewFiles: Page "Preview Files";
                    ItemTenantMedia: Record "Tenant Media";
                    HTMLImgSrcTok: Label 'data:image/%1;base64,%2', Locked = true;
                    HTMLText: Text;
                    Base64String: Text;
                    Base64Convert: Codeunit "Base64 Convert";
                    InStr: InStream;
                begin
                    if Rec.Picture.Count > 0 then begin
                        ItemTenantMedia.Get(Rec.Picture.Item(1));
                        ItemTenantMedia.CalcFields(Content);
                        ItemTenantMedia.Content.CreateInStream(InStr, TextEncoding::UTF8);
                        Base64String := Base64Convert.ToBase64(InStr);
                        HTMLText := '<img src=' + StrSubstNo(HTMLImgSrcTok, 'Jpeg', Base64String) + '>';
                        PreviewFiles.SetURL(HTMLText);
                        PreviewFiles.Run();
                    end;
                end;
            }
        }
    }
}
