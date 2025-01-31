unit uNOXMon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections,
  uqBit.API.Types, uqBit.API, uqBit, Vcl.Grids;

type

  TqBitThread = class(TThread)
    qB: TqBit;
    qBMainTh: TqBitMainDataType;
    RowIndex: integer;
    procedure Execute; override;
  end;

  TNOXMonDlg = class(TForm)
    SG: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    ThList: TObjectList<TqBitThread>;
    procedure SyncThread(Sender: TqBitThread);
    procedure UpdateHeaders;
    procedure UpdateRow(Thread: TqBitThread);
  end;

var
  NOXMonDlg: TNOXMonDlg;

implementation
uses uqBitSelectServerDlg, Math, RTTI, uJX4Value;

{$R *.dfm}

procedure TNOXMonDlg.FormShow(Sender: TObject);
var
  Srvs: TObjectList<TqBitServer>;
  Th : TqBitThread;
begin
  qBitSelectServerDlg.MultiSelect := True;
  if qBitSelectServerDlg.ShowModal = mrOk then
  begin
    UpdateHeaders;
    ThList := TObjectList<TqBitThread>.Create(False);
    Srvs :=  qBitSelectServerDlg.GetMultiServers;
    var RowIndex := 1;
    for var Srv in Srvs do
    begin
      Th := TqBitThread.Create(True);
      Th.RowIndex := RowIndex;
      Inc(RowIndex);
      Th.qB := TqBit.Connect(Srv.FHP, Srv.FUN, Srv.FPW);
      ThList.Add(Th);
      Th.Start;
    end;
    Srvs.Free;
  end else Close;
end;


procedure TNOXMonDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ThList <> nil then
    for var Th in ThList do
    begin
      TH.Terminate;
      Th.WaitFor;
      Th.Free;
    end;
  ThList.Free;
end;

procedure TNOXMonDlg.SyncThread(Sender: TqBitThread);
begin
  UpdateRow(Sender);
end;

procedure TNOXMonDlg.UpdateHeaders;
begin
  var C := -1;
  Inc(C); SG.Cells[C, 0] := 'Host :'; SG.ColWidths[C]:=180;
  Inc(C); SG.Cells[C, 0] := 'State :'; SG.ColWidths[C]:=80;
  Inc(C); SG.Cells[C, 0] := 'Ratio (Session/AllTime) :'; SG.ColWidths[C]:=130;
  Inc(C); SG.Cells[C, 0] := 'Downloaded:'; SG.ColWidths[C]:=80;
  Inc(C); SG.Cells[C, 0] := 'Uploaded :'; SG.ColWidths[C]:=80;
  Inc(C); SG.Cells[C, 0] := 'Traffic :'; SG.ColWidths[C]:=80;
  Inc(C); SG.Cells[C, 0] := 'Delta :'; SG.ColWidths[C]:=80;
  Inc(C); SG.Cells[C, 0] := 'Efficiency :'; SG.ColWidths[C]:=80;
  Inc(C); SG.Cells[C, 0] := 'Down Speed :'; SG.ColWidths[C]:=80;
  Inc(C); SG.Cells[C, 0] := 'Up Speed :'; SG.ColWidths[C]:=80;
  Inc(C); SG.Cells[C, 0] := 'Cache Hits :'; SG.ColWidths[C]:=80;
  Inc(C); SG.Cells[C, 0] := 'Free disk :'; SG.ColWidths[C]:=80;
end;

procedure TNOXMonDlg.UpdateRow(Thread: TqBitThread);
begin
  var Q := Thread.qB;
  var M := Thread.qBMainTh;

  var Traffic := M.server_state.dl_info_data.AsInt64 + M.server_state.up_info_data.AsInt64;
  var Delta := Abs( M.server_state.up_info_data.AsInt64 - M.server_state.dl_info_data.AsInt64);
  var Efficiency := 0.0; if Traffic >0 then Efficiency := Delta / Traffic;

  var C := -1;
  Inc(C); SG.Cells[C, Thread.RowIndex] := Q.HostPath;
  Inc(C); SG.Cells[C, Thread.RowIndex] := M.server_state.connection_status.AsString;
  Inc(C); SG.Cells[C, Thread.RowIndex] :=
    Format('%.2f (%.2f)', [
      (M.server_state.up_info_data.AsExtended / Max(Int64(M.server_state.dl_info_data.AsInt64), 1)),
      (M.server_state.alltime_ul.AsInt64 / M.server_state.alltime_dl.AsInt64)
    ]);
  Inc(C); SG.Cells[C, Thread.RowIndex] := M.server_state.dl_info_data.ToBKiBMiB;
  Inc(C); SG.Cells[C, Thread.RowIndex] := M.server_state.up_info_data.ToBKiBMiB;
  Inc(C); SG.Cells[C, Thread.RowIndex] := TValue(Traffic).ToBKiBMiB;
  Inc(C); SG.Cells[C, Thread.RowIndex] := TValue(Delta).ToBKiBMiB;
  Inc(C); SG.Cells[C, Thread.RowIndex] := TValue(Efficiency).ToPercent;

  Inc(C); SG.Cells[C, Thread.RowIndex] := M.server_state.dl_info_speed.ToBKiBMiB + '/s';
  Inc(C); SG.Cells[C, Thread.RowIndex] := M.server_state.up_info_speed.ToBKiBMiB + '/s';
  Inc(C); SG.Cells[C, Thread.RowIndex] := M.server_state.read_cache_hits.AsString;
  Inc(C); SG.Cells[C, Thread.RowIndex] := M.server_state.free_space_on_disk.ToBKiBMiB;

end;

{ TqBitThread }

procedure TqBitThread.Execute;
begin
  qBMainTh := qB.GetMainData(0); // Full server data update
  while not Terminated do
  begin
    var tme := GetTickCount;
    var U := qB.GetMainData(qBMainTh.rid.AsInteger); // get differebtial data from last call
    if U = nil then
    begin
      qBMainTh.server_state.connection_status := 'disconnected';
      Terminate;
    end else
      qBMainTh.Merge(U); // Merge to qBMain to be uodated to date
    U.Free;
    Synchronize(
      procedure
      begin
        NOXMonDlg.SyncThread(Self);
      end
    );
    while
      (GetTickCount - Tme < qBMainTh.server_state.refresh_interval.AsInt64)
      and (not Terminated)
    do
      Sleep(250);
  end;
  qBMainTh.Free;
  qB.Free;
end;

end.
