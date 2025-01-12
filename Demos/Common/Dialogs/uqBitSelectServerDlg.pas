unit uqBitSelectServerDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uqBit.API.Types, uqBit.API, uqBit,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.ComCtrls, System.Generics.Collections;

type
  TqBitServer = class
    FHP: string;
    FUN: string;
    FPW: string;
    constructor Create(H, U, P: string);
  end;

  TqBitServers = class
    FServers: TArray<tqBitServer>;
    procedure AddServer(Srv: TqBitServer);
    destructor Destroy; override;
  end;

  TqBitSelectServerDlg = class(TForm)
    BtnSel: TButton;
    BtnCancel: TButton;
    LBSrv: TListBox;
    btnAdd: TButton;
    BtnDel: TButton;
    Bevel1: TBevel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    SGInfo: TStringGrid;
    VerLabel: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LBSrvClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSelClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure SGInfoSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure LBSrvDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MultiSelect: Boolean;
    CfgFileName: string;
    function GetServer: TqBitServer;
    function GetMultiServers: TObjectList<TqBitServer>;
  end;

var
  qBitSelectServerDlg: TqBitSelectServerDlg;

implementation
uses uqBitAddServerDlg, IOUtils, Rest.JSON, uJX4Object;

{$R *.dfm}

procedure TqBitSelectServerDlg.BtnSelClick(Sender: TObject);
begin
  if LBSrv.ItemIndex = -1  then Exit;
  BtnSel.Caption := '...Checking...'; BtnSel.Enabled := False;
  ModalResult := mrNone;
  var Srv := TqBitServer(LBSrv.Items.Objects[LBSrv.ItemIndex]);
  var qB := TqBit.Connect(Srv.FHP, Srv.FUN, Srv.FPW);
  if assigned(qB) then
  begin
    if not qB.qBitCheckWebAPICompatibility then
      ShowMessage('Server API version not compatible')
    else
      ModalResult := mrOK
  end else
    ShowMessage('Can not connect to : ' + Srv.FHP);
  qB.Free;
  BtnSel.Caption := 'Select'; BtnSel.Enabled := True;
end;

procedure TqBitSelectServerDlg.btnAddClick(Sender: TObject);
begin
  if qBitAddServerDlg.ShowModal = mrOk then
  begin
    var Srv := TqBitServer.Create(
      qBitAddServerDlg.HP.Text,
      qBitAddServerDlg.UN.Text,
      qBitAddServerDlg.PW.Text
    );
    LBSrv.ItemIndex := LBSrv.Items.AddObject(Srv.FUN + '@' + Srv.FHP, Srv);
    LBSrvClick(Self);
  end;
end;

procedure TqBitSelectServerDlg.BtnDelClick(Sender: TObject);
begin
  if LBSrv.ItemIndex = -1  then Exit;
  LBSrv.items.Objects[ LBSrv.ItemIndex ].Free;
  LBSrv.DeleteSelected;
  LBSrvClick(Self);
end;

{ TqBitServer }

constructor TqBitServer.Create(H, U, P: string);
begin
  inherited Create;
  FHP := H;
  FUN := U;
  FPW := P;
end;

procedure TqBitSelectServerDlg.FormCreate(Sender: TObject);
begin
  CfgFileName := TPath.GetFileNameWithoutExtension(Application.ExeName) + '.json';
  VerLabel.Caption := 'qBit4Delphi, API Version : ' + TqBit.Version;
  VerLabel.Caption := VerLabel.Caption + sLineBreak + 'By ' + qBitAPI_Developer;
  SGInfo.Cells[1, 6] := TJX4Object.Version;
  SGInfo.Cells[1, 7] := TqBit.Version;
end;

procedure TqBitSelectServerDlg.FormDestroy(Sender: TObject);
begin
  var SrvLst := TqBitServers.Create;
  for var i := 0 to LBSrv.Items.Count -1 do
    SrvLst.AddServer(TqBitServer(LBSrv.Items.Objects[i]));
  var Json := TJson.ObjectToJsonString(SrvLst);
  var SS := TStringStream.Create( TJson.ObjectToJsonString(SrvLst) );
  SS.SaveToFile(CfgFileName);
  SS.Free;
  SrvLst.Free;
end;

procedure TqBitSelectServerDlg.FormShow(Sender: TObject);
const
  NoSelection: TGridRect = (Left: 0; Top: -1; Right: 0; Bottom: -1);
begin
  Self.LBSrv.MultiSelect := MultiSelect;
  if MultiSelect then Caption :='Select multiple servers :';
  SGInfo.Selection:= NoSelection;
  SGInfo.Cells[0, 0] := 'Server Version :';
  SGInfo.Cells[0, 1] := 'Web API :';
  SGInfo.Cells[0, 2] := 'libtorrent';
  SGInfo.Cells[0, 3] := 'OpenSSL';
  SGInfo.Cells[0, 4] := 'Qt';
  SGInfo.Cells[0, 5] := 'zlib';
  SGInfo.Cells[0, 6] := 'Jsonx4';
  SGInfo.Cells[0, 7] := 'qBitAPI';
  if FileExists(CfgFileName) and (LBSrv.Items.Count = 0) then
  begin
    var SS := TStringStream.Create;
    SS.LoadFromFile(CfgFileName);
    var SrvLst := TJson.JsonToObject<TqBitServers>(SS.DataString);
    SS.Free;
    for var S in SrvLst.FServers do
    begin
      var Srv := TqBitServer.Create(S.FHP, S.FUN, S.FPW);
      LBSrv.Items.AddObject(Srv.FUN + '@' + Srv.FHP, Srv);
    end;
    SrvLst.Free;
  end;
  if LBSrv.Items.Count = 0 then
  begin
     var Srv := TqBitServer.Create('http://127.0.0.1:8080', '', '');
     LBSrv.Items.AddObject(Srv.FUN + '@' + Srv.FHP, Srv);
  end;
end;

function TqBitSelectServerDlg.GetMultiServers: TObjectList<TqBitServer>;
begin
  Result := Nil;
  if not Self.MultiSelect then Exit;
  Result := TObjectList<tqBitServer>.Create(False);
  for var i := 0 to LBSrv.Count-1 do
    if LBSrv.Selected[i] then Result.Add(TqBitServer(LBSrv.Items.Objects[i]));
end;

function TqBitSelectServerDlg.GetServer: TqBitServer;
begin
  Result := Nil;
  if LBSrv.ItemIndex = -1 then Exit;
  Result := TqBitServer(LBSrv.Items.Objects[LBSrv.ItemIndex]);
end;

procedure TqBitSelectServerDlg.LBSrvClick(Sender: TObject);
begin
  for var i := 0 to 5 do SGInfo.Cells[1 ,i] := '';
  BtnSel.Enabled := not (LBSrv.ItemIndex = -1);
  if LBSrv.ItemIndex = -1 then Exit;
  var Srv := TqBitServer(LBSrv.Items.Objects[LBSrv.ItemIndex]);
  var qB := TqBit.Connect(Srv.FHP, Srv.FUN, Srv.FPW);
  if assigned(qB) then
  begin;
    var B := qB.GetBuildInfo;
    SGInfo.Cells[1, 0] := qB.GetVersion;
    SGInfo.Cells[1, 1] := qB.GetAPIVersion;
    SGInfo.Cells[1, 2] := B.libtorrent.AsString;
    SGInfo.Cells[1, 3] := B.openssl.AsString;
    SGInfo.Cells[1, 4] := B.qt.AsString;
    SGInfo.Cells[1, 5] := B.zlib.AsString;
    B.Free;
  end;
  qB.Free;
end;

procedure TqBitSelectServerDlg.LBSrvDblClick(Sender: TObject);
begin
  BtnSelClick(Self);
end;

procedure TqBitSelectServerDlg.SGInfoSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := False;
end;

procedure TqBitServers.AddServer(Srv: TqBitServer);
begin
  SetLength(FServers, Length(FServers) + 1);
  FServers[ Length(FServers) - 1 ] := Srv;
end;

destructor TqBitServers.Destroy;
begin
  for var i := 0 to Length(FServers) -1 do
    FServers[i].Free;
  inherited;
end;

end.
