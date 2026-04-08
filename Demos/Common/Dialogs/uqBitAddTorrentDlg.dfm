object qBitAddTorrentDlg: TqBitAddTorrentDlg
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Add Torrents :'
  ClientHeight = 951
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 764
    Height = 951
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 876
      Width = 756
      Height = 57
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alBottom
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 893
      ExplicitWidth = 760
      object Label12: TLabel
        Left = 32
        Top = 32
        Width = 282
        Height = 17
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '( Press CTRL while opening to show up again )'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object ChkDefault: TCheckBox
        Left = 30
        Top = 6
        Width = 146
        Height = 23
        Hint = 
          'Hide this dialog with these current parameters as default. Reena' +
          'ble by "shifting" while opening.'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Use as Default'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object BtnCancel: TButton
        Left = 623
        Top = 9
        Width = 112
        Height = 38
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
      object BtnOK: TButton
        Left = 501
        Top = 9
        Width = 113
        Height = 38
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Upload'
        ModalResult = 1
        TabOrder = 2
        OnClick = BtnOKClick
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 145
      Width = 756
      Height = 731
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 2
      ExplicitTop = 146
      ExplicitWidth = 760
      ExplicitHeight = 747
      object Bevel1: TBevel
        Left = 12
        Top = 9
        Width = 728
        Height = 425
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
      end
      object Label1: TLabel
        Left = 30
        Top = 33
        Width = 212
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Torrent Management Mode :'
      end
      object Label2: TLabel
        Left = 30
        Top = 114
        Width = 184
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Custom Download Path :'
      end
      object Label4: TLabel
        Left = 30
        Top = 195
        Width = 77
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Category :'
      end
      object Label3: TLabel
        Left = 30
        Top = 275
        Width = 132
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Rename Torrent :'
      end
      object Label5: TLabel
        Left = 435
        Top = 255
        Width = 166
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Limit Download Rate :'
      end
      object Label6: TLabel
        Left = 435
        Top = 338
        Width = 143
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Limit Upload Rate :'
      end
      object Label7: TLabel
        Left = 30
        Top = 350
        Width = 60
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Layout :'
      end
      object Label11: TLabel
        Left = 30
        Top = 609
        Width = 82
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Comment :'
      end
      object ComboBox2: TComboBox
        Left = 590
        Top = 366
        Width = 76
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 13
        Text = 'MiB'
        Items.Strings = (
          'KiB'
          'MiB')
      end
      object ComboBox1: TComboBox
        Left = 590
        Top = 284
        Width = 76
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 11
        Text = 'MiB'
        Items.Strings = (
          'KiB'
          'MiB')
      end
      object SpinEdit2: TSpinEdit
        Left = 503
        Top = 366
        Width = 78
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        MaxValue = 1024
        MinValue = 0
        TabOrder = 12
        Value = 0
      end
      object SpinEdit1: TSpinEdit
        Left = 503
        Top = 284
        Width = 78
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        MaxValue = 1024
        MinValue = 0
        TabOrder = 10
        Value = 0
      end
      object TTM: TComboBox
        Left = 30
        Top = 62
        Width = 329
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'Manual'
        OnChange = TTMChange
        Items.Strings = (
          'Manual'
          'Automatic')
      end
      object SFL: TEdit
        Left = 30
        Top = 143
        Width = 329
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 1
      end
      object RT: TEdit
        Left = 30
        Top = 303
        Width = 329
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 4
      end
      object CBCat: TComboBox
        Left = 30
        Top = 224
        Width = 329
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Style = csDropDownList
        TabOrder = 2
      end
      object CBCL: TComboBox
        Left = 30
        Top = 378
        Width = 329
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 5
        Text = 'Original'
        Items.Strings = (
          'Original'
          'Subfolder'
          'NoSubfolder')
      end
      object CBST: TCheckBox
        Left = 435
        Top = 68
        Width = 146
        Height = 25
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Start Torrent'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object CBSHT: TCheckBox
        Left = 435
        Top = 113
        Width = 146
        Height = 25
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Skip Hash Check'
        TabOrder = 7
      end
      object CBDSO: TCheckBox
        Left = 435
        Top = 207
        Width = 290
        Height = 26
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Download in Sequential Order'
        TabOrder = 9
      end
      object CBFLP: TCheckBox
        Left = 435
        Top = 161
        Width = 290
        Height = 25
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Download First and Last Pieces First'
        TabOrder = 8
      end
      object GroupBox1: TGroupBox
        Left = 12
        Top = 455
        Width = 728
        Height = 145
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Torrent Info :'
        TabOrder = 14
        object TILblName: TLabel
          Left = 18
          Top = 42
          Width = 54
          Height = 21
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Name :'
        end
        object TILblSize: TLabel
          Left = 18
          Top = 71
          Width = 41
          Height = 21
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Size :'
        end
        object Label8: TLabel
          Left = 18
          Top = 99
          Width = 106
          Height = 21
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Info Hash V1 :'
        end
        object Label9: TLabel
          Left = 18
          Top = 128
          Width = 106
          Height = 21
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Info Hash V2 :'
        end
        object Label10: TLabel
          Left = 20
          Top = 144
          Width = 106
          Height = 21
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Info Hash V2 :'
        end
        object Edit1: TEdit
          Left = -282
          Top = -48
          Width = 1500
          Height = 29
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          BevelInner = bvNone
          BevelOuter = bvNone
          ParentColor = True
          ReadOnly = True
          TabOrder = 0
          Text = 'Edit1'
        end
        object TIEditName: TEdit
          Left = 126
          Top = 42
          Width = 600
          Height = 26
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 1
          Text = 'TIEditName'
        end
        object TIEditSize: TEdit
          Left = 126
          Top = 71
          Width = 600
          Height = 25
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 2
          Text = 'TIEditName'
        end
        object TIEditHashV1: TEdit
          Left = 126
          Top = 99
          Width = 600
          Height = 26
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 3
          Text = 'TIEditName'
        end
        object TIEditHashV2: TEdit
          Left = 126
          Top = 128
          Width = 600
          Height = 25
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 4
          Text = 'TIEditName'
        end
      end
      object TIEditComment: TMemo
        Left = 138
        Top = 609
        Width = 600
        Height = 119
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Lines.Strings = (
          'TIEditComment')
        ParentColor = True
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 15
      end
      object BtnMgeCat: TButton
        Left = 356
        Top = 224
        Width = 28
        Height = 31
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 9
        Margins.Bottom = 5
        Caption = '....'
        TabOrder = 3
        OnClick = BtnMgeCatClick
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 762
      Height = 144
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Panel4'
      TabOrder = 2
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 760
      object LBFiles: TListBox
        Left = 12
        Top = 12
        Width = 728
        Height = 123
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ItemHeight = 20
        TabOrder = 0
        OnClick = LBFilesClick
      end
    end
  end
end
