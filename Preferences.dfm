object Options: TOptions
  Left = 457
  Top = 225
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 366
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    469
    366)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 5
    Top = 5
    Width = 462
    Height = 320
    ActivePage = tsUpdate
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1054#1073#1097#1080#1077
      object SaveHistory: TCheckBox
        Left = 10
        Top = 25
        Width = 376
        Height = 17
        Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1080#1089#1090#1086#1088#1080#1102' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1081' '#1087#1086#1089#1083#1077' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = HistoryClick
      end
      object HistoryCount: TEdit
        Left = 283
        Top = 5
        Width = 86
        Height = 21
        Hint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1084#1077#1090#1086#1082' '#1074' '#1080#1089#1090#1086#1088#1080#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 3
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Text = '20'
        OnChange = HistoryClick
      end
      object UpDown1: TUpDown
        Left = 369
        Top = 5
        Width = 16
        Height = 21
        Associate = HistoryCount
        Position = 20
        TabOrder = 2
      end
      object History: TCheckBox
        Left = 10
        Top = 5
        Width = 166
        Height = 17
        Caption = #1042#1077#1089#1090#1080' '#1080#1089#1090#1086#1088#1080#1102' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1081
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = HistoryClick
      end
      object AddNulles: TCheckBox
        Left = 10
        Top = 45
        Width = 376
        Height = 17
        Caption = #1044#1086#1073#1072#1074#1083#1103#1090#1100' '#1085#1091#1083#1080' '#1074' '#1082#1086#1085#1077#1094' '#1087#1088#1080' '#1089#1086#1082#1088#1072#1097#1077#1085#1080#1080
        TabOrder = 4
        OnClick = HistoryClick
      end
      object StickyWindow: TCheckBox
        Left = 10
        Top = 65
        Width = 376
        Height = 17
        Caption = #1051#1080#1087#1082#1080#1077' '#1086#1082#1085#1072' ('#1075#1083#1072#1074#1085#1086#1077', '#1086#1082#1085#1086' '#1087#1077#1088#1077#1084#1077#1085#1085#1099#1093' '#1080' '#1080#1089#1090#1086#1088#1080#1080')'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = HistoryClick
      end
      object HideOnInactive: TCheckBox
        Left = 10
        Top = 85
        Width = 376
        Height = 17
        Caption = #1057#1082#1088#1099#1074#1072#1090#1100' '#1086#1082#1085#1086' '#1087#1088#1080' '#1087#1086#1090#1077#1088#1077' '#1092#1086#1082#1091#1089#1072
        Checked = True
        State = cbChecked
        TabOrder = 6
        OnClick = HistoryClick
      end
      object ClearMemoryOnExit: TCheckBox
        Left = 10
        Top = 105
        Width = 376
        Height = 17
        Caption = #1054#1095#1080#1097#1072#1090#1100' '#1087#1072#1084#1103#1090#1100' '#1087#1088#1080' '#1074#1099#1093#1086#1076#1077
        TabOrder = 7
        OnClick = HistoryClick
      end
      object AutoBoot: TCheckBox
        Left = 10
        Top = 125
        Width = 376
        Height = 17
        Caption = #1040#1074#1090#1086#1079#1072#1075#1088#1091#1079#1082#1072' '#1074#1084#1077#1089#1090#1077' '#1089' Windows'
        TabOrder = 8
        OnClick = HistoryClick
      end
      object AutoReplaceLayout: TCheckBox
        Left = 10
        Top = 145
        Width = 261
        Height = 17
        Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1084#1077#1085#1103#1090#1100' '#1088#1072#1089#1082#1083#1072#1076#1082#1091' '#1082#1083#1072#1074#1080#1072#1090#1091#1088#1099
        Checked = True
        State = cbChecked
        TabOrder = 9
        OnClick = HistoryClick
      end
      object SaveVariables: TCheckBox
        Left = 10
        Top = 165
        Width = 286
        Height = 17
        Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1087#1077#1088#1077#1084#1077#1085#1085#1099#1077' '#1080' '#1080#1093' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1088#1080' '#1074#1099#1093#1086#1076#1077
        TabOrder = 10
        OnClick = HistoryClick
      end
      object StayOnTop: TCheckBox
        Left = 10
        Top = 185
        Width = 121
        Height = 17
        Caption = #1055#1086#1074#1077#1088#1093' '#1074#1089#1077#1093' '#1086#1082#1086#1085
        TabOrder = 11
        OnClick = HistoryClick
      end
      object DoNotTerminateOnClose: TCheckBox
        Left = 10
        Top = 205
        Width = 335
        Height = 17
        Caption = #1053#1077' '#1079#1072#1074#1077#1088#1096#1072#1090#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077' '#1087#1088#1080' '#1085#1072#1078#1072#1090#1080#1080' '#1085#1072' '#1082#1085#1086#1087#1082#1091' '#1079#1072#1082#1088#1099#1090#1080#1103
        Checked = True
        State = cbChecked
        TabOrder = 12
        OnClick = HistoryClick
      end
      object ShowHintWindowOnClick: TCheckBox
        Left = 10
        Top = 225
        Width = 287
        Height = 17
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1076#1083#1080#1085#1085#1091#1102' '#1089#1090#1088#1086#1082#1091' '#1087#1088#1080' '#1097#1077#1083#1095#1082#1077' '#1074' '#1080#1089#1090#1086#1088#1080#1080
        Checked = True
        State = cbChecked
        TabOrder = 13
        OnClick = HistoryClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1050#1083#1072#1074#1080#1096#1080
      ImageIndex = 1
      object Bevel1: TBevel
        Left = 5
        Top = 110
        Width = 381
        Height = 11
        Shape = bsTopLine
      end
      object Label2: TLabel
        Left = 4
        Top = 121
        Width = 75
        Height = 13
        Caption = #1058#1077#1089#1090#1086#1074#1086#1077' '#1087#1086#1083#1077
      end
      object Label3: TLabel
        Left = 6
        Top = 148
        Width = 375
        Height = 91
        Caption = 
          #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077'. '#1058#1077#1089#1090#1086#1074#1086#1077' '#1087#1086#1083#1077' '#1087#1088#1077#1076#1085#1072#1079#1085#1072#1095#1077#1085#1086' '#1076#1083#1103' '#1090#1077#1089#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1085#1077#1082#1086#1090#1086#1088 +
          #1099#1093' '#1082#1083#1072#1074#1080#1096'. '#1071' '#1084#1086#1075' '#1073#1099' '#1087#1086#1089#1090#1072#1074#1080#1090#1100' '#1090#1072#1082#1086#1077' '#1087#1086#1083#1077' '#1074#1084#1077#1089#1090#1086' '#1087#1088#1086#1089#1090#1099#1093' '#1087#1086#1083#1077#1081' '#1088#1077 +
          #1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1089#1074#1077#1088#1093#1091', '#1085#1086' '#1085#1077' '#1089#1076#1077#1083#1072#1083' '#1101#1090#1086' '#1080#1079'-'#1079#1072' '#1090#1086#1075#1086' '#1095#1090#1086' '#1086#1085#1086' '#1085#1077' '#1087#1086#1076#1076 +
          #1077#1088#1078#1080#1074#1072#1077#1090' '#1074#1089#1077' '#1074#1086#1079#1084#1086#1078#1085#1099#1077' '#1089#1086#1095#1077#1090#1072#1085#1080#1103' '#1082#1083#1072#1074#1080#1096', '#1085#1072#1087#1088#1080#1084#1077#1088' [Delete]. '#1040' '#1074' ' +
          #1087#1088#1086#1089#1090#1099#1093' '#1087#1086#1083#1103#1093' '#1084#1086#1078#1085#1086' '#1085#1072#1087#1080#1089#1072#1090#1100' '#1095#1090#1086' '#1091#1075#1086#1076#1085#1086' ('#1075#1083#1072#1074#1085#1086#1077', '#1095#1090#1086#1073#1099' '#1090#1072#1082#1080#1077' '#1082#1083 +
          #1072#1074#1080#1096#1080' '#1073#1099#1083#1080'). '#1042' '#1089#1083#1091#1095#1072#1077' '#1089' [Delete] '#1074' '#1079#1072#1074#1080#1089#1080#1084#1086#1089#1090#1080' '#1086#1090' '#1054#1057' '#1085#1091#1078#1085#1086' '#1087#1080#1089#1072#1090 +
          #1100' Del '#1080#1083#1080' Delete. '
        WordWrap = True
      end
      object SpeedButton1: TSpeedButton
        Left = 176
        Top = 80
        Width = 23
        Height = 22
        Caption = '...'
        Visible = False
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 368
        Top = 136
        Width = 23
        Height = 22
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000010000000000000101
          0100020202000303030004040400050505000606060007070700080808000909
          09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
          1100121212001313130014141400151515001616160017171700181818001919
          19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
          2100222222002323230024242400252525002626260027272700282828002929
          29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E0033303000383232003C34
          33004135350045373600483838004C3939004F3A3A00523B3B00563D3C005A3E
          3D005D3E3E00613F3F0064403F0067404000694140006A4140006C4140006D41
          41006E4241006E4241006F4241006F4241007042410071424100724241007243
          4100734342007544430076464400784745007B4946007D4B4700814F4A008552
          4C0089554E008D595100925D540096605600996357009C6559009E685B00A069
          5C00A16B5D00A26C5E00A26D5F00A16C5E00A16C5E00A16C5E00A06B5E00A06A
          5D009F695D009F695C009E685C009D675C009B665B009A655B0099645B009863
          5A0096625A0094615A0092605A00905F59008F5E59008F5E59008E5E59008C5E
          59008B5E5A00895F5B0086605D0085615F008464610083676500826B6900826C
          6A00826D6C00826F6D0082716F0082737100827574008277760082797900827C
          7C00827F7F00838383008484840085858500927F8C009F7A9300A9749A00B967
          A700C55BB200D04FBC00D846C500E238D000E92ED900EF22E300F516EC00F90E
          F300FB09F700FD05FA00FD03FC00FE01FD00FE01FE00FE00FE00FE00FE00FE00
          FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
          FE00FE00FE00FE00FE00FE00FE00FF00FF00FE00FE00FE00FE00FE00FE00FE00
          FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
          FE00FE00FE00FE00FE00FE01FE00FE02FD00FE03FC00FD06FA00F912F000F326
          DD00ED3ACB00E74DBB00E25EAD00DE6AA300D97A9500D6848B00D38E8600CF96
          8500D1977A00D2977300CF957100CC926F00CB916E00CA8F6E00C98E6D00C88D
          6C00C98E6C00CB8F6C00CC8F6B00CE906B00D0916B00D1926800D4915F00D690
          5700D88E4C00DA8E4400DB8E3E00DC8E3C00DC8E3B00DC8E3A00DD8E3B00DD90
          3D00DD913E00DD913F00DE924000DF944300E1974500E2994700E39A4900E39B
          4B00E49E5100E6A35A00E9A86200EDAF6D00F0B57600F5BD8400F8C48F00FAC9
          9800FCCE9F00FDD1A600FED5AC00FED7B000FED9B300FDDBB900FDDDBE00FCDE
          C000FADEC300F9DFC700F8E2CE00F8E4D200F8E8D800FAEBDE00FBEEE200FCF1
          E600FDF4EB00FDF6EE00FEF8F100FEF9F500FEFAF700FEFAF700A5A5A5A5A570
          707070707070707048A5A5A5A5A5A56CF0EEECEBEAE9E8E848A5A5A5A5A5A566
          F3D9D9D9D9D9D9E948A5A5A5A5A5A55DF6F4F1EFEDECEAEA48A570707070705C
          F8D9D9D9D9D9D9EB48A56CF0EEECEB5CF9F8F6F5F3F0EEEC48A566F3D9D9D9C9
          FCD9D9D9D9D9D9EF48A55DF6F4F1EFC9FEFCFAF9F7F6F4F148A55CF8D9D9D9C5
          FFFFFCFBF9F4C18748A55CF9F8F6F5C3FFFFFFFDFB58585857A5C9FCD9D9D9C3
          FFFFFFFFFE58E2D7A5A5C9FEFCFAF9E4CECECECECE58E0A5A5A5C5FFFFFCFBF9
          F4C18748A5A5A5A5A5A5C3FFFFFFFDFB58585857A5A5A5A5A5A5C3FFFFFFFFFE
          58E2D7A5A5A5A5A5A5A5E4CECECECECE58E0A5A5A5A5A5A5A5A5}
        OnClick = SpeedButton2Click
      end
      object EnableShow: TCheckBox
        Left = 5
        Top = 5
        Width = 131
        Height = 17
        Caption = #1055#1086#1082#1072#1079#1072#1090#1100' / '#1057#1082#1088#1099#1090#1100
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = HistoryClick
      end
      object EnableHide: TCheckBox
        Left = 5
        Top = 30
        Width = 66
        Height = 17
        Caption = #1057#1082#1088#1099#1090#1100
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = HistoryClick
      end
      object EnableClear: TCheckBox
        Left = 5
        Top = 55
        Width = 176
        Height = 17
        Caption = #1054#1095#1080#1089#1090#1082#1072' '#1087#1086#1083#1103' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1081
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = HistoryClick
      end
      object edtShow: TEdit
        Left = 177
        Top = 5
        Width = 208
        Height = 21
        TabOrder = 3
        Text = 'Ctrl + Left'
        OnChange = HistoryClick
      end
      object edtHide: TEdit
        Left = 177
        Top = 30
        Width = 208
        Height = 21
        TabOrder = 4
        Text = 'Esc'
        OnChange = HistoryClick
      end
      object edtClearField: TEdit
        Left = 177
        Top = 55
        Width = 208
        Height = 21
        TabOrder = 5
        Text = 'End'
        OnChange = HistoryClick
      end
      object TestEdit: THotKey
        Left = 96
        Top = 119
        Width = 265
        Height = 19
        HotKey = 46
        Modifiers = []
        TabOrder = 6
      end
      object EnableInsertTexts: TCheckBox
        Left = 5
        Top = 79
        Width = 124
        Height = 17
        Caption = #1042#1089#1090#1072#1074#1082#1072' '#1074#1099#1088#1072#1078#1077#1085#1080#1081
        Checked = True
        State = cbChecked
        TabOrder = 7
        Visible = False
        OnClick = HistoryClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1048#1085#1074#1077#1088#1090#1080#1088#1091#1077#1084#1099#1077' '#1082#1085#1086#1087#1082#1080
      ImageIndex = 2
      object Label1: TLabel
        Left = 200
        Top = 40
        Width = 150
        Height = 39
        Caption = 
          #1055#1077#1088#1077#1076' '#1090#1077#1084' '#1082#1072#1082' '#1079#1072#1087#1080#1089#1099#1074#1072#1090#1100' '#1089#1084#1086#1090#1088#1080#1090#1077' '#1085#1072#1083#1080#1095#1080#1077' '#1092#1091#1085#1082#1094#1080#1081' '#1074' '#1073#1080#1073#1083#1080#1086#1090#1077#1082#1077' (' +
          #1082#1085#1086#1087#1082#1072' '#1042#1057#1045')'
        WordWrap = True
      end
      object Bevel2: TBevel
        Left = 200
        Top = 144
        Width = 185
        Height = 9
        Shape = bsTopLine
      end
      object Label5: TLabel
        Left = 200
        Top = 160
        Width = 168
        Height = 78
        Caption = 
          #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1088#1077#1076#1085#1072#1079#1085#1072#1095#1077#1085#1086' '#1076#1083#1103' '#1073#1099#1089#1090#1088#1086#1081' '#1089#1084#1077#1085#1099' '#1092#1091#1085#1082#1094#1080#1081' '#1085#1072' '#1087#1072#1085#1077#1083#1080 +
          ' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074' '#1082#1085#1086#1087#1082#1086#1081' "'#1048#1085#1074'". '#1052#1086#1078#1085#1086' '#1089#1076#1077#1083#1072#1090#1100' '#1084#1085#1086#1075#1086' '#1088#1072#1079#1083#1080#1095#1085#1099#1093' '#1087#1088#1077#1086#1073 +
          #1088#1072#1079#1086#1074#1072#1085#1080#1081' '#1092#1091#1085#1082#1094#1080#1081'.'
        WordWrap = True
      end
      object memoInvFunctions: TMemo
        Left = 5
        Top = 5
        Width = 186
        Height = 241
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        Lines.Strings = (
          'SIN=arcsin'
          'COS=arccos'
          'TG=arctg'
          'CTG=arcctg'
          'arcsin=SIN'
          'arccos=COS'
          'arctg=TG'
          'arcctg=CTG')
        ParentFont = False
        TabOrder = 0
      end
      object SaveInvParamsToFile: TButton
        Left = 200
        Top = 5
        Width = 186
        Height = 25
        Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074' INI-'#1092#1072#1081#1083
        Default = True
        TabOrder = 1
        OnClick = SaveInvParamsToFileClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1055#1072#1085#1077#1083#1080' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
      ImageIndex = 3
      TabVisible = False
      object Label4: TLabel
        Left = 8
        Top = 8
        Width = 115
        Height = 13
        Caption = #1055#1072#1085#1077#1083#1080' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074':'
      end
      object clbPanelsVisible: TCheckListBox
        Left = 8
        Top = 24
        Width = 377
        Height = 105
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 16
        Items.Strings = (
          #1054#1089#1085#1086#1074#1085#1072#1103' '#1087#1072#1085#1077#1083#1100
          #1042#1089#1087#1086#1084#1086#1075#1072#1090#1077#1083#1100#1085#1072#1103' '#1087#1072#1085#1077#1083#1100
          #1055#1072#1085#1077#1083#1100' '#1092#1091#1085#1082#1094#1080#1081)
        ParentFont = False
        TabOrder = 0
        OnEnter = HistoryClick
      end
    end
    object tsUpdate: TTabSheet
      Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077
      ImageIndex = 4
      object Label6: TLabel
        Left = 304
        Top = 40
        Width = 30
        Height = 13
        Caption = #1084#1080#1085#1091#1090
      end
      object Label7: TLabel
        Left = 8
        Top = 40
        Width = 214
        Height = 13
        Caption = #1055#1088#1086#1074#1077#1088#1103#1090#1100' '#1085#1072#1083#1080#1095#1080#1077' '#1085#1086#1074#1086#1081' '#1074#1077#1088#1089#1080#1080' '#1082#1072#1078#1076#1099#1077
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 8
        Width = 225
        Height = 17
        Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1086#1073#1085#1086#1074#1083#1103#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1091
        TabOrder = 0
      end
      object Edit1: TEdit
        Left = 240
        Top = 40
        Width = 57
        Height = 21
        TabOrder = 1
        Text = '30'
      end
      object Button1: TButton
        Left = 8
        Top = 256
        Width = 121
        Height = 25
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1074#1088#1091#1095#1085#1091#1102
        TabOrder = 2
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 128
        Width = 433
        Height = 113
        TabOrder = 3
        object CheckBox2: TCheckBox
          Left = 8
          Top = 0
          Width = 161
          Height = 17
          Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1087#1088#1086#1082#1089#1080
          TabOrder = 0
        end
      end
    end
  end
  object btnOK: TBitBtn
    Left = 231
    Top = 334
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 311
    Top = 334
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object btnApply: TBitBtn
    Left = 391
    Top = 334
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = btnApplyClick
  end
  object KeyList: TPopupMenu
    Left = 372
    Top = 72
    object Esc1: TMenuItem
      Caption = 'Esc'
    end
    object Del1: TMenuItem
      Caption = 'Del'
    end
    object Pause1: TMenuItem
      Caption = 'Pause'
    end
    object NumLock1: TMenuItem
      Caption = 'NumLock'
    end
    object CapsLock1: TMenuItem
      Caption = 'CapsLock'
    end
    object ScrollLock1: TMenuItem
      Caption = 'ScrollLock'
    end
    object Backspace1: TMenuItem
      Caption = 'Backspace'
    end
    object Home1: TMenuItem
      Caption = 'Home'
    end
    object End1: TMenuItem
      Caption = 'End'
    end
    object Insert1: TMenuItem
      Caption = 'Insert'
    end
    object PageUp1: TMenuItem
      Caption = 'PageUp'
    end
    object PageDown1: TMenuItem
      Caption = 'PageDown'
    end
  end
end
