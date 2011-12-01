object frmKeyInsertText: TfrmKeyInsertText
  Left = 324
  Top = 264
  BorderStyle = bsDialog
  Caption = #1050#1083#1072#1074#1080#1096#1080' '#1085#1072' '#1074#1089#1090#1072#1074#1082#1091
  ClientHeight = 238
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton3: TSpeedButton
    Left = 232
    Top = 176
    Width = 97
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton3Click
  end
  object Label1: TLabel
    Left = 232
    Top = 88
    Width = 77
    Height = 13
    Caption = #1042#1089#1090#1072#1074#1083#1103#1090#1100' '#1082#1072#1082':'
  end
  object Label2: TLabel
    Left = 232
    Top = 48
    Width = 45
    Height = 13
    Caption = #1050#1083#1072#1074#1080#1096#1072
  end
  object Bevel1: TBevel
    Left = 232
    Top = 168
    Width = 97
    Height = 9
    Shape = bsTopLine
  end
  object Label3: TLabel
    Left = 232
    Top = 8
    Width = 30
    Height = 13
    Caption = #1058#1077#1082#1089#1090
  end
  object SpeedButton1: TSpeedButton
    Left = 232
    Top = 136
    Width = 41
    Height = 25
    Caption = '+'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SpeedButton2: TSpeedButton
    Left = 288
    Top = 136
    Width = 41
    Height = 25
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object HotKey1: THotKey
    Left = 232
    Top = 64
    Width = 97
    Height = 19
    HotKey = 0
    Modifiers = []
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 232
    Top = 104
    Width = 97
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    Items.Strings = (
      #1060#1091#1085#1082#1094#1080#1103
      #1054#1087#1077#1088#1072#1094#1080#1103
      #1059#1085#1072#1088#1085#1099#1081' '#1084#1080#1085#1091#1089
      #1060#1072#1082#1090#1086#1088#1080#1072#1083
      #1055#1088#1086#1089#1090#1086' '#1090#1077#1082#1089#1090)
  end
  object Button1: TButton
    Left = 232
    Top = 208
    Width = 97
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 232
    Top = 24
    Width = 97
    Height = 21
    TabOrder = 3
  end
  object vleTexts: TValueListEditor
    Left = 0
    Top = 8
    Width = 225
    Height = 225
    DefaultColWidth = 100
    TabOrder = 4
    TitleCaptions.Strings = (
      #1058#1077#1082#1089#1090
      #1050#1083#1072#1074#1080#1096#1072)
    ColWidths = (
      100
      119)
  end
end
