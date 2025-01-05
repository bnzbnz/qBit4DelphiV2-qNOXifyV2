object FrmSimple: TFrmSimple
  Left = 0
  Top = 0
  Caption = 'Simple'
  ClientHeight = 342
  ClientWidth = 635
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 26
    Align = alTop
    TabOrder = 0
    object LinkLabel1: TLinkLabel
      Left = 208
      Top = 6
      Width = 224
      Height = 17
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
    Top = 26
    Width = 635
    Height = 316
    Align = alClient
    DoubleBuffered = True
    ItemHeight = 13
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
