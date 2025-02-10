unit uAddTorrent;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uqBit, uqBit.API, uqBit.API.Types,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmAddTorrent = class(TForm)
    Panel1: TPanel;
    DlgOpenTorrent: TFileOpenDialog;
    Button1: TButton;
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure WMDropFiles(var Msg: TMessage); message WM_DROPFILES;
  public
    { Public declarations }
    qB: TqBit;
    procedure UpdateUI;
  end;
var
  FrmAddTorrent: TFrmAddTorrent;

implementation
{$R *.dfm}
uses ShellAPI, uqBitSelectServerDlg, uqBitAddServerDlg, uqBitAddTorrentDlg, uJX4Object, System.IOUtils;


procedure TFrmAddTorrent.Button1Click(Sender: TObject);
begin
  if DlgOpenTorrent.Execute then
    if qBitAddTorrentDlg.ShowAsModal(qB, DlgOpenTorrent.Files) = mrOk then UpdateUI;
end;

procedure TFrmAddTorrent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qB.Free;
end;

procedure TFrmAddTorrent.FormShow(Sender: TObject);
begin
  DragAcceptFiles (Self.handle, True);

  var Config := TJX4Object.LoadFromJSONFile<TqBitServers>(TPath.GetFileNameWithoutExtension(Application.ExeName) + '.json', TEncoding.UTF8);
  if not assigned(Config) then Config := TqBitServers.Create;
  qBitSelectServerDlg.LoadConfig(Config);

  if qBitSelectServerDlg.ShowModal = mrOk then
  begin
    qBitSelectServerDlg.SaveConfig(Config);
    Config.SaveToJSONFile(TPath.GetFileNameWithoutExtension(Application.ExeName) + '.json', TEncoding.UTF8);

    var Server := qBitSelectServerDlg.GetServer;
    qB := TqBit.Connect(Server.FHP.AsString, Server.FUN.AsString, Server.FPW.AsString);
  end else
    PostMessage(Handle, WM_CLOSE,0 ,0);
  Config.Free;
end;

procedure TFrmAddTorrent.UpdateUI;
begin
  for var NewT in qBitAddTorrentDlg.NewTorrents do
  begin
    Memo1.Lines.Add( TNewTorrentInfo(NewT).Filename + ' : ');
    Memo1.Lines.Add('  ==> ' + TNewTorrentInfo(NewT).FileData.Data.NiceName );
    case TNewTorrentInfo(NewT).Status of
      ntsSuccess:   Memo1.Lines.add('  ==> Success');
      ntsMissing:   Memo1.Lines.add('  ==> Missing');
      ntsInvalid:   Memo1.Lines.add('  ==> Invalid');
      ntsDuplicate: Memo1.Lines.add('  ==> Duplicate');
      ntsError:     Memo1.Lines.add('  ==> Error');
    end;
  end;
end;

procedure TFrmAddTorrent.WMDropFiles(var Msg: TMessage);
var
  hDrop: THandle;
  FileName: WideString;
begin
  var FL := TStringList.Create;
  hDrop:= Msg.wParam;
  var FileCount := DragQueryFile (hDrop , $FFFFFFFF, nil, 0);
  for var i := 0 to FileCount - 1 do
  begin
    var namelen := DragQueryFile(hDrop, I, nil, 0) + 1;
    SetLength(FileName, namelen);
    DragQueryFile(hDrop, I, Pointer(FileName), namelen);
    SetLength(FileName, namelen - 1);
    FL.Add(FileName);
  end;
  if FL.Count > 0 then
    if qBitAddTorrentDlg.ShowAsModal(qB, FL)  = mrOk then UpdateUI;
  FL.Free;
  DragFinish(hDrop);
end;

end.
