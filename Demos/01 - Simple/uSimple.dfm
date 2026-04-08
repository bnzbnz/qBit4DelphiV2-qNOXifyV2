object FrmSimple: TFrmSimple
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'Simple'
  ClientHeight = 513
  ClientWidth = 953
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 953
    Height = 39
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 0
    object LinkLabel1: TLinkLabel
      Left = 312
      Top = 9
      Width = 344
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 
        '<a href="https://github.com/qbittorrent/qBittorrent/wiki/WebUI-A' +
        'PI-(qBittorrent-4.1)">Documentation : WebUI-API-(qBittorrent-4.1' +
        ')</a>'
      TabOrder = 0
      OnLinkClick = LinkLabel1LinkClick
    end
  end
  object LBTorrents: TListBox
    Left = 0
    Top = 39
    Width = 953
    Height = 474
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    DoubleBuffered = True
    ItemHeight = 21
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 520
    Top = 112
  end
end
