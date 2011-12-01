object PluginWindow: TPluginWindow
  Left = 431
  Top = 221
  Width = 468
  Height = 390
  Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1075#1088#1072#1092#1080#1082#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 29
    Width = 460
    Height = 334
    Align = alClient
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 460
    Height = 29
    ButtonHeight = 23
    Caption = 'ToolBar1'
    TabOrder = 0
    object Label1: TLabel
      Left = 0
      Top = 2
      Width = 29
      Height = 23
      Caption = 'Y='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ExprEdit: TEdit
      Left = 29
      Top = 2
      Width = 313
      Height = 23
      TabOrder = 0
      Text = 'x^2'
    end
    object SpeedButton1: TSpeedButton
      Left = 342
      Top = 2
      Width = 23
      Height = 23
      Caption = '>'
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 32
    Width = 457
    Height = 329
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    TabOrder = 1
  end
end
