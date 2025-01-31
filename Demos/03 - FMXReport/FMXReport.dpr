program FMXReport;
uses
  uqBit.API.Types in '..\..\API\uqBit.API.Types.pas',
  uqBit.API in '..\..\API\uqBit.API.pas',
  uqBit in '..\..\API\uqBit.pas',
  FMX.Forms,
  uFMXReport in 'uFMXReport.pas' {FrmFMXReport},
  uJX4Dict in '..\..\API\uJsonX4\uJX4Dict.pas',
  uJX4List in '..\..\API\uJsonX4\uJX4List.pas',
  uJX4Object in '..\..\API\uJsonX4\uJX4Object.pas',
  uJX4Rtti in '..\..\API\uJsonX4\uJX4Rtti.pas',
  uJX4Value in '..\..\API\uJsonX4\uJX4Value.pas';

{$R *.res}

begin
  {$IFNDEF FASTMM4} {$IFDEF DEBUG} ReportMemoryLeaksOnShutdown := True; {$ENDIF} {$ENDIF}
  Application.Initialize;
  Application.CreateForm(TFrmFMXReport, FrmFMXReport);
  Application.Run;
end.


