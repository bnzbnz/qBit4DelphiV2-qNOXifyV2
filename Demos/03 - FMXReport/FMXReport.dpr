program FMXReport;
uses
  uqBit.API.Types in '..\..\API\qBit4DelphiV2\uqBit.API.Types.pas',
  uqBit.API in '..\..\API\qBit4DelphiV2\uqBit.API.pas',
  uqBit in '..\..\API\qBit4DelphiV2\uqBit.pas',
  FMX.Forms,
  uFMXReport in 'uFMXReport.pas' {FrmFMXReport},
  uJX4Dict in '..\..\API\uJsonX4\uJX4Dict.pas',
  uJX4List in '..\..\API\uJsonX4\uJX4List.pas',
  uJX4Object in '..\..\API\uJsonX4\uJX4Object.pas',
  uJX4Rtti in '..\..\API\uJsonX4\uJX4Rtti.pas',
  uJX4Value in '..\..\API\uJsonX4\uJX4Value.pas',
  uJX4YAML in '..\..\API\uJsonX4\uJX4YAML.pas';

{$R *.res}

begin
  {$IFNDEF FASTMM4} {$IFDEF DEBUG} ReportMemoryLeaksOnShutdown := True; {$ENDIF} {$ENDIF}
  Application.Initialize;
  Application.CreateForm(TFrmFMXReport, FrmFMXReport);
  Application.Run;
end.


