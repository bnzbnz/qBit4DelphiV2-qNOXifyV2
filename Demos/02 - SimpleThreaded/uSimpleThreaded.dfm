object FrmSimpleThreaded: TFrmSimpleThreaded
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'Simple Threaded'
  ClientHeight = 449
  ClientWidth = 953
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
  object LBTorrents: TListBox
    Left = 0
    Top = 0
    Width = 953
    Height = 449
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    DoubleBuffered = True
    ItemHeight = 21
    Items.Strings = (
      'Loading...')
    ParentDoubleBuffered = False
    TabOrder = 0
  end
end
