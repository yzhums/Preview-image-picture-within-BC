page 50111 "Preview Files"
{
    Caption = 'Preview';
    Editable = false;
    PageType = Card; //Use new UserControlHost PageType from BC26

    layout
    {
        area(content)
        {
            usercontrol(WebPageViewer; WebPageViewer)
            {
                ApplicationArea = All;
                trigger ControlAddInReady(callbackUrl: Text)
                begin
                    CurrPage.WebPageViewer.SetContent(HTMLText);
                end;

                trigger Callback(data: Text)
                begin
                    CurrPage.Close();
                end;
            }
        }
    }
    var
        HTMLText: Text;

    procedure SetURL(NavigateToURL: Text)
    begin
        HTMLText := NavigateToURL;
    end;
}
