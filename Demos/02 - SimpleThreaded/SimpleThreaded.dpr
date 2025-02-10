program SimpleThreaded;
uses
  Vcl.Forms,
  uSimpleThreaded in 'uSimpleThreaded.pas' {FrmSimpleThreaded},
  uqBitAddServerDlg in '..\Common\Dialogs\uqBitAddServerDlg.pas' {qBitAddServerDlg},
  uqBitAddTorrentDlg in '..\Common\Dialogs\uqBitAddTorrentDlg.pas' {qBitAddTorrentDlg},
  uqBitCategoriesDlg in '..\Common\Dialogs\uqBitCategoriesDlg.pas' {qBitCategoriesDlg},
  uqBitSelectServerDlg in '..\Common\Dialogs\uqBitSelectServerDlg.pas' {qBitSelectServerDlg},
  uJX4Dict in '..\..\API\uJsonX4\uJX4Dict.pas',
  uJX4List in '..\..\API\uJsonX4\uJX4List.pas',
  uJX4Object in '..\..\API\uJsonX4\uJX4Object.pas',
  uJX4Rtti in '..\..\API\uJsonX4\uJX4Rtti.pas',
  uJX4Value in '..\..\API\uJsonX4\uJX4Value.pas',
  uJX4YAML in '..\..\API\uJsonX4\uJX4YAML.pas',
  uIpAPI in '..\..\API\qBit4DelphiV2\uIpAPI.pas',
  uqBit.API in '..\..\API\qBit4DelphiV2\uqBit.API.pas',
  uqBit.API.Types in '..\..\API\qBit4DelphiV2\uqBit.API.Types.pas',
  uqBit in '..\..\API\qBit4DelphiV2\uqBit.pas',
  uTorrentFileReader in '..\..\API\qBit4DelphiV2\uTorrentFileReader.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmSimpleThreaded, FrmSimpleThreaded);
  Application.CreateForm(TqBitAddServerDlg, qBitAddServerDlg);
  Application.CreateForm(TqBitSelectServerDlg, qBitSelectServerDlg);
  Application.CreateForm(TqBitAddServerDlg, qBitAddServerDlg);
  Application.CreateForm(TqBitAddTorrentDlg, qBitAddTorrentDlg);
  Application.CreateForm(TqBitCategoriesDlg, qBitCategoriesDlg);
  Application.CreateForm(TqBitSelectServerDlg, qBitSelectServerDlg);
  Application.Run;
end.
