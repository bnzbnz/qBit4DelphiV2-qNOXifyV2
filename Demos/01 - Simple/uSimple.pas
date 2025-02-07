unit uSimple;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uJX4Object, uqBit, uqBit.API, uqBit.API.Types,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmSimple = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    LinkLabel1: TLinkLabel;
    LBTorrents: TListBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure LinkLabel1LinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
  private
    { Private declarations }
  public
    { Public declarations }
    qB: TqBit;
    qBMain: TqBitMainDataType;
    procedure UpdateUI;
  end;
var
  FrmSimple: TFrmSimple;

implementation
{$R *.dfm}
uses
    ShellAPI
  , uJX4Value
  , uqBitSelectServerDlg
  , System.IOUtils
  ;

procedure TFrmSimple.LinkLabel1LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
begin
  ShellExecute(0, 'Open', PChar(Link), PChar(''), nil, SW_SHOWNORMAL);
end;

procedure TFrmSimple.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qBMain.Free;
  qB.Free;
end;

procedure TFrmSimple.FormShow(Sender: TObject);
begin
  var Config := TJX4Object.LoadFromFile<TqBitServers>(TPath.GetFileNameWithoutExtension(Application.ExeName) + '.json', TEncoding.UTF8);
  if not assigned(Config) then Config := TqBitServers.Create;
  qBitSelectServerDlg.LoadConfig(Config);

  if qBitSelectServerDlg.Showmodal <> mrOK then
  begin
    PostMessage(Handle, WM_CLOSE,0 ,0);
    Config.Free;
    Exit;
  end;

  qBitSelectServerDlg.SaveConfig(Config);
  Config.SaveToFile(TPath.GetFileNameWithoutExtension(Application.ExeName) + '.json', TEncoding.UTF8);
  Config.Free;

  var Server := qBitSelectServerDlg.GetServer;
  qB := TqBit.Connect(Server.FHP.AsString, Server.FUN.AsString, Server.FPW.AsString);
  qBMain := qB.GetMainData(0); // >> Full Data
  UpdateUI;
  Timer1.Interval := qBMain.server_state.refresh_interval.AsInteger; // The update interval is defined by the server
  Timer1.Enabled := True;
end;

procedure TFrmSimple.UpdateUI;
begin
  ////////////////  Few Properties...
  Caption := Format('Torrents : %d', [qBMain.torrents.Count]);
  Caption := Caption + ' / ';
  Caption := Caption + Format('Dl : %s/s', [qBMain.server_state.dl_info_speed.ToBKiBMiB]);
  Caption := Caption + ' / ';
  Caption := Caption + Format('Up : %s/s', [qBMain.server_state.up_info_speed.ToBKiBMiB]);
  LBTorrents.Clear;
  for var T in qBMain.torrents do
    LBTorrents.Items.Add(Format(
      '%s %s',
      [TqBitTorrentType(T.Value).name.AsString, TqBitTorrentType(T.Value).progress.ToPercent]
    ));
end;

procedure TFrmSimple.Timer1Timer(Sender: TObject);
begin
  var Update := qb.GetMainData(qBMain.rid.AsInteger); // >> Get The Data since the last getMainData
  if Update <> Nil then
  begin
    qBMain.Merge(Update); // we merge the update : qBMain is now up to date
  end else begin
    Timer1.Enabled := False;
    LBTorrents.Clear;
    LBTorrents.Items.Add('Disconnected...');
    Exit;
  end;
  Update.Free;
  UpdateUI;
end;

end.
