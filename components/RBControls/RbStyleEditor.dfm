object FStyleEditor: TFStyleEditor
  Left = 443
  Top = 177
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'RbControls Style Manager'
  ClientHeight = 297
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object RbPanel1: TRbPanel
    Left = 328
    Top = 8
    Width = 169
    Height = 285
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13500416
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    TextShadow = True
    ShowCaption = True
    CaptionPosition = cpTopLeft
    CornerWidth = 0
    BorderWidth = 1
    BorderColor = clGray
    OuterColor = clBtnFace
    TextShadowColor = clWhite
    Antialiased = False
    Gradient = False
    DefaultFrom = clWhite
    DefaultTo = 14933983
    GradientType = gtVertical
    object RbSplitter1: TRbSplitter
      Left = 2
      Top = 147
      Width = 165
      Height = 5
      Cursor = crVSplit
      Align = alTop
      MinSize = 50
      ResizeStyle = rsUpdate
      GradientType = gtVertical
      GripAlign = gaHorizontal
      FadeSpeed = fsMedium
      Colors.DefaultFrom = clBtnFace
      Colors.DefaultTo = clBtnFace
      Colors.OverFrom = clWhite
      Colors.OverTo = 12489846
      ShowGrip = True
      RbStyleManager = SMgr
      DrawAll = True
    end
    object RbPanel2: TRbPanel
      Left = 2
      Top = 2
      Width = 165
      Height = 145
      Align = alTop
      Color = 14933983
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      TextShadow = True
      ShowCaption = True
      RbStyleManager = SMgr
      Caption = 'Test panel'
      CaptionPosition = cpTopCenter
      CornerWidth = 10
      BorderWidth = 1
      BorderColor = clGray
      OuterColor = clBtnFace
      TextShadowColor = clWhite
      Antialiased = True
      Gradient = False
      DefaultFrom = clWhite
      DefaultTo = 14933983
      GradientType = gtVertical
      object RbRadioButton1: TRbRadioButton
        Left = 8
        Top = 32
        Width = 130
        Height = 17
        TabOrder = 0
        TextShadow = True
        ShowCaption = True
        RbStyleManager = SMgr
        Caption = 'Choice 1'
        BorderLinesColor = clGray
        HotTrack = False
        FadeSpeed = fsMedium
        Colors.DefaultFrom = clWhite
        Colors.DefaultTo = 13745839
        Colors.OverFrom = clWhite
        Colors.OverTo = 12489846
        Colors.ClickedFrom = 13029334
        Colors.ClickedTo = 15463415
        Colors.HotTrack = clBlue
        Colors.BorderColor = clGray
        Colors.TextShadow = clWhite
        Spacing = 3
        Checked = True
        ShowFocusRect = True
        CheckColor = clGreen
        RadioType = rsMedium
      end
      object RbRadioButton2: TRbRadioButton
        Left = 8
        Top = 50
        Width = 130
        Height = 15
        TabOrder = 1
        TextShadow = True
        ShowCaption = True
        RbStyleManager = SMgr
        Caption = 'Choice 2'
        BorderLinesColor = clGray
        HotTrack = False
        FadeSpeed = fsMedium
        Colors.DefaultFrom = clWhite
        Colors.DefaultTo = 13745839
        Colors.OverFrom = clWhite
        Colors.OverTo = 12489846
        Colors.ClickedFrom = 13029334
        Colors.ClickedTo = 15463415
        Colors.HotTrack = clBlue
        Colors.BorderColor = clGray
        Colors.TextShadow = clWhite
        Spacing = 3
        Checked = False
        ShowFocusRect = True
        CheckColor = clGreen
        RadioType = rsMedium
      end
      object RbCheckBox1: TRbCheckBox
        Left = 8
        Top = 80
        Width = 130
        Height = 17
        TabOrder = 2
        TextShadow = True
        ShowCaption = True
        RbStyleManager = SMgr
        Caption = 'Check 1'
        BorderLinesColor = clGray
        HotTrack = False
        FadeSpeed = fsMedium
        Colors.DefaultFrom = clWhite
        Colors.DefaultTo = 13745839
        Colors.OverFrom = clWhite
        Colors.OverTo = 12489846
        Colors.ClickedFrom = 13029334
        Colors.ClickedTo = 15463415
        Colors.HotTrack = clBlue
        Colors.BorderColor = clGray
        Colors.TextShadow = clWhite
        Spacing = 3
        Checked = True
        ShowFocusRect = True
        CheckColor = clGreen
        GradientBorder = True
      end
      object RbCheckBox2: TRbCheckBox
        Left = 8
        Top = 98
        Width = 130
        Height = 17
        TabOrder = 3
        TextShadow = True
        ShowCaption = True
        RbStyleManager = SMgr
        Caption = 'Check 2'
        BorderLinesColor = clGray
        HotTrack = False
        FadeSpeed = fsMedium
        Colors.DefaultFrom = clWhite
        Colors.DefaultTo = 13745839
        Colors.OverFrom = clWhite
        Colors.OverTo = 12489846
        Colors.ClickedFrom = 13029334
        Colors.ClickedTo = 15463415
        Colors.HotTrack = clBlue
        Colors.BorderColor = clGray
        Colors.TextShadow = clWhite
        Spacing = 3
        Checked = False
        ShowFocusRect = True
        CheckColor = clGreen
        GradientBorder = True
      end
    end
    object RbPanel3: TRbPanel
      Left = 2
      Top = 152
      Width = 165
      Height = 131
      Align = alClient
      Color = 14933983
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 1
      TextShadow = True
      ShowCaption = True
      RbStyleManager = SMgr
      CaptionPosition = cpTopCenter
      CornerWidth = 10
      BorderWidth = 1
      BorderColor = clGray
      OuterColor = clBtnFace
      TextShadowColor = clWhite
      Antialiased = True
      Gradient = False
      DefaultFrom = clWhite
      DefaultTo = 14933983
      GradientType = gtVertical
      object RbButton1: TRbButton
        Left = 43
        Top = 16
        Width = 75
        Height = 25
        TabOrder = 0
        TextShadow = True
        ShowCaption = True
        RbStyleManager = SMgr
        Caption = 'Button'
        ModalResult = 0
        Spacing = 2
        Layout = blGlyphLeft
        Colors.DefaultFrom = clWhite
        Colors.DefaultTo = 13745839
        Colors.OverFrom = clWhite
        Colors.OverTo = 12489846
        Colors.ClickedFrom = 13029334
        Colors.ClickedTo = 15463415
        Colors.HotTrack = clBlue
        Colors.BorderColor = clGray
        Colors.TextShadow = clWhite
        FadeSpeed = fsMedium
        ShowFocusRect = True
        HotTrack = False
        GradientBorder = True
        GroupIndex = 0
        AllowAllUp = False
        Down = False
      end
      object RbButton2: TRbButton
        Left = 43
        Top = 48
        Width = 70
        Height = 21
        TabOrder = 1
        TextShadow = True
        ShowCaption = True
        RbStyleManager = SMgr
        Caption = 'Button'
        ModalResult = 0
        Spacing = 2
        Layout = blGlyphLeft
        Colors.DefaultFrom = clWhite
        Colors.DefaultTo = 13745839
        Colors.OverFrom = clWhite
        Colors.OverTo = 12489846
        Colors.ClickedFrom = 13029334
        Colors.ClickedTo = 15463415
        Colors.HotTrack = clBlue
        Colors.BorderColor = clGray
        Colors.TextShadow = clWhite
        FadeSpeed = fsMedium
        ShowFocusRect = True
        HotTrack = False
        GradientBorder = True
        GroupIndex = 0
        AllowAllUp = False
        Down = False
      end
    end
  end
  object RbPanel4: TRbPanel
    Left = 8
    Top = 8
    Width = 313
    Height = 285
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    TextShadow = True
    ShowCaption = True
    Caption = ' Style Colors '
    CaptionPosition = cpGroupBox
    CornerWidth = 15
    BorderWidth = 1
    BorderColor = clGray
    OuterColor = clBtnFace
    TextShadowColor = clWhite
    Antialiased = True
    Gradient = False
    DefaultFrom = clWhite
    DefaultTo = 14933983
    GradientType = gtVertical
    object EBorderColor: TShape
      Left = 256
      Top = 96
      Width = 17
      Height = 17
      Brush.Color = clGray
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object EOverFrom: TShape
      Left = 96
      Top = 72
      Width = 21
      Height = 17
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object EClickedTo: TShape
      Left = 112
      Top = 96
      Width = 17
      Height = 17
      Brush.Color = 15463415
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object Label1: TLabel
      Left = 12
      Top = 24
      Width = 104
      Height = 13
      Caption = 'Buttons properties'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object EHotTrack: TShape
      Left = 256
      Top = 48
      Width = 17
      Height = 17
      Brush.Color = clBlue
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object EDefaultFrom: TShape
      Left = 96
      Top = 48
      Width = 17
      Height = 17
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object EOverTo: TShape
      Left = 112
      Top = 72
      Width = 17
      Height = 17
      Brush.Color = 12489846
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object ETextShadow: TShape
      Left = 256
      Top = 72
      Width = 17
      Height = 17
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object EDefaultTo: TShape
      Left = 112
      Top = 48
      Width = 17
      Height = 17
      Brush.Color = 13745839
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object EClickedFrom: TShape
      Left = 96
      Top = 96
      Width = 17
      Height = 17
      Brush.Color = 13029334
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object Label2: TLabel
      Left = 24
      Top = 48
      Width = 66
      Height = 13
      Alignment = taRightJustify
      Caption = 'Default Colors'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 34
      Top = 72
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = 'Over Colors'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 26
      Top = 96
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'ClickedColors'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 205
      Top = 48
      Width = 45
      Height = 13
      Alignment = taRightJustify
      Caption = 'HotTrack'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 189
      Top = 72
      Width = 61
      Height = 13
      Alignment = taRightJustify
      Caption = 'Text shadow'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 192
      Top = 96
      Width = 58
      Height = 13
      Alignment = taRightJustify
      Caption = 'Border Color'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 12
      Top = 216
      Width = 93
      Height = 13
      Caption = 'Panel properties'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object EInnerColor: TShape
      Left = 96
      Top = 240
      Width = 17
      Height = 17
      Brush.Color = 14933983
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object EPanelBorderColor: TShape
      Left = 96
      Top = 264
      Width = 17
      Height = 17
      Brush.Color = clGray
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object Label9: TLabel
      Left = 66
      Top = 242
      Width = 24
      Height = 13
      Alignment = taRightJustify
      Caption = 'Color'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 32
      Top = 266
      Width = 58
      Height = 13
      Alignment = taRightJustify
      Caption = 'Border Color'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ESplitterOverFrom: TShape
      Left = 248
      Top = 264
      Width = 17
      Height = 17
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object Label11: TLabel
      Left = 164
      Top = 216
      Width = 101
      Height = 13
      Caption = 'Splitter properties'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object ESplitterDefaultFrom: TShape
      Left = 248
      Top = 240
      Width = 17
      Height = 17
      Brush.Color = clBtnFace
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object ESplitterOverTo: TShape
      Left = 264
      Top = 264
      Width = 17
      Height = 17
      Brush.Color = 12489846
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object ESplitterDefaultTo: TShape
      Left = 264
      Top = 240
      Width = 17
      Height = 17
      Brush.Color = clBtnFace
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object Label12: TLabel
      Left = 176
      Top = 240
      Width = 66
      Height = 13
      Alignment = taRightJustify
      Caption = 'Default Colors'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 186
      Top = 264
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = 'Over Colors'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ECheckColor: TShape
      Left = 256
      Top = 120
      Width = 17
      Height = 17
      Brush.Color = clGreen
      ParentShowHint = False
      ShowHint = True
      OnDragDrop = EDefaultToDragDrop
      OnDragOver = EDefaultToDragOver
      OnMouseDown = EDefaultFromMouseDown
    end
    object Label15: TLabel
      Left = 192
      Top = 120
      Width = 58
      Height = 13
      Alignment = taRightJustify
      Caption = 'Check Color'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 170
      Top = 144
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Fade speed'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 204
      Top = 8
      Width = 100
      Height = 11
      Caption = 'Shift to drag/copy colors'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object CHShowFocusRect: TCheckBox
      Left = 24
      Top = 126
      Width = 113
      Height = 17
      Caption = 'Show focus rect'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      OnClick = CHShowFocusRectClick
    end
    object CHHotTrack: TCheckBox
      Left = 24
      Top = 168
      Width = 69
      Height = 17
      Caption = 'Hot track'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = CHShowFocusRectClick
    end
    object CHGradientBorder: TCheckBox
      Left = 24
      Top = 147
      Width = 97
      Height = 17
      Caption = 'Gradient border'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
      OnClick = CHShowFocusRectClick
    end
    object CBFadeSpeed: TComboBox
      Left = 168
      Top = 160
      Width = 105
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 3
      OnChange = CBFadeSpeedChange
      Items.Strings = (
        'fsSlow'
        'fsMedium'
        'fsFast'
        'fsVeryFast')
    end
    object BFont: TButton
      Left = 168
      Top = 192
      Width = 75
      Height = 17
      Caption = 'Font'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BFontClick
    end
    object CHTextShadow: TCheckBox
      Left = 24
      Top = 190
      Width = 97
      Height = 17
      Caption = 'Text Shadow'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = CHShowFocusRectClick
    end
  end
  object SMgr: TRbStyleManager
    Colors.DefaultFrom = clWhite
    Colors.DefaultTo = 13745839
    Colors.OverFrom = clWhite
    Colors.OverTo = 12489846
    Colors.ClickedFrom = 13029334
    Colors.ClickedTo = 15463415
    Colors.HotTrack = clBlue
    Colors.BorderColor = clGray
    Colors.TextShadow = clWhite
    ShowFocusRect = True
    HotTrack = False
    GradientBorder = True
    TextShadow = True
    CheckColor = clGreen
    FadeSpeed = fsMedium
    PanelColor = 14933983
    BorderColor = clGray
    SplitterColors.DefaultFrom = clBtnFace
    SplitterColors.DefaultTo = clBtnFace
    SplitterColors.OverFrom = clWhite
    SplitterColors.OverTo = 12489846
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 168
    Top = 48
  end
  object DcColor: TColorDialog
    Ctl3D = True
    Left = 140
    Top = 104
  end
  object MMenu: TMainMenu
    Images = IMList
    Left = 168
    Top = 76
    object File1: TMenuItem
      Caption = 'File'
      object CM_Open: TMenuItem
        Caption = 'Open...'
        ImageIndex = 0
        ShortCut = 16463
        OnClick = CM_OpenClick
      end
      object CM_Save: TMenuItem
        Caption = 'Save'
        ImageIndex = 1
        ShortCut = 16467
        OnClick = CM_SaveClick
      end
      object CM_SaveAs: TMenuItem
        Caption = 'Save as...'
        ShortCut = 49235
        OnClick = CM_SaveAsClick
      end
      object N2: TMenuItem
        AutoHotkeys = maAutomatic
        AutoLineReduction = maAutomatic
        Caption = '-'
      end
      object CM_CloseApply: TMenuItem
        Caption = 'Close and apply'
        ImageIndex = 3
        ShortCut = 16449
        OnClick = CM_CloseApplyClick
      end
      object CM_Quit: TMenuItem
        Caption = 'Quit'
        ImageIndex = 2
        ShortCut = 16465
        OnClick = CM_QuitClick
      end
    end
    object N1: TMenuItem
      Caption = '?'
      OnClick = N1Click
    end
  end
  object DoFile: TOpenDialog
    DefaultExt = 'rbs'
    Filter = 'RbControl Style (.rbs)|*.rbs'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Open a style'
    Left = 168
    Top = 104
  end
  object DsFile: TSaveDialog
    DefaultExt = 'rbs'
    Filter = 'RbControl Style (.rbs)|*.rbs'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 140
    Top = 76
  end
  object IMList: TImageList
    Left = 140
    Top = 48
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AD5A5900AA54
      5400A24D4E00AA959500C1C8C700CCCBCA00CECBCA00CAC8C700C6CAC900B79E
      9E009840410099444400A6515100000000000000000000000000B7818300B781
      8300B7818300B7818300B7818300B7818300B7818300B7818300B7818300B781
      8300B7818300B7818300B7818300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001696CB001F9FD1001293
      CB00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BC787100CF666600D268
      6800B95A5B009B808000BEA1A000E2D0CE00FEF9F500FFFDFA00F2F6F400D2B3
      B300962D2C0099323200C25B5B00B05859000000000000000000B7818300FEEE
      D400F7E3C500F6DFBC00F5DBB400F3D7AB00F3D3A200F1CF9A00F0CF9700F0CF
      9800F0CF9800F5D49A00B78183000000000000000000CC670100CC670100CC67
      0100CC670100CC670100CC670100CC670100CC670100CC670100CC670100CC67
      0100CC670100CC670100CC670100CC670100000000001696CB009AF3FB006CEA
      F80030B1DC0030B1DC0030B1DC001FA0D3001395CB0000000000000000000000
      00000000000000000000000000000000000000000000BB787100CB656500CE67
      6700B85D5D009E7B7C009D434300B7767500E7DFDD00FDFBF900FEFFFD00D9BA
      B900962E2E0099333300C05A5A00AF5859000000000000000000B7818300FDEF
      D900F6E3CB00F5DFC200F4DBBA00F2D7B200F1D4A900F1D0A200EECC9900EECC
      9700EECC9700F3D19900B78183000000000000000000CC670100FFFFFF00FFFF
      FF00FFFAF500FFF3E600FEEBD500FEE3C300FEDCB500FED7AB00FED7AB00FED7
      AB00FED7AB00FED7AB00FED7AB00CC670100000000001696CB0090E2F20087FF
      FF007FFBFF0081FAFF007DF4FF0074EEFE0069E3F80030B1DC0030B1DC0023A5
      D5000000000000000000000000000000000000000000BB787100CB656500CE66
      6700B85D5D00A8848300993939009B363600CDBCBB00F2F0EE00FFFFFF00E2C3
      C100962D2D0098333300C05A5A00AF5859000000000000000000B4817600FEF3
      E300F8E7D300F5E3CB00F5DFC300F3DBBB00F2D7B200F1D4AB00F0D0A300EECC
      9A00EECC9700F3D19900B78183000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFAF500FFF3E600FEEBD500FEE3C400FEDCB500FED7AB00FED7
      AB00FED7AB00FED7AB00FED7AB00CC670100000000001696CB0072CBE60096FE
      FF0077F6FF0078F3FF0077F2FF0076F2FF0076F0FF0077F0FF007DF3FF005AD3
      F200199AD00000000000000000000000000000000000BB787100CB656500CE66
      6600B75C5C00B28F8E009F48480094323200A69A9A00D5DBD800FAFFFE00E6C9
      C800932B2B0096303000BF595900AF5859000000000000000000B4817600FFF7
      EB00F9EBDA00F7E7D200BAB8D600F5DFC200F4DBB900B7AFC400F1D4AA00F0D0
      A100EFCD9900F3D19800B78183000000000000000000CC670100FFFFFF004571
      FA004571FA004571FA00FFFBF500A23F0800A23F0800A23F0800FEDBB500059A
      CD00059ACD00059ACD00FED7AB00CC670100000000001696CB001696CB0095EB
      F80078F8FF0078F3FF0077F2FF0075F0FF0074EEFE0072EDFE0073EDFF005CD5
      F3003CBBE30000000000000000000000000000000000BB787100CB656500CF66
      6600BB5C5C00C3908F00C2969500B3868600AA8D8E00BAA2A100E1CAC800DCA9
      A900A33A3A00A43E3E00C35D5D00AE5758000000000000000000BA8E8500FFFC
      F400FAEFE400F8EADA000D3CF900AAACDA00AAAAD4000C3CF800F1D7B200F1D3
      AA00F0D0A100F3D29B00B78183000000000000000000CC670100FFFFFF004571
      FA004571FA004571FA00FFFFFF00A23F0800A23F0800A23F0800FEE3C400059A
      CD00059ACD00059ACD00FED7AB00CC670100000000001696CB0060DDF0001696
      CB0087FEFF0074F4FF0075F3FF0073F0FF0074EEFE0072EDFE0073EDFF0057D3
      F2005ED8F300189CCF00000000000000000000000000BB787100CC656600CB64
      6400CB646400CB636400CC676700CD676700CC646400C85B5B00C95E5E00CA61
      6100CC656500CD666600CF686800AC5657000000000000000000BA8E8500FFFF
      FD00FBF4EC00FAEFE300788BEB000E3DF9000D3DF9007686E000F4DBBA00F2D7
      B100F0D4A900F5D5A300B78183000000000000000000CC670100FFFFFF004571
      FA004571FA004571FA00FFFFFF00A23F0800A23F0800A23F0800FFEBD500059A
      CD00059ACD00059ACD00FED7AB00CC670100000000001696CB007AF7FC001696
      CB0092E2F20092EBF8008EEDFA008AF4FF0073EFFF0070EDFE0073EDFF0055CF
      EF00015904003EBFE300000000000000000000000000BC797200B7535100B25B
      5700C6868400D2A4A200D5ABAA00D5AAA900D5ABAA00D5A5A400D5A8A700D5AA
      A900D6AEAC00D39C9C00CD666600AC5556000000000000000000CB9A8200FFFF
      FF00FEF9F500FBF3EC00ABB3EA000335FB000335FB00A7ABDA00F5DEC200F4DB
      BA00F2D8B200F6D9AC00B78183000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFAF500FEF3E700FEEB
      D500FFE3C300FEDCB500FED7AB00CC670100000000001696CB0086FEFF006CEE
      FA001696CB001696CB001696CB001696CB009AEEFA0077F0FF006EEEFF000159
      040041E07300015904000F92CA000000000000000000BC787100B14F4C00E4CD
      CB00FAF7F700F8F4F300F9F5F400F9F5F400F9F5F400F9F6F500F9F5F400F9F5
      F400FBFBFA00DEBEBD00C45C5D00AD5657000000000000000000CB9A8200FFFF
      FF00FFFEFD00FDF8F4000D3CFA00798EF000788CEB000D3CF900F6E2CA00F6DE
      C100F4DBB900F8DDB400B78183000000000000000000CC670100FFFFFF00CC9A
      9900CC9A9900CC9A9900FFFFFF00E27E0300E27E0300E27E0300FFFAF400029A
      0300029A0300029A0300FEDCB500CC670100000000001696CB0082FBFF007EFA
      FF007DFAFF007DF8FF0077F4FF0051D4EF001696CB0088DAF0000159040036CB
      5F002DC551001CB03500015904000000000000000000BC787100B3514E00EBD7
      D600FCFBFA00F7F0EF00F7F1F000F7F1F000F7F1F000F7F1F000F7F1F000F6F1
      F000FBF9F800DEBCBB00C35B5B00AD5657000000000000000000DCA88700FFFF
      FF00FFFFFF00FFFEFD007D94F800FBF3EB00FAEFE2007B8EEA00F8E6D100F6E2
      C800F7E1C200F0DAB700B78183000000000000000000CC670100FFFFFF00CC9A
      9900CC9A9900CC9A9900FFFFFF00E27E0300E27E0300E27E0300FFFFFF00029A
      0300029A0300029A0300FEE3C400CC670100000000001696CB0083FCFF007BF8
      FF0079F6FF0078F3FF0079F4FF007AF7FF006AEAFC001696CB001696CB000A73
      12001CB033000A8013001F9ACF000000000000000000BC787100B3514E00EBD7
      D400F0EFEF00D8D5D400DAD7D700DAD7D700DAD7D700DAD7D700DAD7D700D8D5
      D500ECECEB00E0BDBC00C25B5B00AD5657000000000000000000DCA88700FFFF
      FF00FFFFFF00FFFFFF00FFFEFD00FDF9F400FBF3EB00FAEEE200FAEDDC00FCEF
      D900E6D9C400C6BCA900B78183000000000000000000CC670100FFFFFF00CC9A
      9900CC9A9900CC9A9900FFFFFF00E27E0300E27E0300E27E0300FFFFFF00029A
      0300029A0300029A0300FFEBD500CC670100000000001696CB008EFFFF007BFB
      FF0079F7FF007AF6FF0076E7F80077E6F8007DE9FB007EEDFC0082F0FF000467
      0A000C9A180003690600000000000000000000000000BC787100B3514E00EBD7
      D500F3F1F100DEDAD900DFDBDB00DFDBDB00DFDBDB00DFDBDB00DFDBDB00DDDA
      D900EEEEEE00E0BDBC00C35B5B00AD5657000000000000000000E3B18E00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFEFD00FDF8F300FDF6EC00F1E1D500B885
      7A00B8857A00B8857A00B78183000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFAF500FFF3E600CC670100000000001392CA001696CB0087F2
      FA0088F4FC006CE3F6001899CE001392CA001696CB001797CC001D9CCF000477
      0A0005890C0000000000000000000000000000000000BC787100B3514E00EAD7
      D500F5F4F300E4DFDE00E5E1E000E5E1E000E5E1E000E5E1E000E5E1E000E4DF
      DF00F2F1F000DFBDBB00C35B5B00AD5657000000000000000000E3B18E00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFEFC00FFFEF900E3CFC900B885
      7A00E8B27000ECA54A00C58768000000000000000000CC670100CC670100CC67
      0100CC670100CC670100CC670100CC670100CC670100CC670100CC670100CC67
      0100CC670100CC670100CC670100CC6701000000000000000000000000001696
      CB001C99CE001898CC0000000000000000000000000000000000036F0700058A
      0C000367060000000000000000000000000000000000BC787100B3514E00EBD7
      D600F1F0EF00D9D5D500DAD8D700DAD8D700DAD8D700DAD8D700DAD8D700D8D5
      D500EDECEB00E1BEBD00C35B5B00AD5657000000000000000000EDBD9200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4D4D200B885
      7A00FAC57700CD93770000000000000000000000000000000000CC670100CC67
      0100CC670100CC670100CC670100CC670100CC670100CC670100CC670100CC67
      0100CC670100CC670100CC670100000000000000000000000000000000000000
      000000000000000000000000000001560300035E0600046F0A0003730800025F
      05000000000000000000000000000000000000000000BC787000B3514E00E9D6
      D400FEFBFB00FAF3F200FAF3F200FAF3F200FAF3F200FAF3F200FAF3F200FAF3
      F200FDFAF900DEBCBB00C35C5C00AD5657000000000000000000EDBD9200FCF7
      F400FCF7F300FBF6F300FBF6F300FAF5F300F9F5F300F9F5F300E1D0CE00B885
      7A00CF9B86000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A8504C00C9B6
      B500D3D5D400D1CECE00D1CECE00D1CECE00D1CECE00D1CECE00D1CECE00D1CE
      CE00D3D4D400CBAEAD00A34D4E00000000000000000000000000EDBD9200DCA8
      8700DCA88700DCA88700DCA88700DCA88700DCA88700DCA88700DCA88700B885
      7A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFC001C001FFFF8FFF8000C0018000
      807F8000C0018000800F8000C001800080078000C001800080078000C0018000
      80038000C001800080038000C001800080018000C001800080018000C0018000
      80018000C001800080038000C001800080078000C0018000E3C78000C003C001
      FE0F8000C007FFFFFFFFC001C00FFFFF00000000000000000000000000000000
      000000000000}
  end
  object DfFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 140
    Top = 132
  end
end
