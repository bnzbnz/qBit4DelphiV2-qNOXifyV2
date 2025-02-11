program qNOXifyV2;
uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uqNOXifyV2 in 'uqNOXifyV2.pas' {FrmSTG},
  uqBitAddServerDlg in '..\Demos\Common\Dialogs\uqBitAddServerDlg.pas' {qBitAddServerDlg},
  uqBitCategoriesDlg in '..\Demos\Common\Dialogs\uqBitCategoriesDlg.pas' {qBitTagsDlg},
  uqBitSelectServerDlg in '..\Demos\Common\Dialogs\uqBitSelectServerDlg.pas' {qBitSelectServerDlg},
  uqBitGrid in '..\Demos\Common\uqBitGrid.pas' {qBitFrame: TFrame},
  uqBitThreads in '..\Demos\Common\uqBitThreads.pas',
  uqBitAddTorrentDlg in '..\Demos\Common\Dialogs\uqBitAddTorrentDlg.pas' {qBitAddTorrentDlg},
  uJX4Dict in '..\API\uJsonX4\uJX4Dict.pas',
  uJX4List in '..\API\uJsonX4\uJX4List.pas',
  uJX4Object in '..\API\uJsonX4\uJX4Object.pas',
  uJX4Rtti in '..\API\uJsonX4\uJX4Rtti.pas',
  uJX4Value in '..\API\uJsonX4\uJX4Value.pas',
  uJX4YAML in '..\API\uJsonX4\uJX4YAML.pas',
  uIpAPI in '..\API\qBit4DelphiV2\uIpAPI.pas',
  uqBit.API in '..\API\qBit4DelphiV2\uqBit.API.pas',
  uqBit.API.Types in '..\API\qBit4DelphiV2\uqBit.API.Types.pas',
  uqBit in '..\API\qBit4DelphiV2\uqBit.pas',
  uTorrentFileReader in '..\API\qBit4DelphiV2\uTorrentFileReader.pas',
  uVnstatClient in '..\API\qBit4DelphiV2\uVnstatClient.pas',
  uKobicAppTrackMenus in '..\API\KobicAppTrackMenus\uKobicAppTrackMenus.pas',
  uFacterClient in '..\API\qBit4DelphiV2\uFacterClient.pas',
  uAbout in '..\Demos\Common\Dialogs\uAbout.pas' {AboutBox};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'qNOXify V2';
  Application.CreateForm(TFrmSTG, FrmSTG);
  Application.CreateForm(TqBitAddServerDlg, qBitAddServerDlg);
  Application.CreateForm(TqBitSelectServerDlg, qBitSelectServerDlg);
  Application.CreateForm(TqBitAddTorrentDlg, qBitAddTorrentDlg);
  Application.CreateForm(TqBitCategoriesDlg, qBitCategoriesDlg);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.

