object FrmSTG: TFrmSTG
  Left = 0
  Top = 0
  Caption = 'Multi Threaded Grid'
  ClientHeight = 544
  ClientWidth = 1050
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 301
    Width = 1050
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 0
    ExplicitWidth = 328
  end
  inline MainFrame: TqBitFrame
    Left = 0
    Top = 0
    Width = 1050
    Height = 301
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1050
    ExplicitHeight = 301
    inherited SG: TStringGrid
      Width = 1050
      Height = 301
      DoubleBuffered = True
      ExplicitWidth = 1050
      ExplicitHeight = 301
      ColWidths = (
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80
        80)
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 304
    Width = 1050
    Height = 216
    ActivePage = PeersTabSheet
    Align = alBottom
    TabOrder = 1
    OnChange = PageControl1Change
    object PeersTabSheet: TTabSheet
      Caption = 'Peers'
      inline PeersFrame: TqBitFrame
        Left = 0
        Top = 0
        Width = 1042
        Height = 188
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 1042
        ExplicitHeight = 188
        inherited SG: TStringGrid
          Width = 1042
          Height = 188
          DoubleBuffered = True
          ExplicitWidth = 1042
          ExplicitHeight = 188
        end
      end
    end
    object TrakersTabSheet: TTabSheet
      Caption = 'Trackers'
      ImageIndex = 1
      inline TrackersFrame: TqBitFrame
        Left = 0
        Top = 0
        Width = 1042
        Height = 188
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 1042
        ExplicitHeight = 188
        inherited SG: TStringGrid
          Width = 1042
          Height = 188
          DoubleBuffered = True
          ExplicitWidth = 1042
          ExplicitHeight = 169
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 520
    Width = 1050
    Height = 24
    Panels = <
      item
        Alignment = taCenter
        Bevel = pbNone
        Text = 'Status'
        Width = 80
      end
      item
        Alignment = taCenter
        Bevel = pbNone
        Text = 'dht'
        Width = 100
      end
      item
        Alignment = taRightJustify
        Text = 'dl'
        Width = 50
      end>
    OnClick = StatusBar1Click
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
    object Recheck1: TMenuItem
      Caption = 'Recheck'
      OnClick = Recheck1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Add1: TMenuItem
      Caption = 'Add'
      OnClick = Add1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      object NoData1: TMenuItem
        Caption = 'No Data'
        OnClick = NoData1Click
      end
      object WithData1: TMenuItem
        Caption = 'With Data'
        OnClick = WithData1Click
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ShowSelection1: TMenuItem
      Caption = 'Show Selection'
      OnClick = ShowSelection1Click
    end
  end
  object PeersPopup: TPopupMenu
    Left = 460
    Top = 424
    object BanPeers1: TMenuItem
      Caption = 'Ban Peers'
      OnClick = BanPeers1Click
    end
    object UnbanAll1: TMenuItem
      Caption = 'Unban All'
      OnClick = UnbanAll1Click
    end
  end
  object DlgOpenTorrent: TFileOpenDialog
    DefaultExtension = '.torrent'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Torrent'
        FileMask = '*.torrent'
      end>
    Options = [fdoAllowMultiSelect, fdoPathMustExist, fdoFileMustExist]
    Left = 504
  end
end
