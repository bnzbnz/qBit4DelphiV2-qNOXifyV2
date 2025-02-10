program TorrentReader;
uses
  Vcl.Forms,
  uTorrentReader in 'uTorrentReader.pas' {Form2},
  uTorrentFileReader in '..\..\API\qBit4DelphiV2\uTorrentFileReader.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

