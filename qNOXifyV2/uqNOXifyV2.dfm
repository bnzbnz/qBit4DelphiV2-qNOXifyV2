object FrmSTG: TFrmSTG
  Left = 0
  Top = 0
  Caption = 'qNOXify V2'
  ClientHeight = 701
  ClientWidth = 1443
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 677
    Width = 1443
    Height = 24
    Hint = 'Click to Toogle Speeds'
    Panels = <
      item
        Alignment = taCenter
        Bevel = pbNone
        Text = 'Status'
        Width = 256
      end
      item
        Alignment = taCenter
        Bevel = pbNone
        Text = 'dht'
        Width = 160
      end
      item
        Alignment = taCenter
        Text = 'Available Disk Space'
        Width = 240
      end
      item
        Alignment = taRightJustify
        Text = 'dl'
        Width = 200
      end>
    ParentShowHint = False
    ShowHint = True
    OnClick = StatusBar1Click
  end
  object PCMain: TPageControl
    Left = 0
    Top = 0
    Width = 1443
    Height = 677
    ActivePage = Torrent
    Align = alClient
    TabOrder = 1
    OnChange = PCMainChange
    object TabSheet2: TTabSheet
      Caption = '  qBit / NOX  '
      object Splitter1: TSplitter
        Left = 0
        Top = 454
        Width = 1435
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 33
        ExplicitWidth = 395
      end
      inline MainFrame: TqBitFrame
        Left = 0
        Top = 33
        Width = 1435
        Height = 421
        Align = alClient
        TabOrder = 0
        ExplicitTop = 33
        ExplicitWidth = 1435
        ExplicitHeight = 421
        inherited SG: TStringGrid
          Width = 1435
          Height = 421
          FixedCols = 2
          ExplicitWidth = 1435
          ExplicitHeight = 421
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
        inherited PMColHdr: TPopupMenu
          AutoPopup = False
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1435
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label3: TLabel
          Left = 4
          Top = 9
          Width = 54
          Height = 13
          Caption = 'FILTERS  :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Font.Quality = fqAntialiased
          ParentFont = False
        end
        object EDFilter: TEdit
          Left = 73
          Top = 5
          Width = 256
          Height = 21
          Hint = 'Search by Description + Ctegory + Tag'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object BitBtn1: TBitBtn
          Left = 328
          Top = 4
          Width = 22
          Height = 23
          Caption = 'X'
          TabOrder = 1
          OnClick = BitBtn1Click
        end
        object BitBtn2: TBitBtn
          Left = 520
          Top = 5
          Width = 23
          Height = 21
          Caption = 'X'
          TabOrder = 2
          OnClick = BitBtn2Click
        end
        object CBCats: TComboBox
          Left = 376
          Top = 5
          Width = 145
          Height = 21
          Style = csDropDownList
          DoubleBuffered = False
          ParentDoubleBuffered = False
          TabOrder = 3
          Items.Strings = (
            'aa'
            'bb'
            'vvv')
        end
      end
      object PageControl1: TPageControl
        Left = 0
        Top = 457
        Width = 1435
        Height = 192
        ActivePage = TabSheet1
        Align = alBottom
        TabOrder = 2
        OnChange = PageControl1Change
        object TabSheet1: TTabSheet
          Caption = 'Torrent Info.'
          object SGG: TStringGrid
            Left = 0
            Top = 0
            Width = 1427
            Height = 164
            Hint = 'Search by Description + Ctegory + Tag'
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
            Width = 1427
            Height = 164
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 1427
            ExplicitHeight = 164
            inherited SG: TStringGrid
              Width = 1427
              Height = 164
              ExplicitWidth = 1427
              ExplicitHeight = 164
            end
          end
        end
        object TrakersTabSheet: TTabSheet
          Caption = 'Trackers'
          ImageIndex = 1
          inline TrackersFrame: TqBitFrame
            Left = 0
            Top = 0
            Width = 1427
            Height = 164
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 1427
            ExplicitHeight = 164
            inherited SG: TStringGrid
              Width = 1427
              Height = 164
              ExplicitWidth = 1427
              ExplicitHeight = 164
            end
          end
        end
      end
    end
    object Torrent: TTabSheet
      Caption = 'Torrents'
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1435
        Height = 33
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 1271
          Top = 1
          Width = 163
          Height = 31
          Align = alRight
          Caption = 'Ctrl+Clcik to open on new window'
          Layout = tlCenter
          ExplicitHeight = 13
        end
        object ComboBox1: TComboBox
          Left = 93
          Top = 5
          Width = 256
          Height = 21
          TabOrder = 0
          OnKeyPress = ComboBox1KeyPress
          Items.Strings = (
            'https://google.com'
            'https://fitgirl-repacks.site'
            'https://ygg.re'
            'https://DelphiFan.com')
        end
        object BackBtn: TButton
          Left = 0
          Top = 2
          Width = 25
          Height = 25
          Caption = '3'
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Webdings'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = BackBtnClick
        end
        object ForwardBtn: TButton
          Left = 31
          Top = 2
          Width = 25
          Height = 25
          Caption = '4'
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Webdings'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = ForwardBtnClick
        end
        object ReloadBtn: TButton
          Left = 62
          Top = 2
          Width = 25
          Height = 25
          Caption = 'q'
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Webdings'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = ReloadBtnClick
        end
        object GoBtn: TButton
          Left = 354
          Top = 3
          Width = 25
          Height = 25
          Caption = #9658
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = GoBtnClick
        end
      end
      object WVWindowParent1: TWVWindowParent
        Left = 0
        Top = 33
        Width = 1435
        Height = 616
        Align = alClient
        TabOrder = 1
        Browser = WVBrowser1
      end
    end
  end
  object MainPopup: TPopupMenu
    AutoHotkeys = maManual
    OnClose = MainPopupClose
    OnPopup = MainPopupPopup
    Left = 288
    Top = 72
    object SelectAll1: TMenuItem
      Caption = 'Select All'
      OnClick = SelectAll1Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
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
    object N8: TMenuItem
      Caption = '-'
    end
    object CatsMenu: TMenuItem
      Caption = 'Categories'
    end
    object TagsMenu: TMenuItem
      Caption = 'Tags'
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Add1: TMenuItem
      Caption = 'Add'
      object Files1: TMenuItem
        Caption = 'Files'
        OnClick = Files1Click
      end
      object Magnet1: TMenuItem
        Caption = 'Magnet'
        OnClick = Magnet1Click
      end
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
    object Download1: TMenuItem
      Caption = 'Download (WinSCP)'
      OnClick = Download1Click
    end
    object UploadWinSCP1: TMenuItem
      Caption = 'Upload  (WinSCP)'
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object ShowSelection1: TMenuItem
      Caption = 'Show Selection Hash'
      OnClick = ShowSelection1Click
    end
    object PMMainPause: TMenuItem
      Caption = 'Pause Display'
      OnClick = PMMainPauseClick
    end
  end
  object PeersPopup: TPopupMenu
    Left = 420
    Top = 112
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
      Caption = 'Pause Display'
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
    Left = 328
    Top = 184
  end
  object MainMenu1: TMainMenu
    Left = 152
    Top = 96
    object File1: TMenuItem
      Caption = 'File'
      object AddFiles1: TMenuItem
        Caption = 'Add Files'
        OnClick = Files1Click
      end
      object AddURL1: TMenuItem
        Caption = 'Add URL'
        OnClick = Magnet1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MMLogout: TMenuItem
        Caption = 'Logout'
        OnClick = MMLogoutClick
      end
      object MMExitqBittorent: TMenuItem
        Caption = 'Exit qBittorent'
        OnClick = MMExitqBittorentClick
      end
    end
    object About1: TMenuItem
      Caption = 'About'
      OnClick = About1Click
    end
  end
  object DlgSaveTorrent: TOpenDialog
    Left = 180
    Top = 184
  end
  object WVBrowser1: TWVBrowser
    TargetCompatibleBrowserVersion = '132.0.2957.106'
    AllowSingleSignOnUsingOSPrimaryAccount = False
    OnAfterCreated = WVBrowser1AfterCreated
    OnNavigationStarting = WVBrowser1NavigationStarting
    OnNavigationCompleted = WVBrowser1NavigationCompleted
    OnNewWindowRequested = WVBrowser1NewWindowRequested
    OnWebResourceRequested = WVBrowser1WebResourceRequested
    OnDownloadStarting = WVBrowser1DownloadStarting
    OnDownloadStateChanged = WVBrowser1DownloadStateChanged
    OnLaunchingExternalUriScheme = WVBrowser1LaunchingExternalUriScheme
    Left = 332
    Top = 360
  end
  object TrayIcon1: TTrayIcon
    PopupMenu = PMTray
    OnDblClick = TrayIcon1DblClick
    Left = 540
    Top = 248
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 652
    Top = 272
  end
  object PMTray: TPopupMenu
    Left = 484
    Top = 360
    object Logout1: TMenuItem
      Caption = 'Logout'
    end
  end
end
