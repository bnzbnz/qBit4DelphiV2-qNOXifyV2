unit uqBitAddServerDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  uqBit.API.Types, uqBit.API, uqBit, Vcl.Mask;

type

  TqBitAddServerDlg = class(TForm)
    Bevel1: TBevel;
    BtnOK: TButton;
    BtnCancel: TButton;
    HP: TLabeledEdit;
    UN: TLabeledEdit;
    PW: TLabeledEdit;
    procedure BtnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  qBitAddServerDlg: TqBitAddServerDlg;

implementation

{$R *.dfm}

procedure TqBitAddServerDlg.BtnOKClick(Sender: TObject);
begin
  BtnOK.Caption := '...Checking...'; BtnOK.Enabled := False;
  ModalResult := mrNone;
  var qB := TqBit.Connect(HP.Text, UN.Text, PW.Text);
  if assigned(qB) then
  begin
    if not qB.qBitCheckWebAPICompatibility then
      ShowMessage('Server API version is not compatible...')
    else
      ModalResult := mrOK
  end else
    ShowMessage('Cannot connect to : ' + HP.Text);
  qB.Free;
  BtnOK.Caption := 'Ok'; BtnOK.Enabled := True;
end;

end.
