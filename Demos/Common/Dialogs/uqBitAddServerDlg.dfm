object qBitAddServerDlg: TqBitAddServerDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add a qBittorrent Server :'
  ClientHeight = 321
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 305
    Height = 305
  end
  object BtnOK: TButton
    Left = 149
    Top = 279
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = BtnOKClick
  end
  object BtnCancel: TButton
    Left = 230
    Top = 279
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object PageControl2: TPageControl
    Left = 16
    Top = 24
    Width = 289
    Height = 246
    ActivePage = TabSheet1
    TabOrder = 2
    object TabSheet3: TTabSheet
      Caption = '  qBit / NOX  '
      ImageIndex = 1
      object HP: TLabeledEdit
        Left = 11
        Top = 53
        Width = 257
        Height = 21
        EditLabel.Width = 48
        EditLabel.Height = 13
        EditLabel.Caption = 'HostPath:'
        EditLabel.DragMode = dmAutomatic
        TabOrder = 0
        Text = 'http://127.0.0.1:8080'
      end
      object UN: TLabeledEdit
        Left = 11
        Top = 96
        Width = 257
        Height = 21
        EditLabel.Width = 55
        EditLabel.Height = 13
        EditLabel.Caption = 'Username :'
        EditLabel.DragMode = dmAutomatic
        TabOrder = 1
        Text = ''
      end
      object PW: TLabeledEdit
        Left = 11
        Top = 140
        Width = 257
        Height = 21
        EditLabel.Width = 53
        EditLabel.Height = 13
        EditLabel.Caption = 'Password :'
        EditLabel.DragMode = dmAutomatic
        PasswordChar = '*'
        TabOrder = 2
        Text = ''
      end
    end
    object TabSheet2: TTabSheet
      Caption = '  SFTP  '
      ImageIndex = 1
      object Label2: TLabel
        Left = 16
        Top = 23
        Width = 17
        Height = 13
        Caption = 'IP :'
      end
      object Label1: TLabel
        Left = 16
        Top = 50
        Width = 27
        Height = 13
        Caption = 'Port :'
      end
      object Label3: TLabel
        Left = 16
        Top = 77
        Width = 59
        Height = 13
        Caption = 'User Name :'
      end
      object Label4: TLabel
        Left = 16
        Top = 104
        Width = 57
        Height = 13
        Caption = 'Certificate :'
      end
      object Edit1: TEdit
        Left = 88
        Top = 19
        Width = 185
        Height = 21
        TabOrder = 0
      end
      object Edit2: TEdit
        Left = 88
        Top = 46
        Width = 185
        Height = 21
        TabOrder = 1
        Text = '22'
      end
      object Edit3: TEdit
        Left = 88
        Top = 73
        Width = 185
        Height = 21
        TabOrder = 2
      end
      object Edit4: TEdit
        Left = 88
        Top = 100
        Width = 161
        Height = 21
        Enabled = False
        PasswordChar = '*'
        TabOrder = 3
      end
      object Button2: TButton
        Left = 247
        Top = 100
        Width = 25
        Height = 21
        Caption = '...'
        TabOrder = 4
        OnClick = Button2Click
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Vnstat'
      ImageIndex = 2
      object Label6: TLabel
        Left = 3
        Top = 15
        Width = 51
        Height = 13
        Caption = 'Json URL :'
      end
      object Label7: TLabel
        Left = 3
        Top = 61
        Width = 52
        Height = 13
        Caption = 'Interface :'
      end
      object Label5: TLabel
        Left = 200
        Top = 61
        Width = 62
        Height = 13
        Caption = 'Stop at (TB):'
      end
      object Edit5: TEdit
        Left = 3
        Top = 34
        Width = 275
        Height = 21
        TabOrder = 0
      end
      object Memo2: TMemo
        Left = 3
        Top = 120
        Width = 275
        Height = 95
        Lines.Strings = (
          'Use a server running vnstat, a webserver(nginx, '
          'lighthttpd, apache...), php'
          'Create a php script:  '
          '<?php passthru('#39'vnstat --json'#39'); ?>'
          'TEST IT with your web browser (the passthru '
          'function may have been disbled in php.ini)')
        TabOrder = 1
      end
      object Edit6: TEdit
        Left = 3
        Top = 80
        Width = 174
        Height = 21
        TabOrder = 2
      end
      object SE1: TSpinEdit
        Left = 200
        Top = 80
        Width = 63
        Height = 22
        MaxValue = 1000
        MinValue = 1
        TabOrder = 3
        Value = 95
      end
    end
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileName = 'D:\Dev\Delphi\qBit4DelphiV2\API\TGPuttyLib'
    FileTypes = <
      item
        DisplayName = 'Putty Private Key File'
        FileMask = '*.ppk'
      end>
    Options = []
    Left = 232
    Top = 16
  end
end
