unit uSimpleThreaded;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls
  , uqBit, uqBit.API, uqBit.API.Types;
type
  TqBitThread = class(TThread)
    qB: TqBit;
    qBMainTh: TqBitMainDataType;
    procedure Execute; override;
    destructor Destroy; override;
  end;
  TFrmSimpleThreaded = class(TForm)
    LBTorrents: TListBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    qBMain: TqBitMainDataType;
    Th: TqBitThread;
    procedure SyncThread(Sender: TqBitThread);
    procedure Disconnected(Sender: TqBitThread);
    procedure UpdateUI;
  end;
var
  FrmSimpleThreaded: TFrmSimpleThreaded;
implementation
{$R *.dfm}
uses uqBitSelectServerDlg, uJX4Object;
{ TqBitThread }
destructor TqBitThread.Destroy;
begin
  qB.Free;
  inherited;
end;
procedure TqBitThread.Execute;
begin
  qBMainTh := qB.GetMainData(0); // Full server data update
  while not Terminated do
  begin
    var tme := GetTickCount;
    var U := qB.GetMainData(qBMainTh.rid.AsInteger); // get differential data from last call
    if U = Nil then
    begin
      Synchronize(
        procedure
        begin
          FrmSimpleThreaded.Disconnected(Self);
        end);
      Terminate;
    end else begin
      qBMainTh.Merge(U); // Merge to qBMain to be uodate to date
      U.Free;
      Synchronize(
        procedure
        begin
          FrmSimpleThreaded.SyncThread(Self);
        end
      );
    end;
    while
      (GetTickCount - Tme < qBMainTh.server_state.refresh_interval.AsInt64)
      and (not Terminated)
    do
      Sleep(100);
  end;
  qBMainTh.Free;
end;
procedure TFrmSimpleThreaded.FormShow(Sender: TObject);
begin
  Th := Nil;
  if qBitSelectServerDlg.ShowModal = mrOk then
  begin
    var Server := qBitSelectServerDlg.GetServer;
    Th := TqBitThread.Create(True);
    Th.qB := TqBit.Connect(Server.FHP, Server.FUN, Server.FPW);
    TH.Start;
  end else Close;
end;
procedure TFrmSimpleThreaded.Disconnected(Sender: TqBitThread);
begin
  LBTorrents.Clear;
  LBTorrents.Items.Add('Disconnected...');
end;
procedure TFrmSimpleThreaded.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(Th) then
  begin
    Th.Terminate;
    Th.WaitFor;
    Th.Free;
  end;
end;
procedure TFrmSimpleThreaded.SyncThread(Sender: TqBitThread);
begin
  qBMain := Sender.qBMainTh;
  caption := Format('Last Request Duration : %s ms / (%d Torrents)', [Sender.qB.HTTPDuration.ToString, qBMain.torrents.Count]);
  UpdateUI;
end;
procedure TFrmSimpleThreaded.UpdateUI;
begin
  ////////////////  Few Properties...
  LBTorrents.Clear;
  for var T in qBMAin.torrents do
      LBTorrents.Items.Add( TqBitTorrentType(T.Value).name.AsString
          + ' / ' + TqBitTorrentType(T.Value).state.AsString
          + ' / ' + TqBitTorrentType(T.Value).progress.Per100(2));

end;

end.
