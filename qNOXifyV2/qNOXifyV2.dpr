program qNOXifyV2;
uses
  Vcl.Forms,
  uqBitAddServerDlg in '..\Demos\Common\Dialogs\uqBitAddServerDlg.pas' {qBitAddServerDlg},
  uqBitCategoriesDlg in '..\Demos\Common\Dialogs\uqBitCategoriesDlg.pas' {qBitTagsDlg},
  uqBitSelectServerDlg in '..\Demos\Common\Dialogs\uqBitSelectServerDlg.pas' {qBitSelectServerDlg},
  uqNOXifyV2 in 'uqNOXifyV2.pas' {FrmSTG},
  uJX4Dict in '..\API\uJsonX4\uJX4Dict.pas',
  uJX4List in '..\API\uJsonX4\uJX4List.pas',
  uJX4Object in '..\API\uJsonX4\uJX4Object.pas',
  uJX4Rtti in '..\API\uJsonX4\uJX4Rtti.pas',
  uIpAPI in '..\API\uIpAPI.pas',
  uqBit.API in '..\API\uqBit.API.pas',
  uqBit.API.Types in '..\API\uqBit.API.Types.pas',
  uqBit in '..\API\uqBit.pas',
  uTorrentFileReader in '..\API\uTorrentFileReader.pas',
  uKobicAppTrackMenus in '..\Demos\Common\uKobicAppTrackMenus.pas',
  uqBitGrid in '..\Demos\Common\uqBitGrid.pas' {qBitFrame: TFrame},
  uqBitThreads in '..\Demos\Common\uqBitThreads.pas',
  uqBitAddTorrentDlg in '..\Demos\Common\Dialogs\uqBitAddTorrentDlg.pas' {qBitAddTorrentDlg},
  Vcl.Themes,
  Vcl.Styles,
  uJX4Value in '..\API\uJsonX4\uJX4Value.pas',
  tgputtysftp in '..\API\TGPuttyLib\tgputtysftp.pas',
  tgputtylib in '..\API\TGPuttyLib\tgputtylib.pas',
  uVnstatClient in '..\API\uVnstatClient.pas',
  uJX4YAML in '..\API\uJsonX4\uJX4YAML.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'qBOX Thin Client';
  Application.CreateForm(TFrmSTG, FrmSTG);
  Application.CreateForm(TqBitAddServerDlg, qBitAddServerDlg);
  Application.CreateForm(TqBitSelectServerDlg, qBitSelectServerDlg);
  Application.CreateForm(TqBitAddTorrentDlg, qBitAddTorrentDlg);
  Application.CreateForm(TqBitCategoriesDlg, qBitCategoriesDlg);
  Application.Run;
end.

