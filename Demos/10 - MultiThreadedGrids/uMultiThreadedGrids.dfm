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
    Left = 161
    Top = 0
    Width = 889
    Height = 301
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 185
    ExplicitWidth = 865
    ExplicitHeight = 301
    inherited SG: TStringGrid
      Width = 889
      Height = 301
      ExplicitWidth = 865
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
    ActivePage = TabSheet1
    Align = alBottom
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Torrent Info.'
      object SGG: TStringGrid
        Left = 0
        Top = 0
        Width = 1042
        Height = 188
        Align = alClient
        BevelEdges = []
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ColCount = 8
        DefaultColWidth = 192
        DoubleBuffered = True
        DoubleBufferedMode = dbmRequested
        FixedCols = 0
        RowCount = 20
        FixedRows = 0
        Options = [goDrawFocusSelected, goAlwaysShowEditor, goThumbTracking, goFixedRowDefAlign]
        ParentDoubleBuffered = False
        ScrollBars = ssVertical
        TabOrder = 0
        OnMouseUp = SGGMouseUp
        RowHeights = (
          24
          22
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24)
      end
    end
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
          ExplicitWidth = 1042
          ExplicitHeight = 188
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 520
    Width = 1050
    Height = 24
    Hint = 'Click to Toogle Speeds'
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
    ParentShowHint = False
    ShowHint = True
    OnClick = StatusBar1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 161
    Height = 301
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 7
      Top = 13
      Width = 39
      Height = 13
      Caption = 'TAGS  :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Font.Quality = fqAntialiased
      ParentFont = False
    end
    object CLBTags: TCheckListBox
      Left = 7
      Top = 29
      Width = 146
      Height = 116
      DoubleBuffered = True
      ItemHeight = 13
      ParentDoubleBuffered = False
      PopupMenu = PMTags
      Sorted = True
      TabOrder = 0
    end
  end
  object MainPopup: TPopupMenu
    Left = 264
    Top = 88
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
    object Reannounce1: TMenuItem
      Caption = 'Reannounce'
      OnClick = Reannounce1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Add1: TMenuItem
      Caption = 'Add'
      OnClick = Add1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete Torrent'
      object NoData1: TMenuItem
        Caption = 'Keep Data'
        OnClick = NoData1Click
      end
      object WithData1: TMenuItem
        Caption = #9888' With Data '#9888
        OnClick = WithData1Click
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ShowSelection1: TMenuItem
      Caption = 'Show Selection Hash'
      OnClick = ShowSelection1Click
    end
    object PMMainPause: TMenuItem
      Caption = 'Pause'
      OnClick = PMMainPauseClick
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
    object N3: TMenuItem
      Caption = '-'
    end
    object PMPausePeers: TMenuItem
      Caption = 'Pause'
      OnClick = PMPausePeersClick
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
  object PMTags: TPopupMenu
    Left = 24
    Top = 40
    object PMTags1: TMenuItem
      Caption = 'Apply'
      OnClick = PMTags1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Add2: TMenuItem
      Caption = 'Add'
    end
    object Remove1: TMenuItem
      Caption = 'Remove'
    end
  end
end
