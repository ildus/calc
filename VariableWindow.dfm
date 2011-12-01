object VariableW: TVariableW
  Left = 480
  Top = 294
  BorderStyle = bsToolWindow
  Caption = #1055#1077#1088#1077#1084#1077#1085#1085#1099#1077
  ClientHeight = 196
  ClientWidth = 134
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 134
    Height = 196
    Align = alClient
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    Lines.Strings = (
      'x=0'
      'y=0')
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    OnKeyPress = Memo1KeyPress
  end
end
