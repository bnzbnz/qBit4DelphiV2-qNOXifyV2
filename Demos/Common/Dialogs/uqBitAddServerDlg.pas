unit uqBitAddServerDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  uqBit.API.Types, uqBit.API, uqBit, Vcl.Mask, Vcl.ComCtrls;

type

  TqBitAddServerDlg = class(TForm)
    Bevel1: TBevel;
    BtnOK: TButton;
    BtnCancel: TButton;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    HP: TLabeledEdit;
    UN: TLabeledEdit;
    PW: TLabeledEdit;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button2: TButton;
    FileOpenDialog1: TFileOpenDialog;
    TabSheet1: TTabSheet;
    Label6: TLabel;
    Edit5: TEdit;
    Memo2: TMemo;
    Label7: TLabel;
    Edit6: TEdit;
    procedure BtnOKClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  qBitAddServerDlg: TqBitAddServerDlg;

implementation
uses tgputtysftp, uVnStatClient;

{$R *.dfm}

procedure TqBitAddServerDlg.BtnOKClick(Sender: TObject);
begin
  BtnOK.Caption := '...Checking...'; BtnOK.Enabled := False;
  ModalResult := mrNone;
  var qB := TqBit.Connect(HP.Text, UN.Text, PW.Text);
  try
  if not Assigned(qB) then   begin
    ShowMessage('Cannot connect to qBit/Nox server at ' + HP.Text);
    Exit;
  end;
  if assigned(qB) then
  begin
    if not qB.qBitCheckWebAPICompatibility then
    begin
      ShowMessage('qBit/Nox server API version is not compatible...');
      exit;
    end else ModalResult := mrOK;
  end;
  if (ModalResult = mrOK) and (Edit5.Text<>'')then
  begin
    ModalResult := mrNone;
    var vn := TvnStatClient.FromURL(Edit5.Text);
    var Intf: TvnsInterface := Nil;
    if Assigned(vn) then Intf := vn.GetInterface(Edit6.Text);
    if not Assigned(vn) or not Assigned(Intf) then
      ShowMessage('VnStat : Cannot connect to ' + Edit5.Text)
    else
      ModalResult := mrOK;
    vn.Free;
  end;
  finally
    BtnOK.Caption := 'Ok'; BtnOK.Enabled := True;
    qB.Free;
  end
end;

procedure TqBitAddServerDlg.Button1Click(Sender: TObject);
begin
  var SFTP: TTGPuttySFTP := TTGPuttySFTP.Create(False);
  SFTP.HostName:=Utf8Encode(Edit1.Text);
  SFTP.Port:=StrToIntDef(Edit2.Text, 22);
  SFTP.UserName:=Utf8Encode(Edit3.Text);
  SFTP.Keyfile:=Utf8Encode(Edit4.Text);
  SFTP.Connect;
  if not SFTP.Connected then
    ShowMessage('Cannot connect to : ' + SFTP.HostName)
  else
    ShowMessage('Connected Successfully');
  SFTP.Free;
end;

procedure TqBitAddServerDlg.Button2Click(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
    Edit4.Text := FileOpenDialog1.FileName
end;

procedure TqBitAddServerDlg.FormShow(Sender: TObject);
begin
  Self.PageControl2.ActivePage := TabSheet3;
end;

end.

