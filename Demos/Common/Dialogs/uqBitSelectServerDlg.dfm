object qBitSelectServerDlg: TqBitSelectServerDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select a qBittorrent Server :'
  ClientHeight = 264
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    503
    264)
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 241
    Height = 217
  end
  object VerLabel: TLabel
    Left = 16
    Top = 228
    Width = 41
    Height = 13
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'VerLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BtnSel: TButton
    Left = 329
    Top = 231
    Width = 75
    Height = 25
    Caption = 'Select'
    Enabled = False
    ModalResult = 1
    TabOrder = 0
    OnClick = BtnSelClick
  end
  object BtnCancel: TButton
    Left = 410
    Top = 231
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object LBSrv: TListBox
    Left = 16
    Top = 19
    Width = 225
    Height = 163
    ExtendedSelect = False
    ItemHeight = 13
    TabOrder = 2
    OnClick = LBSrvClick
    OnDblClick = LBSrvDblClick
  end
  object btnAdd: TButton
    Left = 16
    Top = 188
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 3
    OnClick = btnAddClick
  end
  object BtnDel: TButton
    Left = 166
    Top = 188
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 4
    OnClick = BtnDelClick
  end
  object PageControl1: TPageControl
    Left = 247
    Top = 8
    Width = 242
    Height = 217
    ActivePage = TabSheet1
    TabOrder = 5
    object TabSheet1: TTabSheet
      Caption = 'Server Info'
      object SGInfo: TStringGrid
        Left = 6
        Top = 16
        Width = 221
        Height = 153
        BevelInner = bvNone
        BevelOuter = bvNone
        DefaultColWidth = 100
        RowCount = 8
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goFixedColDefAlign, goFixedRowDefAlign]
        ScrollBars = ssVertical
        TabOrder = 0
        OnSelectCell = SGInfoSelectCell
        RowHeights = (
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
  end
end
