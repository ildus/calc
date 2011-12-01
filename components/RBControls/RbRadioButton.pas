{-----------------------------------------------------------------------------
 Unit Name: RbRadioButton
 Purpose: Fade in/out Radio button

 Author/Copyright: Nathanaël VERON - r.b.a.g@free.fr - http://r.b.a.g.free.fr


        Feel free to modify and improve source code, mail me (r.b.a.g@free.fr)
        if you make any big fix or improvement that can be included in the next
        versions. If you use the RbControls in your project please
        mention it or make a link to my website.

       ===============================================

        /*   10/09/2003    */
        Correction of a bug in W98 OSR1

       /*   13/11/2003    */
       Modifications for D5 compatibility
       thx to Pierre Castelain -> www.micropage.fr.st

-----------------------------------------------------------------------------}

unit RbRadioButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, ExtCtrls, RbDrawCore,
  Buttons;

type
  TRbRadioButton = class(TRbCustomControl)
  private
    FColors: TRbControlColors;
    FGrBitmap: TBitmap;
    FGrMouseOver: TBitmap;
    FGrClicked: TBitmap;
    FBorderLines: TBorderLines;
    FBorderLinesColor : TColor;
    FHotTrack : boolean;
    FSpacing : integer;
    FChecked: boolean;
    FShowFocusRect: boolean;
    FCheckColor: TColor;
    FRadioType: TRadioSize;
    FRadioSize: integer;
    FCheckOffset: integer;
    procedure SetBorderLines(const Value: TBorderLines);
    procedure SetBorderLinesColor(const Value: TColor);
    procedure SetChecked(const Value: boolean);
    procedure SetFadeSpeed(const Value: TFadeSpeed);
    procedure SetHotTrack(const Value: boolean);
    procedure SetSpacing(const Value: integer);
    procedure SetFocusRect(const Value: boolean);
    procedure SetCheckColor(const Value: TColor);
    procedure DeActivateSiblings;
    procedure DrawAntialiasedCircle(ABitmap: TBitmap);
    procedure SetRadioType(const Value: TRadioSize);
  protected
    procedure Paint; override;

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
  published
    property Caption;  
    property BorderLines: TBorderLines read FBorderLines write SetBorderLines default [];
    property BorderLinesColor: TColor read FBorderLinesColor write SetBorderLinesColor;
    property HotTrack: boolean read FHotTrack write SetHotTrack;
    property FadeSpeed: TFadeSpeed read FFadeSpeed write SetFadeSpeed;
    property Colors: TRbControlColors read FColors write FColors;
    property Spacing: integer read FSpacing write SetSpacing;
    property Checked: boolean read FChecked write SetChecked;
    property ShowFocusRect: boolean read FShowFocusRect write SetFocusRect;
    property CheckColor: TColor read FCheckColor write SetCheckColor;
    property RadioType: TRadioSize read FRadioType write SetRadioType;
  end;

procedure Register;

implementation

{$R RbRadioButton.res}

 
procedure Register;
begin
  RegisterComponents('RbControls', [TRbRadioButton]);
end;

{ TRbRadioButton }

constructor TRbRadioButton.Create(AOwner: TComponent);
begin
  inherited;
  Height := 17;
  Width := 130;
  FRadioSize := 13;
  FCheckOffset := 3;

  ControlStyle := ControlStyle - [csOpaque];

  FColors := TRbControlColors.Create(Self);

  FGrBitmap := TBitmap.Create;
  FGrBitmap.PixelFormat := pf24bit;
  FGrBitmap.Width := FRadioSize;
  FGrBitmap.Height := FRadioSize;

  FGrMouseOver := TBitmap.Create;
  FGrMouseOver.PixelFormat := pf24bit;
  FGrMouseOver.Width := FRadioSize;
  FGrMouseOver.Height := FRadioSize;

  FGrClicked := TBitmap.Create;
  FGrClicked.PixelFormat := pf24bit;
  FGrClicked.Width := FRadioSize;
  FGrClicked.Height := FRadioSize;

  SetFadeSpeed(fsMedium);
  FClickedBlendPercent := 0;
  FOverBlendPercent := 0;
  FShowFocusRect := true;
  FDrawStates := [];
  FBorderLines := [];
  FSpacing := 3;
  FCheckColor := clGreen;
  FBorderLinesColor := clGray;

  RadioType := rsMedium;
  UpdateGradients;
end;

destructor TRbRadioButton.Destroy;
begin
  FGrBitmap.Free;
  FGrMouseOver.Free;
  FGrClicked.free;
  FColors.Free;
  inherited;
end;

procedure TRbRadioButton.EventMouseDown;
begin
  inherited;
  Include(FDrawStates, dsClicking);
  FOnFade := DoBlendMore;
  UpdateTimer;
end;

procedure TRbRadioButton.EventMouseEnter;
begin
  inherited;
  Include(FDrawStates, dsMouseOver);
  FOnFade := DoBlendMore;
  UpdateTimer;
end;

procedure TRbRadioButton.EventMouseLeave;
begin
  inherited;
  Exclude(FDrawStates, dsMouseOver);
  Exclude(FDrawStates, dsClicking);
  FOnFAde := DoBlendLess;
  UpdateTimer;
end;

procedure TRbRadioButton.EventMouseUp;
begin
  inherited;
  if dsClicking in FDrawStates then begin
    if not FChecked then Checked := true;
    Exclude(FDrawStates, dsClicking);
    FOnFade := DoBlendMore;
    UpdateTimer;
  end;
end;

procedure TRbRadioButton.EventResized;
begin
  inherited;
  UpdateGradients;
end;

procedure TRbRadioButton.EventFocusChanged;
begin
  inherited;
  Invalidate;
end;

procedure TRbRadioButton.Paint;
var
  R : TRect;
  Flags: integer;
  FinalBitmap: TBitmap;
  CheckBitmap : TBitmap;
begin
  FinalBitmap := TBitmap.Create;
  CheckBitmap := TBitmap.Create;
  try
    FinalBitmap.PixelFormat := pf24bit;
    FinalBitmap.Width := Width;
    FinalBitmap.Height := Height;

    R := GetClientRect;
    FinalBitmap.Canvas.Brush.Color := Color;
    FinalBitmap.Canvas.FillRect(R);

    R.Right := R.Left + FRadioSize;
    R.Bottom := R.Top + FRadioSize;
    OffsetRect(R, 2, (Height - FRadioSize) div 2);

    //Blend the base gradient and the MouseOver Gradient
    BlendBitmaps(FinalBitmap, FGrBitmap, FGrMouseOver, FOverBlendPercent, R, 0);

    //Blend the previous gradient and the Selection Gradient
    if FClickedBlendPercent > 0 then
      BlendBitmaps(FinalBitmap, FGrMouseOver, FGrClicked, FClickedBlendPercent, R, 0);

    //Draw the tick
    if FChecked then begin
      CheckBitmap.LoadFromResourceName(hInstance, 'CIRC3D');
      CheckBitmap.PixelFormat := pf24Bit;
      if Enabled then
        ColorizeBitmap(CheckBitmap, FCheckColor)
      else
        ColorizeBitmap(CheckBitmap, clGray);
        
        CheckBitmap.Transparent := true;
        FinalBitmap.Canvas.Draw(R.Left + FCheckOffset, R.Top + FCheckOffset, CheckBitmap);
      end;


//    BitBlt(Canvas.Handle, R.Left, R.Top, width, Height, FinalBitmap.Canvas.Handle, 0, 0, SRCCOPY);

    R := GetClientRect;

    SetBkMode(FinalBitmap.Canvas.Handle, windows.TRANSPARENT);
    SetTextFlags(taLeftJustify, false, Flags);
    R.Left := R.Left + FRadioSize + FSpacing + 2 ;
    FinalBitmap.Canvas.Font.Assign(Font);

    if FHotTrack and (dsMouseOver in FDrawStates) then FinalBitmap.Canvas.Font.Color := FColors.HotTrack;
    if ShowCaption then
      DoDrawText(FinalBitmap.Canvas, Caption, FinalBitmap.Canvas.Font, Enabled, false, R, Flags, TextShadow, Colors.TextShadow);

    FinalBitmap.TransparentColor := Color;
    FinalBitmap.Transparent := true;

    Canvas.Draw(0, 0, FinalBitmap);
  finally
    FinalBitmap.Free;
    CheckBitmap.Free;
  end;

  R := Canvas.ClipRect;
  //Draw border lines
  Canvas.Pen.Color := BorderLinesColor;
  if blTop in BorderLines then
  begin
    Canvas.MoveTo(0, 0);
    Canvas.LineTo(R.Right, R.Top);
  end;

  if blBottom in BorderLines then
  begin
    Canvas.MoveTo(0, R.Bottom - 1);
    Canvas.LineTo(R.Right, R.Bottom - 1);
  end;

  if blLeft in BorderLines then
  begin
    Canvas.MoveTo(0, 0);
    Canvas.LineTo(R.Left, R.Bottom);
  end;

  if blRight in BorderLines then
  begin
    Canvas.MoveTo(R.Right - 1, R.Top);
    Canvas.LineTo(R.Right - 1, R.Bottom);
  end;

  if Focused and FShowFocusRect then DrawFocusRect(Canvas.Handle, R);
end;

procedure TRbRadioButton.SetBorderLines(const Value: TBorderLines);
begin
  if FBorderLines <> Value then
  begin
    FBorderLines := Value;
    Invalidate;
  end;
end;

procedure TRbRadioButton.SetBorderLinesColor(const Value: TColor);
begin
  if FBorderLinesColor <> Value then
  begin
    FBorderLinesColor := Value;
    Invalidate;
  end;
end;

procedure TRbRadioButton.SetChecked(const Value: boolean);
begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    if FChecked then DeActivateSiblings;
    Invalidate;
  end;
end;

procedure TRbRadioButton.SetFadeSpeed(const Value: TFadeSpeed);
begin
  FFadeSpeed := Value;
end;

procedure TRbRadioButton.SetFocusRect(const Value: boolean);
begin
  if FShowFocusRect <> Value then
  begin
    FShowFocusRect := Value;
    Invalidate;
  end;
end;

procedure TRbRadioButton.SetHotTrack(const Value: boolean);
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    Invalidate;
  end;
end;

procedure TRbRadioButton.SetSpacing(const Value: integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TRbRadioButton.UpdateGradients;
var
  R : HRGN;
begin
  FGrBitmap.Width := FRadioSize;
  FGrBitmap.Height := FRadioSize;

  FGrMouseOver.Width := FRadioSize;
  FGrMouseOver.Height := FRadioSize;

  FGrClicked.Width := FRadioSize;
  FGrClicked.Height := FRadioSize;

  R := CreateEllipticRgnIndirect(FGrBitmap.Canvas.ClipRect);
  try
    FGrBitmap.Canvas.Brush.Color := Color;
    FGrBitmap.Canvas.FillRect(FGrBitmap.Canvas.ClipRect);
    DoBitmapGradient(FGrBitmap, FGrBitmap.Canvas.ClipRect, Colors.DefaultFrom, Colors.DefaultTo, gtFromTopLeft, R);
    DrawAntialiasedCircle(FGrBitmap);

    FGrMouseOver.Canvas.Brush.Color := Color;
    FGrMouseOver.Canvas.FillRect(FGrMouseOver.Canvas.ClipRect);
    DoBitmapGradient(FGrMouseOver, FGrMouseOver.Canvas.ClipRect, Colors.OverFrom, Colors.OverTo, gtFromTopLeft, R);
    DrawAntialiasedCircle(FGrMouseOver);

    FGrClicked.Canvas.Brush.Color := Color;
    FGrClicked.Canvas.FillRect(FGrClicked.Canvas.ClipRect);
    DoBitmapGradient(FGrClicked, FGrClicked.Canvas.ClipRect, Colors.ClickedFrom, Colors.ClickedTo, gtFromTopLeft, R);
    DrawAntialiasedCircle(FGrClicked);
  finally
    DeleteObject(R);
  end;   
  Invalidate;
end;

procedure TRbRadioButton.SetCheckColor(const Value: TColor);
begin
  if FCheckColor <> Value then begin
    FCheckColor := Value;
    Invalidate;
  end;
end;

procedure TRbRadioButton.DeActivateSiblings;
var
  i : integer;
begin
  if Parent <> nil then
    with Parent do begin
      for i := 0 to ControlCount - 1 do
        if (Controls[i] <> Self) and (Controls[i] is TRbRadioButton) then
          TRbRadioButton(Controls[i]).SetChecked(false);
    end;
end;

procedure TRbRadioButton.DrawAntialiasedCircle(ABitmap: TBitmap);
var
  B : TBitmap;
  R : TRect;
begin
  B := TBitmap.Create;
  try
    B.PixelFormat := pf24bit;
    B.Width := ABitmap.Width * 4;
    B.Height := ABitmap.Height * 4;
    R := B.Canvas.ClipRect;
    B.Canvas.StretchDraw(R, ABitmap);
    B.Canvas.Brush.Style := bsClear;
    B.Canvas.Pen.Color := Colors.BorderColor;
    B.Canvas.Pen.Width := 4;
    InflateRect(R, -3, -3);
    B.Canvas.Ellipse(R.Left, R.Top, R.Right, R.Bottom);
    AntialiasBitmap(B, ABitmap, 4);
  finally
    B.Free;
  end;
end;

procedure TRbRadioButton.SetRadioType(const Value: TRadioSize);
begin
  if FRadioType <> Value then begin
    FRadioType := Value;
    case Value of
      rsSmall : begin
                  FRadioSize := 11;
                  FCheckOffset := 2;
                end;

      rsMedium : begin
                   FRadioSize := 13;
                   FCheckOffset := 3;
                 end;

      rsLarge : begin
                   FRadioSize := 15;
                   FCheckOffset := 4;
                 end;
    end;
    UpdateGradients;
  end;
end;



end.

