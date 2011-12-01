unit TB2Reg;

{
  Toolbar2000
  Copyright (C) 1998-2005 by Jordan Russell
  All rights reserved.

  The contents of this file are subject to the "Toolbar2000 License"; you may
  not use or distribute this file except in compliance with the
  "Toolbar2000 License". A copy of the "Toolbar2000 License" may be found in
  TB2k-LICENSE.txt or at:
    http://www.jrsoftware.org/files/tb2k/TB2k-LICENSE.txt

  Alternatively, the contents of this file may be used under the terms of the
  GNU General Public License (the "GPL"), in which case the provisions of the
  GPL are applicable instead of those in the "Toolbar2000 License". A copy of
  the GPL may be found in GPL-LICENSE.txt or at:
    http://www.jrsoftware.org/files/tb2k/GPL-LICENSE.txt
  If you wish to allow use of your version of this file only under the terms of
  the GPL and not to allow others to use your version of this file under the
  "Toolbar2000 License", indicate your decision by deleting the provisions
  above and replace them with the notice and other provisions required by the
  GPL. If you do not delete the provisions above, a recipient may use your
  version of this file under either the "Toolbar2000 License" or the GPL.

  $jrsoftware: tb2k/Source/TB2Reg.pas,v 1.28 2005/01/06 03:56:50 jr Exp $
}

interface

{$I TB2Ver.inc}

uses
  Windows, SysUtils, Classes, Graphics, Controls, Dialogs, ActnList, ImgList,
  {$IFDEF JR_D6} DesignIntf, DesignEditors, VCLEditors, TypInfo, {$ELSE} DsgnIntf, {$ENDIF}
  TB2Common, TB2Toolbar, TB2ToolWindow, TB2Dock, TB2Item, TB2ExtItems, TB2MRU, TB2MDI,
  TB2DsgnItemEditor;

{$IFDEF JR_D5}

{ TTBImageIndexPropertyEditor }

{ Unfortunately TComponentImageIndexPropertyEditor seems to be gone in
  Delphi 6, so we have to use our own image index property editor class } 

type
  TTBImageIndexPropertyEditor = class(TIntegerProperty
    {$IFDEF JR_D6} , ICustomPropertyListDrawing {$ENDIF})
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetImageListAt(Index: Integer): TCustomImageList; virtual;

    // ICustomPropertyListDrawing
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer); {$IFNDEF JR_D6} override; {$ENDIF}
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer); {$IFNDEF JR_D6} override; {$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFNDEF JR_D6} override; {$ENDIF}
  end;

{ TTBItemImageIndexPropertyEditor }

type
  TTBItemImageIndexPropertyEditor = class(TTBImageIndexPropertyEditor)
  public
    function GetImageListAt (Index: Integer): TCustomImageList; override;
  end;

{$ENDIF}

{$IFNDEF JR_D9}
  TACPWideStringProperty = class(TPropertyEditor, ICustomPropertyDrawing)
  private
    FPropList: PInstPropList;
    FSaveValue: WideString;
  protected
    function  GetWideStrValue: WideString;
    function  GetWideStrValueAt(Index: Integer): WideString;
    function  GetWideDisplayValue: WideString;
    procedure SetPropEntry(Index: Integer; AInstance: TPersistent; APropInfo: PPropInfo); override;
    procedure SetWideStrValue(const Value: WideString);
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    destructor Destroy; override;
    function AllEqual: Boolean; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    { ICustomPropertyDrawing methods }
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  TACPWideCaptionProperty = class(TACPWideStringProperty)
    function GetAttributes: TPropertyAttributes; override;
  end;
{$ENDIF}

procedure CanvasTextRectW(Canvas: TCanvas; Rect: TRect; X, Y: Integer; const Text: WideString);

procedure Register;

implementation

uses
  ImgEdit;

{$IFDEF JR_D5}

function TTBImageIndexPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paRevertable];
end;

function TTBImageIndexPropertyEditor.GetImageListAt(Index: Integer): TCustomImageList;
begin
  Result := nil;
end;

procedure TTBImageIndexPropertyEditor.GetValues(Proc: TGetStrProc);
var
  ImgList: TCustomImageList;
  I: Integer;
begin
  ImgList := GetImageListAt(0);
  if Assigned(ImgList) then
    for I := 0 to ImgList.Count-1 do
      Proc(IntToStr(I));
end;

procedure TTBImageIndexPropertyEditor.ListDrawValue(const Value: string;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  ImgList: TCustomImageList;
  X: Integer;
begin
  ImgList := GetImageListAt(0);
  ACanvas.FillRect(ARect);
  X := ARect.Left + 2;
  if Assigned(ImgList) then begin
    ImgList.Draw(ACanvas, X, ARect.Top + 2, StrToInt(Value));
    Inc(X, ImgList.Width);
  end;
  ACanvas.TextOut(X + 3, ARect.Top + 1, Value);
end;

procedure TTBImageIndexPropertyEditor.ListMeasureHeight(const Value: string;
  ACanvas: TCanvas; var AHeight: Integer);
var
  ImgList: TCustomImageList;
begin
  ImgList := GetImageListAt(0);
  AHeight := ACanvas.TextHeight(Value) + 2;
  if Assigned(ImgList) and (ImgList.Height + 4 > AHeight) then
    AHeight := ImgList.Height + 4;
end;

procedure TTBImageIndexPropertyEditor.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
var
  ImgList: TCustomImageList;
begin
  ImgList := GetImageListAt(0);
  AWidth := ACanvas.TextWidth(Value) + 4;
  if Assigned(ImgList) then
    Inc(AWidth, ImgList.Width);
end;

{ TTBItemImageIndexPropertyEditor }

function TTBItemImageIndexPropertyEditor.GetImageListAt(Index: Integer): TCustomImageList;
var
  C: TPersistent;
  Item: TTBCustomItem;
begin
  Result := nil;
  { ? I'm guessing that the Index parameter is a component index (one that
    would be passed to the GetComponent function). }
  C := GetComponent(Index);
  if C is TTBCustomItem then begin
    Item := TTBCustomItem(C);
    repeat
      Result := Item.Images;
      if Assigned(Result) then
        Break;
      Item := Item.Parent;
      if Item = nil then
        Break;
      Result := Item.SubMenuImages;
    until Assigned(Result);
  end;
end;

{$ENDIF}

{ TTBCustomImageListEditor }

type
  TTBCustomImageListEditor = class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): String; override;
    function GetVerbCount: Integer; override;
  end;

  TTBCustomImageListAccess = class(TTBCustomImageList);

procedure TTBCustomImageListEditor.Edit;
var
  ImgList: TTBCustomImageList;
begin
  ImgList := Component as TTBCustomImageList;
  if not TTBCustomImageListAccess(ImgList).ImagesBitmap.Empty then begin
    if MessageDlg('The image list''s ImagesBitmap property has ' +
       'a bitmap assigned. Because of this, any changes you make in the ' +
       'Image List Editor will not be preserved when the form is saved.'#13#10#13#10 +
       'Do you want to open the editor anyway?', mtWarning,
       [mbYes, mbNo], 0) <> mrYes then
      Exit;
  end;
  EditImageList(ImgList);
end;

procedure TTBCustomImageListEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    Edit;
end;

function TTBCustomImageListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TTBCustomImageListEditor.GetVerb(Index: Integer): String;
begin
  if Index = 0 then
    Result := 'ImageList Editor...'
  else
    Result := '';
end;

type
  TCanvasAccess = class(TCanvas);

procedure CanvasTextRectW(Canvas: TCanvas; Rect: TRect; X, Y: Integer; const Text: WideString);
var
  Options: Longint;
  DC: HDC;
  OldFont: HFONT;
begin
  with TCanvasAccess(Canvas) do
  begin
    Changing;
    RequiredState([csHandleValid, csFontValid, csBrushValid]);
    Options := ETO_CLIPPED or TextFlags;
    if Brush.Style <> bsClear then Options := Options or ETO_OPAQUE;

    DC := Handle;
    OldFont := Windows.SelectObject(DC, GetStockObject(DEFAULT_GUI_FONT));
    if ((TextFlags and ETO_RTLREADING) <> 0) and (CanvasOrientation = coRightToLeft) then
      Inc(X, GetTextWidthW(DC, Text, False) + 1);
    Windows.ExtTextOutW(DC, X, Y, Options, @Rect, PWideChar(Text), Length(Text), nil);
    Windows.SelectObject(DC, OldFont);
    Changed;
  end;
end;

{$IFNDEF JR_D9}

{ TACPWideStringProperty }

function TACPWideStringProperty.AllEqual: Boolean;
var
  I: Integer;
  V: WideString;
begin
  Result := False;
  if PropCount > 1 then
  begin
    V := GetWideStrValue;
    for I := 1 to PropCount - 1 do if GetWideStrValueAt(I) <> V then Exit;
  end;
  Result := True;
end;

constructor TACPWideStringProperty.Create(const ADesigner: IDesigner; APropCount: Integer);
begin
  inherited Create(ADesigner, APropCount);
  GetMem(FPropList, APropCount * SizeOf(TInstProp));
end;

destructor TACPWideStringProperty.Destroy;
begin
  if Assigned(FPropList) then FreeMem(FPropList);
  inherited;
end;

function TACPWideStringProperty.GetEditLimit: Integer;
begin
  Result := MaxInt;
end;

function TACPWideStringProperty.GetValue: string;
begin
  FSaveValue := GetWideStrValue;
  Result := ACPScrambleWideString(FSaveValue);
end;

function TACPWideStringProperty.GetWideDisplayValue: WideString;
begin
  if AllEqual then Result := GetWideStrValue
  else Result := '';
end;

function TACPWideStringProperty.GetWideStrValue: WideString;
begin
  Result := GetWideStrValueAt(0);
end;

function TACPWideStringProperty.GetWideStrValueAt(Index: Integer): WideString;
begin
  with FPropList^[Index] do Result := GetWideStrProp(Instance, PropInfo);
end;

procedure TACPWideStringProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

procedure TACPWideStringProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  CanvasTextRectW(ACanvas, ARect, ARect.Left + 1, ARect.Top + 1, GetWideDisplayValue);
end;

procedure TACPWideStringProperty.SetPropEntry(Index: Integer; AInstance: TPersistent; APropInfo: PPropInfo);
begin
  inherited;
  with FPropList^[Index] do
  begin
    Instance := AInstance;
    PropInfo := APropInfo;
  end;
end;

procedure TACPWideStringProperty.SetValue(const Value: string);
var
  S: WideString;
begin
  try
    S := ACPUnscrambleWideString(Value);
  except
    S := FSaveValue;
  end;
  SetWideStrValue(S);
end;

procedure TACPWideStringProperty.SetWideStrValue(const Value: WideString);
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do with FPropList^[I] do SetWideStrProp(Instance, PropInfo, Value);
  Modified;
end;

{ TACPWideCaptionProperty }

function TACPWideCaptionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paAutoUpdate];
end;


{$ENDIF}


procedure Register;
begin
  RegisterComponents('Toolbar2000', [TTBDock, TTBToolbar, TTBToolWindow,
    TTBPopupMenu, TTBImageList, TTBItemContainer, TTBBackground, TTBMRUList,
    TTBMDIHandler]);
  {$IFDEF JR_D4}
  RegisterActions('', [TTBEditAction], nil);
  {$ENDIF}
  RegisterNoIcon([TTBItem, TTBGroupItem, TTBSubmenuItem, TTBSeparatorItem,
    TTBEditItem, TTBMRUListItem, TTBControlItem, TTBMDIWindowItem,
    TTBVisibilityToggleItem]);
  RegisterClasses([TTBItem, TTBGroupItem, TTBSubmenuItem, TTBSeparatorItem,
    TTBEditItem, TTBMRUListItem, TTBControlItem, TTBMDIWindowItem,
    TTBVisibilityToggleItem]);

  RegisterComponentEditor(TTBCustomToolbar, TTBItemsEditor);
  RegisterComponentEditor(TTBItemContainer, TTBItemsEditor);
  RegisterComponentEditor(TTBPopupMenu, TTBItemsEditor);
  RegisterComponentEditor(TTBCustomImageList, TTBCustomImageListEditor);
  RegisterPropertyEditor(TypeInfo(TTBRootItem), nil, '', TTBItemsPropertyEditor);
  {$IFDEF JR_D5}
  RegisterPropertyEditor(TypeInfo(TImageIndex), TTBCustomItem, 'ImageIndex',
    TTBItemImageIndexPropertyEditor);
  {$ENDIF}
  {$IFDEF JR_D6}
  { TShortCut properties show up like Integer properties in Delphi 6
    without this... }
  RegisterPropertyEditor(TypeInfo(TShortCut), TTBCustomItem, '',
    TShortCutProperty);
  {$ENDIF}
  {$IFNDEF JR_D9}
  RegisterPropertyEditor(TypeInfo(WideString), TTBCustomDockableWindow, 'Caption', TACPWideCaptionProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TTBCustomItem, 'Caption', TACPWideCaptionProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TTBCustomItem, 'Hint', TACPWideStringProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TTBEditItem, 'EditCaption', TACPWideCaptionProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TTBEditItem, 'Text', TACPWideCaptionProperty);
  {$ENDIF}

  { Link in images for the toolbar buttons }
  {$R TB2DsgnItemEditor.res}
  TBRegisterItemClass(TTBEditItem, 'New &Edit', HInstance);
  TBRegisterItemClass(TTBGroupItem, 'New &Group Item', HInstance);
  TBRegisterItemClass(TTBMRUListItem, 'New &MRU List Item', HInstance);
  TBRegisterItemClass(TTBMDIWindowItem, 'New MDI &Windows List', HInstance);
  TBRegisterItemClass(TTBVisibilityToggleItem, 'New &Visibility-Toggle Item', HInstance);
end;

end.
