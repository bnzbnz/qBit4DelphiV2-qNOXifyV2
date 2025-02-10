program vnStatDemo;

uses
  Vcl.Forms,
  uTvnStatDemo in 'uTvnStatDemo.pas' {vnStatDemoFrm},
  uJX4Dict in '..\..\API\uJsonX4\uJX4Dict.pas',
  uJX4List in '..\..\API\uJsonX4\uJX4List.pas',
  uJX4Object in '..\..\API\uJsonX4\uJX4Object.pas',
  uJX4Rtti in '..\..\API\uJsonX4\uJX4Rtti.pas',
  uJX4Value in '..\..\API\uJsonX4\uJX4Value.pas',
  uJX4YAML in '..\..\API\uJsonX4\uJX4YAML.pas',
  uVnstatClient in '..\..\API\qBit4DelphiV2\uVnstatClient.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TvnStatDemoFrm, vnStatDemoFrm);
  Application.Run;
end.

