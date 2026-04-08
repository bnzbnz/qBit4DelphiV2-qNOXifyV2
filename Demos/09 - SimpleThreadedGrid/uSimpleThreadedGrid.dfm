object FrmSTG: TFrmSTG
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'Simple Threaded Grid'
  ClientHeight = 672
  ClientWidth = 1451
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1451
    Height = 39
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 0
  end
  inline MainFrame: TqBitFrame
    Left = 0
    Top = 39
    Width = 1451
    Height = 633
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    TabOrder = 1
    ExplicitTop = 39
    ExplicitWidth = 1451
    ExplicitHeight = 633
    inherited SG: TStringGrid
      Width = 1451
      Height = 633
      Font.Height = -17
      Font.Name = 'Tahoma'
      ParentFont = False
      ExplicitWidth = 1451
      ExplicitHeight = 633
    end
  end
  object MainPopup: TPopupMenu
    Left = 152
    Top = 128
    object Pause1: TMenuItem
      Caption = 'Stop'
      OnClick = PauseClick
    end
    object Pause2: TMenuItem
      Caption = 'Start'
      OnClick = ResumeClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ShowSelection1: TMenuItem
      Caption = 'Show Selection'
      OnClick = ShowSelection1Click
    end
  end
end
