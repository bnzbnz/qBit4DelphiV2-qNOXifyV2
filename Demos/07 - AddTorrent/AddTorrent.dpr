program AddTorrent;
uses
  Vcl.Forms,
  uAddTorrent in 'uAddTorrent.pas',
  uqBit.API.Types in '..\..\API\uqBit.API.Types.pas',
  uqBit.API in '..\..\API\uqBit.API.pas',
  uqBit in '..\..\API\uqBit.pas',
  uqBitAddServerDlg in '..\Common\Dialogs\uqBitAddServerDlg.pas' {qBitAddServerDlg},
  uqBitAddTorrentDlg in '..\Common\Dialogs\uqBitAddTorrentDlg.pas' {qBitAddTorrentDlg},
  uqBitCategoriesDlg in '..\Common\Dialogs\uqBitCategoriesDlg.pas' {qBitCategoriesDlg},
  uqBitSelectServerDlg in '..\Common\Dialogs\uqBitSelectServerDlg.pas' {qBitSelectServerDlg},
  uJX4Dict in '..\..\API\uJsonX4\uJX4Dict.pas',
  uJX4List in '..\..\API\uJsonX4\uJX4List.pas',
  uJX4Object in '..\..\API\uJsonX4\uJX4Object.pas',
  uJX4Rtti in '..\..\API\uJsonX4\uJX4Rtti.pas',
  uTorrentFileReader in '..\..\API\uTorrentFileReader.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmAddTorrent, FrmAddTorrent);
  Application.CreateForm(TqBitAddServerDlg, qBitAddServerDlg);
  Application.CreateForm(TqBitSelectServerDlg, qBitSelectServerDlg);
  Application.CreateForm(TqBitCategoriesDlg, qBitCategoriesDlg);
  Application.CreateForm(TqBitAddServerDlg, qBitAddServerDlg);
  Application.CreateForm(TqBitAddTorrentDlg, qBitAddTorrentDlg);
  Application.Run;
end.


