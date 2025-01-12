unit uFMXReport;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls,
  uqBit, uqBit.API, uqBit.API.Types, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TFrmFMXReport = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFMXReport: TFrmFMXReport;

implementation
uses
    RTTI
  , System.Generics.Collections
  , System.TypInfo
  ;

{$R *.fmx}

function GetRTTIReadableValues(Instance: Pointer; ObjectClass: TClass): TDictionary<string, variant>;
begin
  Result := TDictionary<string, variant>.Create;
  var rttictx := TRttiContext.Create();
  try
    var AValue: TValue;
    var rttitype := rttictx.GetType(ObjectClass);
    for var AField in rttitype.GetFields do
    begin
       if (AField.FieldType.TypeKind in [tkRecord])
        and (AField.FieldType.Handle = TypeInfo(TValue))
        and (AField.GetValue(Instance).TryAsType<TValue>(AValue))
     then
        Result.Add(AField.Name, AValue.AsVariant);
    end;
  finally
    rttictx.Free;
  end;
end;

procedure TFrmFMXReport.Button1Click(Sender: TObject);
var
  qB: TqBit;
  M: TqBitMainDataType;
begin
  qB := TqBit.Connect(Edit1.Text, Edit2.Text, Edit3.Text);
  if not assigned(qB) then
  begin
    ShowMessage('Can''t Connect to ' + Edit1.Text);
    Exit;
  end;
   M := qB.GetMainData;

  Memo1.Lines.Clear;
  Memo1.Lines.Add(Format('qBit4Delphi : %s : ', [qB.Version]));
  Memo1.Lines.Add(Format('******************* Server : %s *******************',[qB.HostPath]));

  Memo1.Lines.Add(Format('  Version : %s', [qB.GetVersion]));
  Memo1.Lines.Add(Format('  API : %s', [qB.GetAPIVersion]));
  var B := qB.GetBuildInfo;
  Memo1.Lines.Add(Format('  Libtorrent : %s', [B.libtorrent.AsString]));
  Memo1.Lines.Add(Format('  OpenSSL : %s', [B.openssl.AsString]));
  Memo1.Lines.Add(Format('  Qt : %s', [B.qt.AsString]));
  Memo1.Lines.Add(Format('  Boost : %s', [B.boost.AsString]));
  B.Free;

  var Props := GetRTTIReadableValues(M.server_state, TqBitserver_stateType);
  for var Prop in Props do
    Memo1.Lines.Add('  ' + Prop.key + ' : ' +  VarToStr(Prop.Value));
  Props.Free;

  Memo1.Lines.Add('******************* Preferences *******************');
  var Q := qB.GetPreferences;
  Props := GetRTTIReadableValues(Q, TqBitPreferencesType);
  for var Prop in Props do
    Memo1.Lines.Add('  ' + Prop.key + ' : ' +  VarToStr(Prop.Value));
  Props.Free;
  Q.Free;

  Memo1.Lines.Add(Format('******************* Torrents : %d *******************',[M.torrents.Count]));
  for var T in M.torrents do
  begin
    Memo1.Lines.Add(Format('  ************* Torrent : %s *******************',[TqBitTorrentType(T.Value).name.AsString]));
    Props := GetRTTIReadableValues(T.Value, TqBitTorrentType);
    for var Prop in Props do
    Memo1.Lines.Add('  ' + Prop.key + ' : ' +  VarToStr(Prop.Value));
    Props.Free;
  end;

  Memo1.Lines.Add(Format('******************* Categories : %d *******************',[M.categories.Count]));
  for var C in M.categories do
  begin
    Memo1.Lines.Add(Format('  ************* Categorie : %s *******************',[TqBitCategoryType(C.Value).name.AsString]));
    Props := GetRTTIReadableValues(C.Value, TqBitCategoryType);
    for var Prop in Props do
    Memo1.Lines.Add('  ' + Prop.key + ' : ' +  VarToStr(Prop.Value));
    Props.Free;
  end;

  Memo1.Lines.Add(Format('******************* Tags : %d *******************',[M.tags.Count]));
  for var G in M.tags do
    Memo1.Lines.Add('  ' + G.AsString);

  M.Free;
  qB.Free;
end;

end.
