{-----------------------------------------------------------------------------
 Unit Name: RbButton
 Purpose: Fade in/out gradient button

 Author/Copyright: Nathanaël VERON - r.b.a.g@free.fr - http://r.b.a.g.free.fr


        Feel free to modify and improve source code, mail me (r.b.a.g@free.fr)
        if you make any big fix or improvement that can be included in the next
        versions. If you use the RbControls in your project please
        mention it or make a link to my website.

       ===============================================

       /*   03/09/2003    */
       Correction of a bug in the ModalResult property

       /*   30/09/2003    */
       Correction of a graphic bug when clicking

       /*   13/11/2003    */
       Modifications for D5 compatibility
       thx to Pierre Castelain -> www.micropage.fr.st

       /*   08/12/2003    */
       Added Down, AllowAllUp and GroupIndex property
       for SpeedButton like behaviour.        
-----------------------------------------------------------------------------}


unit RbButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, ExtCtrls, RbDrawCore,
  Buttons, Forms;

type


  TRbButton = class(TRbCustomControl)
  private
    FColors : TRbControlColors;
    FGrBitmap: TBitmap;
    FGrMouseOver: TBitmap;
    FGrClicked: TBitmap;
    FGlyph : TBitmap;
    FLayout : TButtonLayout;
    FModalResult: TModalResult;
    FSpacing: integer;
    FShowFocusRect : boolean;
    FHotTrack : boolean;
    FDefault: boolean;
    FCancel : boolean;
    FGradientBorder: boolean;
    FDown: boolean;
    FAllowAllUp: boolean;
    FGroupIndex: integer;
    FGradientType: TGradientType;
    FFadeSpeed: TFadeSpeed;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure SetGlyph(const Value: TBitmap);
    procedure SetSpacing(const Value: integer);
    procedure SetLayout(const Value: TButtonLayout);
    procedure SetFadeSpeed(const Value: TFadeSpeed);
    procedure SetFocusRect(const Value: boolean);
    procedure SetHotTrack(const Value: boolean);
    procedure SetDefault(const Value: boolean);
    procedure SetAllowAllUp(const Value: boolean);
    procedure SetDown(const Value: boolean);
    procedure SetGroupIndex(const Value: integer);
    procedure DeActivateSiblings;
    function CanBeUp: boolean;
    procedure SetGradientType(const Value: TGradientType);
  protected
    procedure Paint; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure EventResized; override;
    procedure EventMouseEnter; override;
    procedure EventMouseLeave; override;
    procedure EventMouseDown; override;
    procedure EventMouseUp; override;
    procedure EventFocusChanged; override;
    procedure UpdateGradients; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
  published
    property Caption;  
    property ModalResult : TModalResult read FModalResult write FModalResult;

    property Glyph: TBitmap read FGlyph write SetGlyph;
    property Spacing: integer read FSpacing write SetSpacing;
    property Layout: TButtonLayout read FLayout write SetLayout;
    property Colors : TRbControlColors read FColors write FColors;
    property FadeSpeed : TFadeSpeed read FFadeSpeed write SetFadeSpeed;
    property ShowFocusRect : boolean read FShowFocusRect write SetFocusRect;
    property HotTrack: boolean read FHotTrack write SetHotTrack;
    property Default : boolean read FDefault write SetDefault default false;
    property Cancel : boolean read FCancel write FCancel default false;
    property GradientBorder: boolean read FGradientBorder write FGradientBorder;
    property GroupIndex: integer read FGroupIndex write SetGroupIndex;
    property AllowAllUp: boolean read FAllowAllUp write SetAllowAllUp;
    property Down : boolean read FDown write SetDown;
    property GradientType: TGradientType read FGradientType write SetGradientType;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RbControls', [TRbButton]);
end;

{---------------------------------------------
              TRbButton
---------------------------------------------}

procedure TRbButton.Paint;
var
  R : TRect;
  Flags: integer;
  FinalBitmap: TBitmap;
  Gl : TBitmap;
begin
  inherited;
  FinalBitmap := TBitmap.Create;
  try
    FinalBitmap.PixelFormat := pf24bit;
    FinalBitmap.Width := Width;
    FinalBitmap.Height := Height;

    R := GetClientRect;

    //Blend the base gradient and the MouseOver Gradient
    BlendBitmaps(FinalBitmap, FGrBitmap, FGrMouseOver, FOverBlendPercent, R, 1);

    //Blend the previous gradient and the Selection Gradient
    if FClickedBlendPercent > 0 then begin
      if GradientBorder then
        InflateRect(R, -3, -3);

      BlendBitmaps(FinalBitmap, FinalBitmap, FGrClicked, FClickedBlendPercent, R, 1);

      if GradientBorder then
        InflateRect(R, 3, 3);
    end;

    FinalBitmap.Canvas.Brush.Style := bsClear;
    FinalBitmap.Canvas.Pen.Color := Color;
    FinalBitmap.Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);

    FinalBitmap.Canvas.Pen.Color := FColors.BorderColor;
    FinalBitmap.Canvas.RoundRect(0, 0, Width, Height, 5, 5);

    BitBlt(Canvas.Handle, 0, 0, Width, Height, FinalBitmap.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    FinalBitmap.Free;
  end;

  //Calc text rect
  if not Glyph.Empty then begin
    case FLayout of
      blGlyphLeft :
        Inc(R.Left, FGlyph.Width + FSpacing);
      blGlyphRight :
        Dec(R.Left, FGlyph.Width + FSpacing);
      blGlyphTop :
        Inc(R.Top, FGlyph.Width + FSpacing);
      blGlyphBottom :
        Dec(R.Top, FGlyph.Width + FSpacing);
    end;
  end;

  SetBkMode(Canvas.Handle, Windows.TRANSPARENT);
  SetTextFlags(taCenter, false, Flags);

  //Draw text
  Canvas.Font.Assign(Font);
  if FHotTrack and (dsMouseOver in FDrawStates) then Canvas.Font.Color := FColors.HotTrack;

  if ShowCaption then
    DoDrawText(Canvas, Caption, Canvas.Font, Enabled, false, R, Flags, TextShadow, Colors.TextShadow);

  //Draw the glyph
  if not Glyph.Empty then begin
    gl := TBitmap.Create;
    try
      gl.Assign(FGlyph);
      gl.PixelFormat := pf24bit;
      gl.Transparent := true;
      if not Enabled then
        ColorizeBitmap(gl, $00404040);

      case FLayout of
        blGlyphLeft :
          if (Caption <> '') and ShowCaption then
            Canvas.Draw((R.Left + R.Right - canvas.TextWidth(Caption)) div 2 - FSpacing - FGlyph.Width, (Height - FGlyph.Height) div 2, gl)
          else
            Canvas.Draw((R.Left + R.Right - FSpacing) div 2 - FGlyph.Width, (Height - FGlyph.Height) div 2, gl);

        blGlyphRight :
          if (Caption <> '') and ShowCaption then
            Canvas.Draw((R.Left + R.Right + canvas.TextWidth(Caption)) div 2 + FSpacing, (Height - FGlyph.Height) div 2, gl)
          else
            Canvas.Draw((R.Left + R.Right) div 2 + FSpacing, (Height - FGlyph.Height) div 2, gl);
        blGlyphTop :
          if (Caption <> '') and ShowCaption then
            Canvas.Draw((Width - FGlyph.Width) div 2, (R.Top + R.Bottom - canvas.TextHeight(Caption)) div 2 - FSpacing - FGlyph.Height,  gl)
          else
            Canvas.Draw((Width - FGlyph.Width) div 2, (R.Top + R.Bottom) div 2 - FSpacing - FGlyph.Height,  gl);
        blGlyphBottom :
          if (Caption <> '') and ShowCaption then
            Canvas.Draw((Width - FGlyph.Width) div 2, (R.Top + R.Bottom + canvas.TextHeight(Caption)) div 2 + FSpacing,  gl)
          else
            Canvas.Draw((Width - FGlyph.Width) div 2, (R.Top + R.Bottom) div 2 + FSpacing,  gl);          
      end;
    finally
      gl.Free;
    end;
  end;

  R := GetClientRect;

  if Focused and FShowFocusRect then begin
    InflateRect(R, -2, -2);
    DrawFocusRect(Canvas.Handle, R);
  end;
end;


constructor TRbButton.Create(AOwner: TComponent);
begin
  inherited;
  Height := 25;
  Width := 75;

  FGrBitmap := TBitmap.Create;
  FGrBitmap.PixelFormat := pf24bit;
  FGrBitmap.Width := Width;
  FGrBitmap.Height := Height;

  FGrMouseOver := TBitmap.Create;
  FGrMouseOver.PixelFormat := pf24bit;
  FGrMouseOver.Width := Width;
  FGrMouseOver.Height := Height;

  FGrClicked := TBitmap.Create;
  FGrClicked.PixelFormat := pf24bit;
  FGrClicked.Width := Width;
  FGrClicked.Height := Height;

  FGradientType := gtVertical;

  FGlyph := TBitmap.Create;
  FGlyph.Transparent := true;

  FOverBlendPercent := 0;
  FClickedBlendPercent := 0;
  FDrawStates := [];
  FSpacing := 2;
  FLayout := blGlyphLeft;
  FadeSpeed := fsMedium;
  FShowFocusRect := true;
  FHotTrack := false;
  FGradientBorder := true;

  FDown := False;
  FAllowAllUp := false;
  FGroupIndex := 0;

  FColors := TRbControlColors.Create(Self);
end;

destructor TRbButton.Destroy;
begin
  FGrBitmap.Free;
  FGrMouseOver.Free;
  FGrClicked.free;
  FGlyph.Free;
  FColors.Free;
  inherited;
end;

procedure TRbButton.EventResized;
begin
  inherited;
  UpdateGradients;
end;

procedure TRbButton.EventMouseEnter;
begin
  inherited;
  Include(FDrawStates, dsMouseOver);
  FOnFade := DoBlendMore;
  UpdateTimer;
end;

procedure TRbButton.EventMouseLeave;
begin
  inherited;
  if not FDown then begin
    Exclude(FDrawStates, dsMouseOver);  
    FOnFade := DoBlendLess;
    UpdateTimer;
  end;
end;

procedure TRbButton.EventMouseDown;
begin
  inherited;
  Include(FDrawStates, dsClicking);
  Include(FDrawStates, dsMouseOver);
  FOnFade := DoBlendMore;
  UpdateTimer;
end;

procedure TRbButton.EventMouseUp;
begin
  inherited;
  if (dsClicking in FDrawStates) and not FDown then
    Exclude(FDrawStates, dsClicking);
  if dsMouseOver in FDrawStates then
    FOnFade := DoBlendMore;
  UpdateTimer;
end;

procedure TRbButton.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
  FGlyph.Transparent := true;
  Invalidate;
end;

procedure TRbButton.SetSpacing(const Value: integer);
begin
  if Value < 0 then
    FSpacing := 0
  else
    FSpacing := Value;
end;

procedure TRbButton.SetLayout(const Value: TButtonLayout);
begin
  if Value = FLayout then Exit;
  FLayout := Value;
  Invalidate;
end;

procedure TRbButton.SetFadeSpeed(const Value: TFadeSpeed);
begin
  FFadeSpeed := Value;
end;

procedure TRbButton.SetHotTrack(const Value: boolean);
begin
  if FHotTrack <> Value then begin
    FHotTrack := Value;
    Invalidate;
  end;
end;


procedure TRbButton.SetFocusRect(const Value: boolean);
begin
  if FShowFocusRect <> Value then begin
    FShowFocusRect := Value;
    Invalidate;
  end;
end;

procedure TRbButton.UpdateGradients;
var
  R : TRect;
begin
  FGrBitmap.Width := Width;
  FGrBitmap.Height := Height;
  R := FGrBitmap.Canvas.ClipRect;
  DoBitmapGradient(FGrBitmap, R, Colors.DefaultFrom, Colors.DefaultTo, GradientType, 0);

  FGrMouseOver.Width := Width;
  FGrMouseOver.Height := Height;
  DoBitmapGradient(FGrMouseOver, R, Colors.OverFrom, Colors.OverTo, GradientType, 0);

  FGrClicked.Width := Width;
  FGrClicked.Height := Height;
  DoBitmapGradient(FGrClicked, R, Colors.ClickedFrom, Colors.ClickedTo, GradientType, 0);
  Invalidate;
end;

procedure TRbButton.SetDefault(const Value: boolean);
begin
  if FDefault <> Value then begin
    FDefault := Value;
      with GetParentForm(Self) do
        Perform(CM_FOCUSCHANGED, 0, LongInt(ActiveControl));
  end;
end;

procedure TRbButton.CMDialogKey(var Message: TCMDialogKey);
begin
  inherited;
  with Message do
    if (((CharCode = VK_RETURN) and (Focused or FDefault))
      or ((CharCode = VK_ESCAPE) and FCancel) and (KeyDataToShiftState(KeyData) = []))
      and CanFocus then
    begin
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TRbButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Shift = []) and (Key = VK_SPACE) then Click;
  inherited;
end;

procedure TRbButton.Click;
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  if Form <> nil then
    Form.ModalResult := ModalResult;
  Down := (GroupIndex > 0) and not Down;
  inherited Click;
end;

procedure TRbButton.EventFocusChanged;
begin
  inherited;
  Invalidate;
end;

procedure TRbButton.SetAllowAllUp(const Value: boolean);
begin
  FAllowAllUp := Value;
end;

procedure TRbButton.SetDown(const Value: boolean);
begin
  if (GroupIndex > 0) then begin
    if not Value and not CanbeUp then Exit;
    FDown := Value;
    if FDown then begin
      DeactivateSiblings;
      Include(FDrawStates, dsMouseOver);
      Include(FDrawStates, dsClicking);
      FOnFade := DoBlendMore;
      UpdateTimer;
    end else begin
      Exclude(FDrawStates, dsClicking);
      FOnFade := DoBlendLess;
      UpdateTimer;
    end;
  end;
end;

procedure TRbButton.SetGroupIndex(const Value: integer);
begin
  FGroupIndex := Value;
end;

procedure TRbButton.DeActivateSiblings;
var
  i : integer;
begin
  if (GroupIndex > 0) and (Parent <> nil) then
    with Parent do begin
      for i := 0 to ControlCount - 1 do
        if (Controls[i] <> Self) and (Controls[i] is TRbButton) and (TRbButton(Controls[i]).GroupIndex = GroupIndex) then
          TRbButton(Controls[i]).SetDown(false);
    end;
end;

function TRbButton.CanBeUp: boolean;
var
  i : integer;
begin
  Result := false;
  if AllowAllUp then begin
    Result := true;
    Exit;
  end;
  if (GroupIndex > 0) and (Parent <> nil) then
    with Parent do begin
      for i := 0 to ControlCount - 1 do
        if (Controls[i] <> Self) and (Controls[i] is TRbButton) and (TRbButton(Controls[i]).GroupIndex = GroupIndex) then
          if TRbButton(Controls[i]).Down then begin
            Result := true;
            Exit;
          end;
    end;
end;

procedure TRbButton.SetGradientType(const Value: TGradientType);
begin
  if FGradientType <> Value then begin
    FGradientType := Value;
    UpdateGradients;
  end;
end;

end.
