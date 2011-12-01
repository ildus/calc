{-----------------------------------------------------------------------------
 Unit Name: RbStyleEditor
 Purpose: Form Component Editor for RbStyleManager

 Author/Copyright: Nathanaël VERON - r.b.a.g@free.fr - http://r.b.a.g.free.fr


        Feel free to modify and improve source code, mail me (r.b.a.g@free.fr)
        if you make any big fix or improvement that can be included in the next
        versions. If you use the RbControls in your project please
        mention it or make a link to my website.

       ===============================================

       /*   14/10/2003    */
       Creation

-----------------------------------------------------------------------------}
unit RbStyleEditor;

interface

uses
  Windows, Messages, SysUtils,{$IFNDEF VER130} Variants,{$ENDIF} Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls,{$IFNDEF VER130} DateUtils,{$ENDIF} 
  RbProgressBar, RbDrawCore, RbPanel, ExtCtrls, RbSplitter, RbButton, 
  RbCheckBox, RbRadioButton, Menus, ImgList;

type                                     
  TFStyleEditor = class(TForm)
    SMgr: TRbStyleManager;
    RbPanel1: TRbPanel;
    RbPanel2: TRbPanel;
    RbRadioButton1: TRbRadioButton;
    RbRadioButton2: TRbRadioButton;
    RbCheckBox1: TRbCheckBox;
    RbPanel3: TRbPanel;
    RbButton1: TRbButton;
    RbSplitter1: TRbSplitter;
    RbCheckBox2: TRbCheckBox;
    DcColor: TColorDialog;
    RbPanel4: TRbPanel;
    EBorderColor: TShape;
    EOverFrom: TShape;
    EClickedTo: TShape;
    Label1: TLabel;
    EHotTrack: TShape;
    EDefaultFrom: TShape;
    EOverTo: TShape;
    ETextShadow: TShape;
    EDefaultTo: TShape;
    EClickedFrom: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EInnerColor: TShape;
    EPanelBorderColor: TShape;
    Label9: TLabel;
    Label10: TLabel;
    CHShowFocusRect: TCheckBox;
    CHHotTrack: TCheckBox;
    CHGradientBorder: TCheckBox;
    ESplitterOverFrom: TShape;
    Label11: TLabel;
    ESplitterDefaultFrom: TShape;
    ESplitterOverTo: TShape;
    ESplitterDefaultTo: TShape;
    Label12: TLabel;
    Label13: TLabel;
    CBFadeSpeed: TComboBox;
    MMenu: TMainMenu;
    File1: TMenuItem;
    N1: TMenuItem;
    CM_CloseApply: TMenuItem;
    CM_Open: TMenuItem;
    CM_Save: TMenuItem;
    N2: TMenuItem;
    DoFile: TOpenDialog;
    DsFile: TSaveDialog;
    ECheckColor: TShape;
    Label15: TLabel;
    CM_SaveAs: TMenuItem;
    CM_Quit: TMenuItem;
    RbButton2: TRbButton;
    Label17: TLabel;
    IMList: TImageList;
    DfFont: TFontDialog;
    BFont: TButton;
    CHTextShadow: TCheckBox;
    procedure CBFadeSpeedChange(Sender: TObject);
    procedure CHShowFocusRectClick(Sender: TObject);
    procedure CM_OpenClick(Sender: TObject);
    procedure CM_SaveClick(Sender: TObject);
    procedure CM_SaveAsClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure CM_QuitClick(Sender: TObject);
    procedure CM_CloseApplyClick(Sender: TObject);
    procedure EDefaultToDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure EDefaultToDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure EDefaultFromMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure BFontClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure UpdateStyle;
    procedure UpdateShapeHint;
  public
    Loading : boolean;  
    procedure UpdateComps;
  end;

var
  FStyleEditor: TFStyleEditor;

implementation

{$R *.dfm}


procedure TFStyleEditor.UpdateStyle;
begin
  if Loading then Exit;
  with Smgr do begin
    BorderColor := EPanelBorderColor.Brush.Color;
    CheckColor :=  ECheckColor.Brush.Color;

    Colors.BorderColor := EBorderColor.Brush.Color;
    Colors.ClickedFrom := EClickedFrom.Brush.Color;
    Colors.ClickedTo := EClickedTo.Brush.Color;
    Colors.DefaultFrom := EDefaultFrom.Brush.Color;
    Colors.DefaultTo := EDefaultTo.Brush.Color;
    Colors.HotTrack := EHotTrack.Brush.Color;
    Colors.OverFrom := EOverFrom.Brush.Color;
    Colors.OverTo := EOverTo.Brush.Color;
    Colors.TextShadow := ETextShadow.Brush.Color;

    FadeSpeed := TFadeSpeed(CBFadeSpeed.ItemIndex);

    Font.Assign(DfFont.Font);

    GradientBorder := CHGradientBorder.Checked;
    HotTrack := CHHotTrack.Checked;
    TextShadow := CHTextShadow.Checked;

    PanelColor := EInnerColor.Brush.Color;
    ShowFocusRect := CHShowFocusRect.Checked;

    SplitterColors.DefaultFrom := ESplitterDefaultFrom.Brush.Color;
    SplitterColors.DefaultTo := ESplitterDefaultTo.Brush.Color;
    SplitterColors.OverFrom := ESplitterOverFrom.Brush.Color;
    SplitterColors.OverTo := ESplitterOverTo.Brush.Color;
  end;
  SMgr.UpdateStyle;  
end;

procedure TFStyleEditor.CBFadeSpeedChange(Sender: TObject);
begin
  UpdateStyle;
end;

procedure TFStyleEditor.CHShowFocusRectClick(Sender: TObject);
begin
  UpdateStyle;
end;

procedure TFStyleEditor.CM_OpenClick(Sender: TObject);
begin
  //Open a style file
  if DoFile.Execute then begin
    Loading := true;
    try
      SMgr.LoadFromFile(DoFile.FileName);
      UpdateComps;
    finally
      Loading := false;
    end;
  end;
end;

procedure TFStyleEditor.CM_SaveClick(Sender: TObject);
begin
  if SMGr.FileName <> '' then
    SMGr.SaveToFile(SMGr.FileName)
  else
    CM_SaveAs.Click;  
end;

procedure TFStyleEditor.CM_SaveAsClick(Sender: TObject);
begin
  if DsFile.Execute then
    SMgr.SaveToFile(DsFile.FileName);
end;

procedure TFStyleEditor.N1Click(Sender: TObject);
begin
  MessageDlg('- RbControl Style Manager Editor-'+#13+#10+'      (c) Nathanaël VERON     '+#13+#10+#13+#10+'       http://r.b.a.g.free.fr/'+#13+#10+'           r.b.a.g@free.fr', mtInformation, [mbOK], 0);
end;

procedure TFStyleEditor.CM_QuitClick(Sender: TObject);
begin
  if MessageDlg('You will lose your changes, do you want to continue ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    ModalResult := mrCancel;
end;

procedure TFStyleEditor.CM_CloseApplyClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFStyleEditor.UpdateComps;
begin
  with Smgr do begin
    EPanelBorderColor.Brush.Color   := BorderColor;
    ECheckColor.Brush.Color         := CheckColor;
    EBorderColor.Brush.Color        := Colors.BorderColor;
    EClickedFrom.Brush.Color        := Colors.ClickedFrom;
    EClickedTo.Brush.Color          := Colors.ClickedTo;
    EDefaultFrom.Brush.Color        := Colors.DefaultFrom;
    EDefaultTo.Brush.Color          := Colors.DefaultTo;
    EHotTrack.Brush.Color           := Colors.HotTrack;
    EOverFrom.Brush.Color           := Colors.OverFrom;
    EOverTo.Brush.Color             := Colors.OverTo;
    ETextShadow.Brush.Color         := Colors.TextShadow;
    CBFadeSpeed.ItemIndex           := Integer(FadeSpeed);
    DfFont.Font.Assign(Font);
    CHGradientBorder.Checked        := GradientBorder;
    CHHotTrack.Checked              := HotTrack;
    CHTextShadow.Checked            := TextShadow;
    EInnerColor.Brush.Color         := PanelColor;
    CHShowFocusRect.Checked         := ShowFocusRect;
    ESplitterDefaultFrom.Brush.Color:= SplitterColors.DefaultFrom;
    ESplitterDefaultTo.Brush.Color  := SplitterColors.DefaultTo;
    ESplitterOverFrom.Brush.Color   := SplitterColors.OverFrom;
    ESplitterOverTo.Brush.Color     := SplitterColors.OverTo;
  end;
  SMgr.UpdateStyle;
end;

procedure TFStyleEditor.EDefaultToDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TShape) and (Source <> Sender);
end;

procedure TFStyleEditor.EDefaultToDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  TShape(Sender).Brush.Color := TShape(Source).Brush.Color;
  TShape(Sender).Hint := ColorToString(TShape(Sender).Brush.Color);  
  UpdateStyle;
end;

procedure TFStyleEditor.EDefaultFromMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ssShift in Shift) then
    TShape(Sender).BeginDrag(true)
  else begin
    if TShape(Sender).Dragging then Exit;
    DcColor.Color := (Sender as TShape).Brush.Color;
    DcColor.Options := [cdFullOpen, cdAnyColor];
    if DcColor.Execute then begin
      (Sender as TShape).Brush.Color := DcColor.Color;
      (Sender as TShape).Hint := ColorToString(DcColor.Color);
      UpdateStyle;
    end;
  end;
end;

procedure TFStyleEditor.FormCreate(Sender: TObject);
begin
  Loading := false;
  UpdateShapeHint;
end;

procedure TFStyleEditor.UpdateShapeHint;
var
  i : integer;
begin
  for i := 0 to ComponentCount - 1 do begin
    if Components[i] is TShape then
      (Components[i] as TShape).Hint := ColorToString((Components[i] as TShape).Brush.Color);
  end;
end;

procedure TFStyleEditor.BFontClick(Sender: TObject);
begin
  DfFont.Font.Assign(Smgr.Font);
  if DfFont.Execute then begin
    SMgr.Font.Assign(DfFont.Font);
    UpdateStyle;
  end;
end;

procedure TFStyleEditor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then CM_Quit.Click;
end;

end.
