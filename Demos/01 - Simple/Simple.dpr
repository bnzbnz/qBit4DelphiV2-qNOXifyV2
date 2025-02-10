program Simple;
uses
  Vcl.Forms,
  uSimple in 'uSimple.pas' {FrmSimple},
  uqBitAddServerDlg in '..\Common\Dialogs\uqBitAddServerDlg.pas' {qBitAddServerDlg},
  uqBitSelectServerDlg in '..\Common\Dialogs\uqBitSelectServerDlg.pas' {qBitSelectServerDlg},
  uqBit.API in '..\..\API\qBit4DelphiV2\uqBit.API.pas',
  uqBit.API.Types in '..\..\API\qBit4DelphiV2\uqBit.API.Types.pas',
  uqBit in '..\..\API\qBit4DelphiV2\uqBit.pas',
  uJX4Dict in '..\..\..\JsonX4\uJsonX4\uJX4Dict.pas',
  uJX4List in '..\..\..\JsonX4\uJsonX4\uJX4List.pas',
  uJX4Object in '..\..\..\JsonX4\uJsonX4\uJX4Object.pas',
  uJX4Rtti in '..\..\..\JsonX4\uJsonX4\uJX4Rtti.pas',
  uJX4Value in '..\..\API\uJsonX4\uJX4Value.pas',
  Vcl.Themes,
  Vcl.Styles,
  uJX4YAML in '..\..\API\uJsonX4\uJX4YAML.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TFrmSimple, FrmSimple);
  Application.CreateForm(TqBitAddServerDlg, qBitAddServerDlg);
  Application.CreateForm(TqBitSelectServerDlg, qBitSelectServerDlg);
  Application.Run;
end.

