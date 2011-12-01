unit TB2ExtItems;

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

  $jrsoftware: tb2k/Source/TB2ExtItems.pas,v 1.63 2005/07/04 02:49:52 jr Exp $
}

interface

{$I TB2Ver.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CommCtrl, Menus, ActnList,
  TB2Item;

type
  TTBEditItemOption = (tboUseEditWhenVertical);
  TTBEditItemOptions = set of TTBEditItemOption;

const
  EditItemDefaultEditOptions = [];
  EditItemDefaultEditWidth = 64;

type
  TTBEditItem = class;
  TTBEditItemViewer = class;

  TTBAcceptTextEvent = procedure(Sender: TObject; var NewText: WideString;
    var Accept: Boolean) of object;
  TTBBeginEditEvent = procedure(Sender: TTBEditItem; Viewer: TTBEditItemViewer;
    EditControlHandle: HWND) of object;

  TTBEditAction = class(TAction)
  private
    FEditOptions: TTBEditItemOptions;
    FEditCaption: WideString;
    FEditWidth: Integer;
    FOnAcceptText: TTBAcceptTextEvent;
    FText: WideString;
    procedure SetEditCaption(Value: WideString);
    procedure SetEditOptions(Value: TTBEditItemOptions);
    procedure SetEditWidth(Value: Integer);
    procedure SetOnAcceptText(Value: TTBAcceptTextEvent);
    procedure SetText(Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadEditCaptionProperty(Reader: TReader);
    procedure ReadTextProperty(Reader: TReader);
    procedure WriteEditCaptionProperty(Writer: TWriter);
    procedure WriteTextProperty(Writer: TWriter);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property EditCaption: WideString read FEditCaption write SetEditCaption stored False;
    property EditOptions: TTBEditItemOptions read FEditOptions write SetEditOptions default EditItemDefaultEditOptions;
    property EditWidth: Integer read FEditWidth write SetEditWidth default EditItemDefaultEditWidth;
    property Text: WideString read FText write SetText stored False;

    property OnAcceptText: TTBAcceptTextEvent read FOnAcceptText write SetOnAcceptText;
  end;

  TTBEditItemActionLink = class(TTBCustomItemActionLink)
  protected
    procedure AssignClient(AClient: TObject); override;
    function IsEditCaptionLinked: Boolean; virtual;
    function IsEditOptionsLinked: Boolean; virtual;
    function IsEditWidthLinked: Boolean; virtual;
    function IsOnAcceptTextLinked: Boolean; virtual;
    function IsTextLinked: Boolean; virtual;
    procedure SetEditCaption(const Value: WideString); virtual;
    procedure SetEditOptions(Value: TTBEditItemOptions); virtual;
    procedure SetEditWidth(const Value: Integer); virtual;
    procedure SetOnAcceptText(Value: TTBAcceptTextEvent); virtual;
    procedure SetText(const Value: WideString); virtual;
  end;

  TTBEditItem = class(TTBCustomItem)
  private
    FActiveViewer: TTBEditItemViewer;
    FCharCase: TEditCharCase;
    FEditCaption: WideString;
    FEditOptions: TTBEditItemOptions;
    FEditWidth: Integer;
    FExtendedAccept: Boolean;
    FMaxLength: Integer;
    FText: WideString;
    FOnAcceptText: TTBAcceptTextEvent;
    function IsEditCaptionStored: Boolean;
    function IsEditOptionsStored: Boolean;
    function IsEditWidthStored: Boolean;
    function IsTextStored: Boolean;
    procedure SetCharCase(Value: TEditCharCase);
    procedure SetEditCaption(Value: WideString);
    procedure SetEditOptions(Value: TTBEditItemOptions);
    procedure SetEditWidth(Value: Integer);
    procedure SetMaxLength(Value: Integer);
    procedure SetText(Value: WideString);
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure DefineProperties(Filer: TFiler); override;
    function DoAcceptText(var NewText: WideString): Boolean; virtual;
    procedure DoTextChanging(const OldText: WideString; var NewText: WideString); virtual;
    procedure DoTextChanged; virtual;
    function GetActionLinkClass: TTBCustomItemActionLinkClass; override;
    function GetItemViewerClass(AView: TTBView): TTBItemViewerClass; override;
    function NeedToRecreateViewer(AViewer: TTBItemViewer): Boolean; override;
    procedure ReadEditCaptionProperty(Reader: TReader);
    procedure ReadTextProperty(Reader: TReader);
    procedure WriteEditCaptionProperty(Writer: TWriter);
    procedure WriteTextProperty(Writer: TWriter);
    property ExtendedAccept: Boolean read FExtendedAccept write FExtendedAccept default False;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Clear;
    procedure Click; override;
  published
    property Action;
    property AutoCheck;
    property Caption;
    property CharCase: TEditCharCase read FCharCase write SetCharCase default ecNormal;
    property Checked;
    property DisplayMode;
    property EditCaption: WideString read FEditCaption write SetEditCaption stored IsEditCaptionStored;
    property EditOptions: TTBEditItemOptions read FEditOptions write SetEditOptions stored IsEditOptionsStored;
    property EditWidth: Integer read FEditWidth write SetEditWidth stored IsEditWidthStored;
    property MaxLength: Integer read FMaxLength write SetMaxLength default 0;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property RadioItem;
    property ShortCut;
    property Text: WideString read FText write SetText stored False;
    property Visible;

    property OnAcceptText: TTBAcceptTextEvent read FOnAcceptText write FOnAcceptText;
    property OnClick;
    property OnSelect;
  end;

  TEditClass = class of TEdit;

  TTBEditItemViewer = class(TTBItemViewer)
  private
    FDefaultEditWndProc: Pointer;
    FEditControlColor: TColor;
    FEditControlBrush: HBrush; // need this to handle message reflection
    FEditControlFont: TFont;
    FEditControlHandle: HWND;
    FEditControlStatus: set of (ecsContinueLoop, ecsAccept, ecsClose);
    function  EditLoop(const CapHandle: HWND): Boolean;
    procedure EditWndProc(var Message: TMessage);
    procedure MouseBeginEdit;
  protected
    FInMessageLoop: Boolean;
    FUpdating: Boolean;
    procedure CalcSize(const Canvas: TCanvas; var AWidth, AHeight: Integer); override;
    function CaptionShown: Boolean; override;
    procedure AdjustEditControlStyle(var Style, ExStyle: Cardinal;
      var Color: TColor); virtual;
    procedure AdjustEditControlFont(Font: TFont); virtual;
    function DoExecute: Boolean; override;
    function GetAccRole: Integer; override;
    function GetAccValue(var Value: WideString): Boolean; override;
    function GetCaptionText: WideString; override;
    procedure GetCursor(const Pt: TPoint; var ACursor: HCURSOR); override;
    procedure GetEditRect(var R: TRect); virtual;
    function GetEditMargins: TRect; virtual;
    function HandleEditMessage(var Message: TMessage): Boolean; virtual;
    procedure MouseDown(Shift: TShiftState; X, Y: Integer;
      var MouseDownOnMenu: Boolean); override;
    procedure MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean); override;
    procedure Paint(const Canvas: TCanvas; const ClientAreaRect: TRect;
      IsSelected, IsPushed, UseDisabledShadow: Boolean); override;
    procedure SetEditControlText(const S: WideString);
    procedure SetupEditControl(EditControlHandle: HWND); virtual;
    function UsesSameWidth: Boolean; override;
    property EditControlHandle: HWND read FEditControlHandle;
  end;

  { TTBVisibilityToggleItem }

  TTBVisibilityToggleItem = class(TTBCustomItem)
  private
    FControl: TControl;
    procedure SetControl(Value: TControl);
    procedure UpdateProps;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure Click; override;
    procedure InitiateAction; override;
  published
    property Caption;
    property Control: TControl read FControl write SetControl;
    property DisplayMode;
    property Enabled;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property Images;
    property InheritOptions;
    property MaskOptions;
    property Options;
    property ShortCut;
    property Visible;

    property OnClick;
    property OnSelect;
  end;

function GetHandleTextW(const Handle: HWND): WideString;
procedure SetHandleTextW(const Handle: HWND; const S: WideString);

implementation

uses
  TB2Common, TB2Consts;

const
  EditMenuTextMargin = 3;
  EditMenuMidWidth = 4;

type
  TControlAccess = class(TControl);

function GetHandleTextW(const Handle: HWND): WideString;
var
  S: ANSIString;
  L: Integer;
begin
  SetLength(Result, 0);
  if Handle = 0 then Exit;
  if IsWindowUnicode(Handle) then
  begin
    L := GetWindowTextLengthW(Handle);
    SetLength(Result, L + 1);
    GetWindowTextW(Handle, PWideChar(Result), L + 1);
    SetLength(Result, L);
  end
  else
  begin
    L := GetWindowTextLength(Handle);
    SetLength(S, L + 1);
    GetWindowText(Handle, PChar(S), L + 1);
    SetLength(S, L);
    Result := S;
  end;
end;

procedure SetHandleTextW(const Handle: HWND; const S: WideString);
begin
  if IsWindowUnicode(Handle) then SetWindowTextW(Handle, PWideChar(S))
  else SetWindowText(Handle, PAnsiChar(AnsiString(S)));
end;

function EditWndProcW(Wnd: HWnd; Msg: Cardinal; WParam, LParam: Longint): Longint; stdcall;
var
  V: TTBEditItemViewer;
  Message: TMessage;
begin
  V := TTBEditItemViewer(GetWindowLongW(Wnd, GWL_USERDATA));
  if Assigned(V) then
  begin
    Message.Msg := Msg;
    Message.WParam := WParam;
    Message.LParam := LParam;
    Message.Result := 0;
    V.EditWndProc(Message);
    Result := Message.Result;
  end
  else Result := DefWindowProcW(Wnd, Msg, WParam, LParam);
end;



{ TTBEditAction }

constructor TTBEditAction.Create(AOwner: TComponent);
begin
  inherited;
  FEditOptions := EditItemDefaultEditOptions;
  FEditWidth := EditItemDefaultEditWidth;
  DisableIfNoHandler := False;
end;

procedure TTBEditAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('EditCaption', ReadEditCaptionProperty, WriteEditCaptionProperty, Length(EditCaption) > 0);
  Filer.DefineProperty('Text', ReadTextProperty, WriteTextProperty, Length(Text) > 0);
end;

procedure TTBEditAction.ReadEditCaptionProperty(Reader: TReader);
begin
  EditCaption := FilerReadWideString(Reader);
end;

procedure TTBEditAction.ReadTextProperty(Reader: TReader);
begin
  Text := FilerReadWideString(Reader);
end;

procedure TTBEditAction.SetEditCaption(Value: WideString);
var
  I: Integer;
begin
  if FEditCaption <> Value then begin
    for I := 0 to FClients.Count - 1 do
      if TBasicActionLink(FClients[I]) is TTBEditItemActionLink then
        TTBEditItemActionLink(FClients[I]).SetEditCaption(Value);
    FEditCaption := Value;
    Change;
  end;
end;

procedure TTBEditAction.SetEditOptions(Value: TTBEditItemOptions);
var
  I: Integer;
begin
  if FEditOptions <> Value then begin
    for I := 0 to FClients.Count - 1 do
      if TBasicActionLink(FClients[I]) is TTBEditItemActionLink then
        TTBEditItemActionLink(FClients[I]).SetEditOptions(Value);
    FEditOptions := Value;
    Change;
  end;
end;

procedure TTBEditAction.SetEditWidth(Value: Integer);
var
  I: Integer;
begin
  if FEditWidth <> Value then begin
    for I := 0 to FClients.Count - 1 do
      if TBasicActionLink(FClients[I]) is TTBEditItemActionLink then
        TTBEditItemActionLink(FClients[I]).SetEditWidth(Value);
    FEditWidth := Value;
    Change;
  end;
end;

procedure TTBEditAction.SetOnAcceptText(Value: TTBAcceptTextEvent);
var
  I: Integer;
begin
  if not MethodsEqual(TMethod(FOnAcceptText), TMethod(Value)) then begin
    for I := 0 to FClients.Count - 1 do
      if TBasicActionLink(FClients[I]) is TTBEditItemActionLink then
        TTBEditItemActionLink(FClients[I]).SetOnAcceptText(Value);
    FOnAcceptText := Value;
    Change;
  end;
end;

procedure TTBEditAction.SetText(Value: WideString);
var
  I: Integer;
begin
  if FText <> Value then begin
    for I := 0 to FClients.Count - 1 do
      if TBasicActionLink(FClients[I]) is TTBEditItemActionLink then
        TTBEditItemActionLink(FClients[I]).SetText(Value);
    FText := Value;
    Change;
  end;
end;


procedure TTBEditAction.WriteEditCaptionProperty(Writer: TWriter);
begin
  FilerWriteWideString(Writer, EditCaption);
end;

procedure TTBEditAction.WriteTextProperty(Writer: TWriter);
begin
  FilerWriteWideString(Writer, Text);
end;

{ TTBEditItemActionLink }

procedure TTBEditItemActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TTBEditItem;
end;

function TTBEditItemActionLink.IsEditCaptionLinked: Boolean;
begin
  if Action is TTBEditAction then
    Result := TTBEditItem(FClient).EditCaption = TTBEditAction(Action).EditCaption
  else
    Result := False;
end;

function TTBEditItemActionLink.IsEditOptionsLinked: Boolean;
begin
  if Action is TTBEditAction then
    Result := TTBEditItem(FClient).EditOptions = TTBEditAction(Action).EditOptions
  else
    Result := False;
end;

function TTBEditItemActionLink.IsEditWidthLinked: Boolean;
begin
  if Action is TTBEditAction then
    Result := TTBEditItem(FClient).EditWidth = TTBEditAction(Action).EditWidth
  else
    Result := False;
end;

function TTBEditItemActionLink.IsOnAcceptTextLinked: Boolean;
begin
  if Action is TTBEditAction then
    Result := MethodsEqual(TMethod(TTBEditItem(FClient).OnAcceptText),
      TMethod(TTBEditAction(Action).OnAcceptText))
  else
    Result := False;
end;

function TTBEditItemActionLink.IsTextLinked: Boolean;
begin
  if Action is TTBEditAction then
    Result := TTBEditItem(FClient).Text = TTBEditAction(Action).Text
  else
    Result := False;
end;

procedure TTBEditItemActionLink.SetEditCaption(const Value: WideString);
begin
  if IsEditCaptionLinked then TTBEditItem(FClient).EditCaption := Value;
end;

procedure TTBEditItemActionLink.SetEditOptions(Value: TTBEditItemOptions);
begin
  if IsEditOptionsLinked then TTBEditItem(FClient).EditOptions := Value;
end;

procedure TTBEditItemActionLink.SetEditWidth(const Value: Integer);
begin
  if IsEditWidthLinked then TTBEditItem(FClient).EditWidth := Value;
end;

procedure TTBEditItemActionLink.SetOnAcceptText(Value: TTBAcceptTextEvent);
begin
  if IsOnAcceptTextLinked then TTBEditItem(FClient).OnAcceptText := Value;
end;

procedure TTBEditItemActionLink.SetText(const Value: WideString);
begin
  if IsTextLinked then TTBEditItem(FClient).SetText(Value);
end;


{ TTBEditItem }

constructor TTBEditItem.Create(AOwner: TComponent);
begin
  inherited;
  FEditOptions := EditItemDefaultEditOptions;
  FEditWidth := EditItemDefaultEditWidth;
end;

procedure TTBEditItem.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited;
  if Action is TTBEditAction then
    with TTBEditAction(Sender) do
    begin
      if not CheckDefaults or (Self.EditCaption = '') then
        Self.EditCaption := EditCaption;
      if not CheckDefaults or (Self.EditOptions = []) then
        Self.EditOptions := EditOptions;
      if not CheckDefaults or (Self.Text = '') then
        Self.SetText(Text);
      if not CheckDefaults or not Assigned(Self.OnAcceptText) then
        Self.OnAcceptText := OnAcceptText;
    end;
end;

function TTBEditItem.GetActionLinkClass: TTBCustomItemActionLinkClass;
begin
  Result := TTBEditItemActionLink;
end;

function TTBEditItem.GetItemViewerClass(AView: TTBView): TTBItemViewerClass;
begin
  if not(tboUseEditWhenVertical in EditOptions) and
     (AView.Orientation = tbvoVertical) then
    Result := inherited GetItemViewerClass(AView)
  else
    Result := TTBEditItemViewer;
end;

function TTBEditItem.NeedToRecreateViewer(AViewer: TTBItemViewer): Boolean;
begin
  Result := GetItemViewerClass(AViewer.View) <> AViewer.ClassType;
end;

procedure TTBEditItem.Clear;
begin
  Text := '';
end;

procedure TTBEditItem.Click;
begin
  inherited;
end;

function TTBEditItem.IsEditOptionsStored: Boolean;
begin
  Result := (EditOptions <> EditItemDefaultEditOptions) and
    ((ActionLink = nil) or not(ActionLink is TTBEditItemActionLink) or
     not TTBEditItemActionLink(ActionLink).IsEditOptionsLinked);
end;

function TTBEditItem.IsEditCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not(ActionLink is TTBEditItemActionLink) or
    not TTBEditItemActionLink(ActionLink).IsEditCaptionLinked;
end;

function TTBEditItem.IsEditWidthStored: Boolean;
begin
  Result := (EditWidth <> EditItemDefaultEditWidth) and
    ((ActionLink = nil) or not(ActionLink is TTBEditItemActionLink) or
     not TTBEditItemActionLink(ActionLink).IsEditWidthLinked);
end;

function TTBEditItem.IsTextStored: Boolean;
begin
  Result := (ActionLink = nil) or not(ActionLink is TTBEditItemActionLink) or
    not TTBEditItemActionLink(ActionLink).IsTextLinked;
end;

procedure TTBEditItem.SetCharCase(Value: TEditCharCase);
begin
  if FCharCase <> Value then begin
    FCharCase := Value;
    Text := Text;  { update case }
  end;
end;

procedure TTBEditItem.SetEditOptions(Value: TTBEditItemOptions);
begin
  if FEditOptions <> Value then begin
    FEditOptions := Value;
    Change(True);
  end;
end;

procedure TTBEditItem.SetEditCaption(Value: WideString);
begin
  if FEditCaption <> Value then begin
    FEditCaption := Value;
    Change(True);
  end;
end;

procedure TTBEditItem.SetEditWidth(Value: Integer);
begin
  if FEditWidth <> Value then begin
    FEditWidth := Value;
    Change(True);
  end;
end;

procedure TTBEditItem.SetMaxLength(Value: Integer);
begin
  if FMaxLength <> Value then begin
    FMaxLength := Value;
    Change(False);
  end;
end;

function TTBEditItem.DoAcceptText(var NewText: WideString): Boolean;
begin
  Result := True;
  if Assigned(FOnAcceptText) then FOnAcceptText(Self, NewText, Result);
end;

procedure TTBEditItem.DoTextChanging(const OldText: WideString; var NewText: WideString);
begin
  case FCharCase of
    ecUpperCase: NewText := WideUpperCase(NewText);
    ecLowerCase: NewText := WideLowerCase(NewText);
  end;
end;

procedure TTBEditItem.SetText(Value: WideString);
begin
  DoTextChanging(FText, Value);
  if FText <> Value then begin
    FText := Value;
    if Assigned(FActiveViewer) then FActiveViewer.SetEditControlText(Value);
    Change(False);
    DoTextChanged;
  end;
end;

procedure TTBEditItem.DoTextChanged;
begin
end;

procedure TTBEditItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('EditCaption', ReadEditCaptionProperty, WriteEditCaptionProperty, Length(EditCaption) > 0);
  Filer.DefineProperty('Text', ReadTextProperty, WriteTextProperty, (Length(Text) > 0) and IsTextStored);
end;

procedure TTBEditItem.ReadEditCaptionProperty(Reader: TReader);
begin
  EditCaption := FilerReadWideString(Reader);
end;

procedure TTBEditItem.ReadTextProperty(Reader: TReader);
begin
  Text := FilerReadWideString(Reader);
end;

procedure TTBEditItem.WriteTextProperty(Writer: TWriter);
begin
  FilerWriteWideString(Writer, Text);
end;

procedure TTBEditItem.WriteEditCaptionProperty(Writer: TWriter);
begin
  FilerWriteWideString(Writer, EditCaption);
end;

{ TTBEditItemViewer }

procedure TTBEditItemViewer.AdjustEditControlFont(Font: TFont);
begin
end;

procedure TTBEditItemViewer.AdjustEditControlStyle(var Style, ExStyle: Cardinal; var Color: TColor);
begin
end;

procedure TTBEditItemViewer.EditWndProc(var Message: TMessage);

  procedure AcceptText;
  var
    S: WideString;
  begin
    S := GetHandleTextW(FEditControlHandle);
    if TTBEditItem(Item).DoAcceptText(S) then TTBEditItem(Item).SetText(S);
  end;

begin
  if FEditControlHandle = 0 then Exit;
  if FInMessageLoop and HandleEditMessage(Message) then Exit;

  case Message.Msg of
    WM_CHAR:
      case TWMChar(Message).CharCode of
        VK_TAB: begin
            FEditControlStatus := [ecsAccept];
            AcceptText;
            Exit;
          end;
        VK_RETURN: begin
            FEditControlStatus := [ecsAccept, ecsClose];
            AcceptText;
            Exit;
          end;
        VK_ESCAPE: begin
            FEditControlStatus := [];
            Exit;
          end;
      end;

    CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC:
      if FEditControlBrush <> 0 then
      begin
        { handle message reflection (search msdn for defails) }
        SetTextColor(Message.WParam, ColorToRGB(FEditControlFont.Color));
        SetBkColor(Message.WParam, ColorToRGB(FEditControlColor));
        Message.Result := FEditControlBrush;
        Exit;
      end;
  end;

  with Message do
  begin
    if IsWindowUnicode(FEditControlHandle) then
      Result := CallWindowProcW(FDefaultEditWndProc, FEditControlHandle, Msg, WParam, LParam)
    else
      Result := CallWindowProcA(FDefaultEditWndProc, FEditControlHandle, Msg, WParam, LParam);
  end;

  if Message.Msg = WM_KILLFOCUS then begin
    { Someone has stolen the focus from us, so 'cancel mode'. (We have to
      handle WM_KILLFOCUS in addition to the upstream WM_CANCELMODE handling
      since we don't always hold the mouse capture.) }
    View.CancelMode;
    FEditControlStatus := [ecsClose];
  end;
end;

function TTBEditItemViewer.GetEditMargins: TRect;
begin
  Result.Left := 3;
  Result.Top := 3;
  Result.Right := 3;
  Result.Bottom := 3;
end;

procedure TTBEditItemViewer.GetEditRect(var R: TRect);
var
  Item: TTBEditItem;
  DC: HDC;
begin
  Item := TTBEditItem(Self.Item);
  DC := GetDC(0);
  try
    SelectObject(DC, View.GetFont.Handle);
    R := BoundsRect;
    if not View.IsToolbar and (Item.EditCaption <> '') then begin
      Inc(R.Left, GetTextWidthW(DC, Item.EditCaption, True) +
        EditMenuMidWidth + EditMenuTextMargin * 2);
    end;
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure TTBEditItemViewer.CalcSize(const Canvas: TCanvas;
  var AWidth, AHeight: Integer);
var
  Item: TTBEditItem;
  DC: HDC;
  TextHeight, MinHeight: Integer;
begin
  Item := TTBEditItem(Self.Item);
  DC := Canvas.Handle;
  TextHeight := GetTextHeight(DC);
  AWidth := Item.FEditWidth;
  AHeight := TextHeight;
  if not IsToolbarStyle and (Item.EditCaption <> '') then begin
    Inc(AWidth, GetTextWidthW(DC, Item.EditCaption, True) + EditMenuMidWidth +
      EditMenuTextMargin * 2);
  end;
  MinHeight := AHeight + (EditMenuTextMargin * 2) + 1;
  if not IsToolbarStyle then
    Inc(AHeight, DivRoundUp(AHeight, 4));
  if AHeight < MinHeight then
    AHeight := MinHeight;
end;

function TTBEditItemViewer.CaptionShown: Boolean;
begin
  Result := not IsToolbarStyle and inherited CaptionShown;
end;

function TTBEditItemViewer.GetCaptionText: WideString;
begin
  Result := TTBEditItem(Item).EditCaption;
end;

procedure TTBEditItemViewer.Paint(const Canvas: TCanvas;
  const ClientAreaRect: TRect; IsSelected, IsPushed, UseDisabledShadow: Boolean);
const
  FillColors: array[Boolean] of TColor = (clBtnFace, clWindow);
  TextColors: array[Boolean] of TColor = (clGrayText, clWindowText);
var
  Item: TTBEditItem;
  S: WideString;
  R: TRect;
  W: Integer;
begin
  Item := TTBEditItem(Self.Item);
  R := ClientAreaRect;

  { Caption }
  if not IsToolbarStyle and (Item.EditCaption <> '') then begin
    S := Item.EditCaption;
    W := GetTextWidthW(Canvas.Handle, S, True) + EditMenuTextMargin * 2;
    R.Right := R.Left + W;
    if IsSelected then
      Canvas.FillRect(R);
    Inc(R.Left, EditMenuTextMargin);
    DrawItemCaption(Canvas, R, S, UseDisabledShadow, DT_SINGLELINE or
      DT_LEFT or DT_VCENTER);
    R := ClientAreaRect;
    Inc(R.Left, W + EditMenuMidWidth);
  end;

  { Border }
  if IsSelected and Item.Enabled then
    DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_RECT);
  InflateRect(R, -1, -1);
  Canvas.Brush.Color := FillColors[not Item.Enabled];
  Canvas.FrameRect(R);
  InflateRect(R, -1, -1);

  { Fill }
  Canvas.Brush.Color := FillColors[Item.Enabled];
  Canvas.FillRect(R);
  InflateRect(R, -1, -1);

  { Text }
  if Item.Text <> '' then begin
    S := Item.Text;
    Canvas.Brush.Style := bsClear;  { speed optimization }
    Canvas.Font.Color := TextColors[Item.Enabled];
    _DrawTextW(Canvas.Handle, PWideChar(S), Length(S), R, DT_SINGLELINE or DT_NOPREFIX);
  end;
end;

procedure TTBEditItemViewer.GetCursor(const Pt: TPoint; var ACursor: HCURSOR);
var
  R: TRect;
begin
  if not Item.Enabled then
    Exit;
  GetEditRect(R);
  OffsetRect(R, -BoundsRect.Left, -BoundsRect.Top);
  InflateRect(R, -2, -2);
  if PtInRect(R, Pt) then
    ACursor := LoadCursor(0, IDC_IBEAM);
end;

function TTBEditItemViewer.EditLoop(const CapHandle: HWND): Boolean;
const
  CharCases: array [TEditCharCase] of DWORD = (0, ES_UPPERCASE, ES_LOWERCASE);

  procedure ControlMessageLoop;

    function PointInWindow(const Wnd: HWND; const P: TPoint): Boolean;
    var
      W: HWND;
    begin
      Result := False;
      W := WindowFromPoint(P);
      if W = 0 then Exit;
      if W = Wnd then
        Result := True
      else
        if IsChild(Wnd, W) then
          Result := True;
    end;

    function ContinueLoop: Boolean;
    begin
      Result := (ecsContinueLoop in FEditControlStatus) and not View.IsModalEnding and
        (Windows.GetFocus = FEditControlHandle) and Item.Enabled;
      { Note: View.IsModalEnding is checked since TTBView.CancelMode doesn't
        destroy popup windows; it merely hides them and calls EndModal. So if
        IsModalEnding returns True we can infer that CancelMode was likely
        called. }
    end;

  var
    Msg: TMsg;
    IsKeypadDigit: Boolean;
    V: Integer;
  begin
    try
      while ContinueLoop do begin
        { Examine the next message before popping it out of the queue }
        if not PeekMessageW(Msg, 0, 0, 0, PM_NOREMOVE) then begin
          WaitMessage;
          Continue;
        end;
        case Msg.message of
          WM_SYSKEYDOWN: begin
              { Exit immediately if Alt+[key] or F10 are pressed, but not
                Alt+Shift, Alt+`, or Alt+[keypad digit] }
              if (Msg.wParam <> VK_MENU) and (Msg.wParam <> VK_SHIFT) and
                 (Msg.wParam <> VK_HANJA) then begin
                IsKeypadDigit := False;
                { This detect digits regardless of whether Num Lock is on: }
                if Lo(LongRec(Msg.lParam).Hi) <> 0 then
                  for V := VK_NUMPAD0 to VK_NUMPAD9 do
                    if MapVirtualKey(V, 0) = Lo(LongRec(Msg.lParam).Hi) then begin
                      IsKeypadDigit := True;
                      Break;
                    end;
                if not IsKeypadDigit then begin
                  FEditControlStatus := [ecsClose];
                  Exit;
                end;
              end;
            end;
          WM_SYSKEYUP: begin
              { Exit when Alt is released by itself }
              if Msg.wParam = VK_MENU then begin
                FEditControlStatus := [ecsClose];
                Exit;
              end;
            end;
          WM_LBUTTONDOWN, WM_LBUTTONDBLCLK,
          WM_RBUTTONDOWN, WM_RBUTTONDBLCLK,
          WM_MBUTTONDOWN, WM_MBUTTONDBLCLK,
          WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK,
          WM_NCRBUTTONDOWN, WM_NCRBUTTONDBLCLK,
          WM_NCMBUTTONDOWN, WM_NCMBUTTONDBLCLK: begin
              { If a mouse click outside the edit control is in the queue,
                exit and let the upstream message loop deal with it }
              if Msg.hwnd <> FEditControlHandle then
                Exit;
            end;
          WM_MOUSEMOVE, WM_NCMOUSEMOVE: begin
              if GetCapture = CapHandle then begin
                if PointInWindow(FEditControlHandle, Msg.pt) then
                  ReleaseCapture;
              end
              else if GetCapture = 0 then begin
                if not PointInWindow(FEditControlHandle, Msg.pt) then
                  SetCapture(CapHandle);
              end;
              if GetCapture = CapHandle then
                SetCursor(LoadCursor(0, IDC_ARROW));
            end;
        end;
        { Now pop the message out of the queue }
        if not PeekMessageW(Msg, 0, Msg.message, Msg.message, PM_REMOVE or PM_NOYIELD) then
          Continue;
        if ((Msg.message >= WM_MOUSEFIRST) and (Msg.message <= WM_MOUSELAST)) and
           (Msg.hwnd = CapHandle) then
          { discard, so that the selection doesn't get changed }
        else begin
          TranslateMessage(Msg);
          DispatchMessageW(Msg);
        end;
      end;
    finally
      { Make sure there are no outstanding WM_*CHAR messages }
      RemoveMessages(WM_CHAR, WM_DEADCHAR);
      RemoveMessages(WM_SYSCHAR, WM_SYSDEADCHAR);
    end;
  end;

var
  Item: TTBEditItem;
  R: TRect;
  ActiveWnd, FocusWnd: HWND;
  Style, ExStyle: Cardinal;
  S: WideString;
begin
  Item := TTBEditItem(Self.Item);
  GetEditRect(R);
  if IsRectEmpty(R) then begin
    Result := False;
    Exit;
  end;

  ActiveWnd := GetActiveWindow;
  FocusWnd := GetFocus;

  { Create the edit control }
  with GetEditMargins do
  begin
    Inc(R.Left, Left);
    Inc(R.Top, Top);
    Dec(R.Right, Right);
    Dec(R.Bottom, Bottom);
  end;
  //View.FreeNotification (Self);

  Style := WS_CHILD or ES_LEFT or ES_AUTOHSCROLL or ES_AUTOVSCROLL or CharCases[Item.FCharCase];
  ExStyle := 0;
  FEditControlColor := clWindow;

  AdjustEditControlStyle(Style, ExStyle, FEditControlColor);

  FEditControlFont := TFont.Create;
  try
    FEditControlFont.Assign(View.GetFont);
    AdjustEditControlFont(FEditControlFont);

    { create a brush for background painting and to handle message reflection }
    if FEditControlColor < 0 then FEditControlBrush := GetSysColorBrush(FEditControlColor and $000000FF)
    else FEditControlBrush := CreateSolidBrush(FEditControlColor);

    { create standard win32 edit control with unicode handle }
    FEditControlHandle := CreateWindowExW(ExStyle, 'EDIT', nil, Style,
      R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
      View.Window.Handle, 0, HInstance, Self);
    if FEditControlHandle = 0 then RaiseLastOSError;
    SetHandleTextW(FEditControlHandle, Item.Text);

    FDefaultEditWndProc := Pointer(GetWindowLongW(FEditControlHandle, GWL_WNDPROC));
    SetWindowLongW(FEditControlHandle, GWL_USERDATA, Integer(Self));
    SetWindowLongW(FEditControlHandle, GWL_WNDPROC, Integer(@EditWndProcW));
    try
      SendMessageW(FEditControlHandle, WM_SETFONT, FEditControlFont.Handle, 0);

      { setup the rest of the edit control properties }
      SetupEditControl(FEditControlHandle);

      { show and focus onto the edit control }
      SetWindowPos(FEditControlHandle, 0, 0, 0, 0, 0,
        SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_NOACTIVATE + SWP_SHOWWINDOW);
      Windows.SetFocus(FEditControlHandle);
      Windows.InvalidateRect(FEditControlHandle, nil, True);

      if GetActiveWindow <> ActiveWnd then
        { don't gray out title bar of old active window }
        SendMessage(ActiveWnd, WM_NCACTIVATE, 1, 0)
      else
        ActiveWnd := 0;

      FEditControlStatus := [ecsContinueLoop];
      Assert(Item.FActiveViewer = nil);
      Item.FActiveViewer := Self;
      FInMessageLoop := True;
      try
        ControlMessageLoop;
      finally
        FInMessageLoop := False;
        Item.FActiveViewer := nil;
      end;
      S := GetHandleTextW(FEditControlHandle);

    finally
      DeleteObject(FEditControlBrush);
      FEditControlBrush := 0;
      FEditControlFont.Free;
      FEditControlFont := nil;
      FEditControlColor := clNone;
      SetWindowLongW(FEditControlHandle, GWL_WNDPROC, Integer(FDefaultEditWndProc));
      FDefaultEditWndProc := nil;
      if not Windows.DestroyWindow(FEditControlHandle) then RaiseLastOSError;
    end;
  finally
    FEditControlFont.Free;
    FEditControlFont := nil;
  end;

  with TTBEditItem(Item) do
  if (FEditControlStatus = [ecsContinueLoop]) and ExtendedAccept then
    if DoAcceptText(S) then SetText(S);

  { ensure the area underneath the edit control is repainted immediately }
  View.Window.Update;
  { If app is still active, set focus to previous control and restore capture
    to CapHandle if another control hasn't taken it }
  if GetActiveWindow <> 0 then begin
    SetFocus(FocusWnd);
    if GetCapture = 0 then
      SetCapture(CapHandle);
  end;
  if ActiveWnd <> 0 then
    SendMessage(ActiveWnd, WM_NCACTIVATE, Ord(GetActiveWindow = ActiveWnd), 0);
  { The SetFocus call above can change the Z order of windows. If the parent
    window is a popup window, reassert its topmostness. }
  if View.Window is TTBPopupWindow then
    SetWindowPos(View.Window.Handle, HWND_TOPMOST, 0, 0, 0, 0,
      SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  { Send an MSAA "focus" event now that we're returning to the regular modal loop }
  View.NotifyFocusEvent;

  Result := ecsClose in FEditControlStatus;
  if not Result and (GetCapture = CapHandle) then begin
    if ecsAccept in FEditControlStatus then
      { if we are accepting but not closing, Tab must have been pressed }
      View.Selected := View.NextSelectable(View.Selected,
        GetKeyState(VK_SHIFT) >= 0);
  end;
end;

function TTBEditItemViewer.HandleEditMessage(var Message: TMessage): Boolean;
begin
  { Override in descendants to simplify subclassing }
  Result := False;
end;

function TTBEditItemViewer.DoExecute: Boolean;
begin
  { Close any delay-close popup menus before entering the edit loop }
  View.CancelChildPopups;
  Result := False;
  if EditLoop(View.GetCaptureWnd) then begin
    View.EndModal;
    if ecsAccept in FEditControlStatus then
      Result := True;
  end;
end;

procedure TTBEditItemViewer.MouseBeginEdit;
begin
  if Item.Enabled then
    Execute(True)
  else begin
    if (View.ParentView = nil) and not View.IsPopup then
      View.EndModal;
  end;
end;

procedure TTBEditItemViewer.MouseDown(Shift: TShiftState; X, Y: Integer;
  var MouseDownOnMenu: Boolean);
begin
  if IsPtInButtonPart(X, Y) then  { for TBX... }
    MouseBeginEdit
  else
    inherited;
end;

procedure TTBEditItemViewer.MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean);
begin
  if IsPtInButtonPart(X, Y) then  { for TBX... }
    MouseBeginEdit
  else
    inherited;
end;

procedure TTBEditItemViewer.SetEditControlText(const S: WideString);
begin
  if not FUpdating and (EditControlHandle <> 0) then
  try
    FUpdating := True;
    SetHandleTextW(EditControlHandle, S);
  finally
    FUpdating := False;
  end;
end;

procedure TTBEditItemViewer.SetupEditControl(EditControlHandle: HWND);
begin
  SendMessage(EditControlHandle, EM_LIMITTEXT, TTBEditItem(Item).MaxLength, 0);
  SendMessage(EditControlHandle, EM_SETSEL, 0, -1);
  SendMessage(EditControlHandle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, 0);
end;

function TTBEditItemViewer.UsesSameWidth: Boolean;
begin
  Result := False;
end;

function TTBEditItemViewer.GetAccRole: Integer;
const
  ROLE_SYSTEM_TEXT = $2a;  { from OleAcc.h }
begin
  Result := ROLE_SYSTEM_TEXT;
end;

function TTBEditItemViewer.GetAccValue(var Value: WideString): Boolean;
begin
  Value := TTBEditItem(Item).Text;
  Result := True;
end;


{ TTBToolbarVisibilityItem }

procedure TTBVisibilityToggleItem.Click;
begin
  if Assigned(FControl) then
    FControl.Visible := not FControl.Visible;
  inherited;
end;

procedure TTBVisibilityToggleItem.InitiateAction;
begin
  UpdateProps;
end;

procedure TTBVisibilityToggleItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then
    Control := nil;
end;

procedure TTBVisibilityToggleItem.SetControl(Value: TControl);
begin
  if FControl <> Value then begin
    FControl := Value;
    if Assigned(Value) then begin
      Value.FreeNotification(Self);
      if (Caption = '') and not(csLoading in ComponentState) then
        Caption := TControlAccess(Value).Caption;
    end;
    UpdateProps;
  end;
end;

procedure TTBVisibilityToggleItem.UpdateProps;
begin
  if (ComponentState * [csDesigning, csLoading, csDestroying] = []) then
    Checked := Assigned(FControl) and FControl.Visible;
end;

end.
