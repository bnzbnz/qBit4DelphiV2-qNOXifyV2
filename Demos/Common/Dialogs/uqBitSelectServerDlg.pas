unit uqBitSelectServerDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uqBit.API.Types, uqBit.API, uqBit,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.ComCtrls, System.Generics.Collections
  , RTTI
  , uJX4Object
  , uJX4List
  ;

type
  TqBitServer = class(TJX4Object)
    FHP: TValue;
    FUN: TValue;
    FPW: TValue;
    FSH:  TValue;
    FSPO: TValue;
    FSU:  TValue;
    FSK:  TValue;
    FVS:  TValue;
    FVSI: TValue;
    FVSE: TValue; // Int
    FFacterUrl: TValue;
    FFacterMP: TValue;
    FFacterMin: TValue ;// int
    constructor Create(H, U, P, SH, SPO, SU, SK, VS, VSI, VSE, FacterUrl, FacterMP, FacterMin: TValue);
  end;

  TqBitServers = class(TJX4Object)
    Servers: TJX4List<tqBitServer>;
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
    Button1: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure LBSrvClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSelClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure LBSrvDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MultiSelect: Boolean;
    Config: TqBitServers;
    function GetServer: TqBitServer;
    function GetMultiServers: TObjectList<TqBitServer>;
    procedure SaveConfig(AConfig: TqBitServers) ;
    procedure LoadConfig(AConfig: TqBitServers) ;

  end;

var
  qBitSelectServerDlg: TqBitSelectServerDlg;

implementation
uses uqBitAddServerDlg, IOUtils, SysUtils;

{$R *.dfm}

procedure TqBitSelectServerDlg.BtnSelClick(Sender: TObject);
begin
  if LBSrv.ItemIndex = -1  then Exit;
  BtnSel.Caption := '...Checking...'; BtnSel.Enabled := False;
  ModalResult := mrNone;
  var Srv := TqBitServer(LBSrv.Items.Objects[LBSrv.ItemIndex]);
  var qB := TqBit.Connect(Srv.FHP.AsString, Srv.FUN.AsString, Srv.FPW.AsString);
  if assigned(qB) then
  begin
    if not qB.qBitCheckWebAPICompatibility then
      ShowMessage('Server API version not compatible')
    else
      ModalResult := mrOK
  end else
    ShowMessage('Can not connect to : ' + Srv.FHP.AsString);
  qB.Free;
  BtnSel.Caption := 'Select'; BtnSel.Enabled := True;
end;

procedure TqBitSelectServerDlg.Button1Click(Sender: TObject);
begin
  if LBSrv.ItemIndex = -1 then Exit;
  var Srv := TqBitServer(LBSrv.Items.Objects[LBSrv.ItemIndex]);
  qBitAddServerDlg.HP.Text := Srv.FHP.AsString;
  qBitAddServerDlg.UN.Text := Srv.FUN.AsString;
  qBitAddServerDlg.PW.Text := Srv.FPW.AsString;
  qBitAddServerDlg.Edit1.Text := Srv.FSH.AsString;
  qBitAddServerDlg.Edit2.Text := Srv.FSPO.AsString;
  qBitAddServerDlg.Edit3.Text := Srv.FSU.AsString;
  qBitAddServerDlg.Edit4.Text := Srv.FSK.AsString;
  qBitAddServerDlg.Edit5.text := Srv.FVS.AsString;
  qBitAddServerDlg.Edit6.text := Srv.FVSI.AsString;
  qBitAddServerDlg.SE1.Value := Srv.FVSE.AsInt64;
  qBitAddServerDlg.Edit7.text := Srv.FFacterUrl.toString;
  qBitAddServerDlg.Edit8.text := Srv.FFacterMP.toString;
  qBitAddServerDlg.SpinEdit1.Value := Srv.FFacterMin.AsInt64;
  if qBitAddServerDlg.ShowModal = mrOk then
  begin
    Srv.FHP := Trim(qBitAddServerDlg.HP.Text);
    Srv.FUN := Trim(qBitAddServerDlg.UN.Text);
    Srv.FPW := Trim(qBitAddServerDlg.PW.Text);
    Srv.FSH := Trim(qBitAddServerDlg.Edit1.Text);
    Srv.FSPO := Trim(qBitAddServerDlg.Edit2.Text);
    Srv.FSU := Trim(qBitAddServerDlg.Edit3.Text);
    Srv.FSK := Trim(qBitAddServerDlg.Edit4.Text);
    Srv.FVS := Trim(qBitAddServerDlg.Edit5.text);
    Srv.FVSI := Trim(qBitAddServerDlg.Edit6.text);
    Srv.FVSE := qBitAddServerDlg.SE1.Value;
    Srv.FFacterUrl := Trim(qBitAddServerDlg.Edit7.Text);
    Srv.FFacterMP := Trim(qBitAddServerDlg.Edit8.Text);
    SRV.FFacterMin := qBitAddServerDlg.SpinEdit1.Value;
    LBSrvClick(Self);
  end;
end;

procedure TqBitSelectServerDlg.btnAddClick(Sender: TObject);
begin
  if qBitAddServerDlg.ShowModal = mrOk then
  begin

    var Srv := TqBitServer.Create(
      qBitAddServerDlg.HP.Text,
      qBitAddServerDlg.UN.Text,
      qBitAddServerDlg.PW.Text,
      qBitAddServerDlg.Edit1.Text,
      qBitAddServerDlg.Edit2.Text,
      qBitAddServerDlg.Edit3.Text,
      qBitAddServerDlg.Edit4.Text,
      qBitAddServerDlg.Edit5.text,
      qBitAddServerDlg.Edit6.text,
      qBitAddServerDlg.SE1.Value,
      qBitAddServerDlg.Edit7.Text,
      qBitAddServerDlg.Edit8.Text,
      qBitAddServerDlg.SpinEdit1.Value
    );
    LBSrv.ItemIndex := LBSrv.Items.AddObject(Srv.FUN.AsString + '@' + Srv.FHP.AsString, Srv);
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

constructor TqBitServer.Create(H, U, P, SH, SPO, SU, SK, VS, VSI, VSE, FacterUrl, FacterMP, FacterMin: TValue);
begin
  inherited Create;
  FHP := H;
  FUN := U;
  FPW := P;
  FSH := SH;
  FSPO := SPO;
  FSU := SU;
  FSK := SK;
  FVS := VS;
  FVSI := VSI;
  FVSE := VSE;
  FFacterUrl := FacterUrl;
  FFacterMP := FacterMP;
  FFacterMin := FacterMin;
end;

procedure TqBitSelectServerDlg.FormCreate(Sender: TObject);
begin
  VerLabel.Caption := 'qBit4Delphi, API Version : ' + TqBit.Version;
  VerLabel.Caption := VerLabel.Caption + sLineBreak + 'By ' + qBitAPI_Developer;
  SGInfo.Cells[1, 6] := TJX4Object.Version;
  SGInfo.Cells[1, 7] := TqBit.Version;
end;

procedure TqBitSelectServerDlg.FormDestroy(Sender: TObject);
begin
  for var i := LBSrv.Items.Count -1 downto 0 do
    TqBitServer(LBSrv.Items.Objects[i]).Free;
end;

procedure TqBitSelectServerDlg.SaveConfig(AConfig: TqBitServers);
begin
  AConfig.Servers.Clear;
  for var i := 0 to LBSrv.Items.Count -1 do
    AConfig.AddServer(TqBitServer(LBSrv.Items.Objects[i]).Clone<TqBitServer>);
end;

procedure TqBitSelectServerDlg.LoadConfig(AConfig: TqBitServers);
begin
  if Assigned(AConfig) and (LBSrv.Items.Count = 0) then
  begin
     for var S in AConfig.Servers do
    begin
      var Srv := TqBitServer.Create(S.FHP.AsString, S.FUN.AsString, S.FPW.AsString, S.FSH.AsString, S.FSPO.AsString
                    , S.FSU.AsString, S.FSK.AsString, S.FVS.AsString, S.FVSI.AsString, S.FVSE.AsInt64,
                    S.FFacterUrl.AsString, S.FFacterMP.AsString, S.FFacterMin.AsInt64);
      LBSrv.Items.AddObject(Srv.FUN.AsString + '@' + Srv.FHP.AsString, Srv);
    end;
  end;
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
  var qB := TqBit.Connect(Srv.FHP.AsString, Srv.FUN.AsString, Srv.FPW.AsString);
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

procedure TqBitServers.AddServer(Srv: TqBitServer);
begin
  Servers.Add(Srv);
end;

destructor TqBitServers.Destroy;
begin
  inherited;
end;

end.
