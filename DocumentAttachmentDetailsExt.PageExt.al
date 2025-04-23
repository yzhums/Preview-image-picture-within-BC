pageextension 50110 DocumentAttachmentDetailsExt extends "Document Attachment Details"
{
    actions
    {
        addafter(Preview_Promoted)
        {
            actionref(PreviewImage_Promoted; PreviewImage)
            {
            }
        }
        addfirst(processing)
        {
            action(PreviewImage)
            {
                Caption = 'Preview Image';
                ApplicationArea = All;
                Image = View;

                trigger OnAction()
                var
                    PreviewFiles: Page "Preview Files";
                    DocAttach: Record "Document Attachment";
                    HTMLImgSrcTok: Label 'data:image/%1;base64,%2', Locked = true;
                    HTMLText: Text;
                    Base64String: Text;
                    Base64Convert: Codeunit "Base64 Convert";
                    InStr: InStream;
                    OutStr: OutStream;
                    TempBlob: Codeunit "Temp Blob";
                begin
                    DocAttach.Reset();
                    CurrPage.SetSelectionFilter(DocAttach);
                    if DocAttach.FindFirst() then
                        if DocAttach."Document Reference ID".HasValue then begin
                            TempBlob.CreateOutStream(OutStr);
                            DocAttach."Document Reference ID".ExportStream(OutStr);
                            TempBlob.CreateInStream(InStr);
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
