program NOXMon;
uses
  Vcl.Forms,
  uNOXMon in 'uNOXMon.pas' {NOXMonDlg},
  uqBitAddServerDlg in '..\Common\Dialogs\uqBitAddServerDlg.pas' {qBitAddServerDlg},
  uqBitSelectServerDlg in '..\Common\Dialogs\uqBitSelectServerDlg.pas' {qBitSelectServerDlg},
  uJX4Dict in '..\..\API\uJsonX4\uJX4Dict.pas',
  uJX4List in '..\..\API\uJsonX4\uJX4List.pas',
  uJX4Object in '..\..\API\uJsonX4\uJX4Object.pas',
  uJX4Rtti in '..\..\API\uJsonX4\uJX4Rtti.pas',
  uqBit.API in '..\..\API\uqBit.API.pas',
  uqBit.API.Types in '..\..\API\uqBit.API.Types.pas',
  uqBit in '..\..\API\uqBit.pas',
  uTorrentFileReader in '..\..\API\uTorrentFileReader.pas';

{$R *.res}

begin
  {$IFNDEF FASTMM4} {$IFDEF DEBUG} ReportMemoryLeaksOnShutdown := True; {$ENDIF} {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TNOXMonDlg, NOXMonDlg);
  Application.CreateForm(TqBitSelectServerDlg, qBitSelectServerDlg);
  Application.CreateForm(TqBitAddServerDlg, qBitAddServerDlg);
  Application.CreateForm(TqBitAddServerDlg, qBitAddServerDlg);
  Application.CreateForm(TqBitSelectServerDlg, qBitSelectServerDlg);
  Application.Run;
end.


