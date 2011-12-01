{-----------------------------------------------------------------------------
 Unit Name: RbProgressBar
 Purpose: gradient Progress bar

 Author/Copyright: Nathanaël VERON - r.b.a.g@free.fr - http://r.b.a.g.free.fr


        Feel free to modify and improve source code, mail me (r.b.a.g@free.fr)
        if you make any big fix or improvement that can be included in the next
        versions. If you use the RbControls in your project please
        mention it or make a link to my website.

       ===============================================
       /*   13/11/2003    */
       Modifications for D5 compatibility
       thx to Pierre Castelain -> www.micropage.fr.st

       /*   10/01/2004    */
       Bug correction when setting negative min value

-----------------------------------------------------------------------------}
unit RbProgressBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, RbDrawCore,
  Buttons, Forms, ComCtrls;

type
  TRbProgressBar = class(TRbCustomControl)
  private
    FGrBitmap: TBitmap;
    FDefaultFrom : TColor;
    FDefaultTo : TColor;
    FMax : integer;
    FMin : integer;
    FPosition: integer;
    FStep : integer;
    FBorderLines: TBorderLines;
    FBorderColor : TColor;
    FGradientType : TGradientType;
    FOrientation : TProgressBarOrientation;
    FShowText : boolean;
    FPercent : integer;
    FBorderWidth: integer;
    procedure SetBorderLines(const Value: TBorderLines);
    procedure SetBorderColor(const Value: TColor);
    procedure SetDefaultFrom(const Value: TColor);
    procedure SetDefaultTo(const Value: TColor);
    procedure SetGradientType(const Value: TGradientType);
    procedure SetMax(const Value: integer);
    procedure SetMin(const Value: integer);
    procedure SetOrientation(const Value: TProgressBarOrientation);
    procedure SetPosition(const Value: integer);
    procedure SetShowText(const Value: boolean);
    procedure SetStep(const Value: integer);
    procedure SetBorderWidth(const Value: integer);
  protected
    procedure Paint; override;
    procedure UpdateGradients; override;
    procedure EventResized; override;
  public
    property Percent: integer read FPercent;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure StepIt;
  published
    property Caption;
    property DefaultFrom: TColor read FDefaultFrom write SetDefaultFrom;
    property DefaultTo: TColor read FDefaultTo write SetDefaultTo;
    property Max : integer read FMax write SetMax;
    property Min : integer read FMin write SetMin;
    property Position : integer read FPosition write SetPosition;
    property Step : integer read FStep write SetStep;
    property BorderLines : TBorderLines read FBorderLines write SetBorderLines;
    property BorderColor : TColor read FBorderColor write SetBorderColor;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth;
    property GradientType : TGradientType read FGradientType write SetGradientType;
    property Orientation : TProgressBarOrientation read FOrientation write SetOrientation;
    property ShowText : boolean read FShowText write SetShowText;
  end;

  procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RbControls', [TRbProgressBar]);
end;

{---------------------------------------------
                TRbProgressBar
---------------------------------------------}

constructor TRbProgressBar.Create(AOwner: TComponent);
begin
  inherited;
    FGrBitmap := TBitmap.Create;
    FGrBitmap.PixelFormat := pf24bit;
    ControlStyle := ControlStyle - [csSetCaption];
    FDefaultFrom := $00B6977E;
    FDefaultTo := $00E0D2C9;
    FMax := 100;
    FMin := 0;
    FPosition := 0;
    FStep := 1;
    FBorderLines := [blTop, blBottom, blLeft, blRight];
    FBorderColor := clGray;
    FGradientType := gtVertical;
    FOrientation := pbHorizontal;
    FShowText := true;
    TextShadow := false;
    FPercent := 0;
    FBorderWidth := 1;
    Caption := '';
    Width := 150;
    Height := 16;
end;

destructor TRbProgressBar.Destroy;
begin
  FGrBitmap.Free;
  inherited;
end;

procedure TRbProgressBar.EventResized;
begin
  inherited;
  UpdateGradients;
end;

procedure TRbProgressBar.Paint;
var
  R: TRect;
  BW : integer;
  Txt: string;
begin
  inherited;

  R := Canvas.ClipRect;
  //Calculate the extend of the rect
  if Orientation = pbHorizontal then
    R.Right := (R.Right - R.Left) * Percent div 100
  else
    R.Top := (R.Bottom - R.Top) * (100 - Percent) div 100;

  if BorderLines = [] then
    BW := 0
  else
    BW := -1;

  InflateRect(R, BW - BorderWidth, BW - BorderWidth);

  if Percent > 0 then
    Canvas.CopyRect(R, FGrBitmap.Canvas, R);

  //Draw Percent
  R := Canvas.ClipRect;
  if ShowText or ShowCaption then begin
      SetBkMode(Canvas.Handle, TRANSPARENT);
      Canvas.Font.Assign(Font);
      if ShowText then
        Txt := IntToStr(Percent) + '%';

      if (Caption <> '') and ShowCaption then
        if ShowText then
          Txt := Caption + ' ' + Txt
        else
          Txt := Caption;
        
      DoDrawText(Canvas, Txt, Font, true, false, R, DT_CENTER or DT_VCENTER or DT_SINGLELINE, TextShadow, clWhite);
  end;

  //Draw border lines
  Canvas.Pen.Color := BorderColor;
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
end;

procedure TRbProgressBar.SetBorderLines(const Value: TBorderLines);
begin
  if FBorderLines <> Value then begin
    FBorderLines := Value;
    Invalidate;
  end;
end;

procedure TRbProgressBar.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then begin
    FBorderColor := Value;
    Invalidate;
  end;
end;

procedure TRbProgressBar.SetBorderWidth(const Value: integer);
begin
  if (FBorderWidth <> Value) and (Value >= 0) and (Value < Height div 2) then begin
    FBorderWidth := Value;
    Invalidate;
  end;
end;

procedure TRbProgressBar.SetDefaultFrom(const Value: TColor);
begin
  if FDefaultFrom <> Value then begin
    FDefaultFrom := Value;
    UpdateGradients;
  end;
end;

procedure TRbProgressBar.SetDefaultTo(const Value: TColor);
begin
  if FDefaultTo <> Value then begin
    FDefaultTo := Value;
    UpdateGradients;
  end;
end;

procedure TRbProgressBar.SetGradientType(const Value: TGradientType);
begin
  if FGradientType <> Value then begin
    FGradientType := Value;
    UpdateGradients;
  end;
end;

procedure TRbProgressBar.SetMax(const Value: integer);
begin
  if ((FMax <> Value) and (Value > FMin)) or (csLoading in ComponentState) then begin
    FMax := Value;
    if Position > Max then Position := Max;
    SetPosition(Position);
    Invalidate;
  end;
end;

procedure TRbProgressBar.SetMin(const Value: integer);
begin
  if ((FMin <> Value) and (Value < FMax)) or (csLoading in ComponentState) then begin
    FMin := Value;
    if Position < Min then Position := Min;
    SetPosition(Position);
    Invalidate;
  end;
end;

procedure TRbProgressBar.SetOrientation( const Value: TProgressBarOrientation);
begin
  if FOrientation <> Value then begin
    FOrientation := Value;
    Invalidate;
  end;
end;

procedure TRbProgressBar.SetPosition(const Value: integer);
begin
  FPosition := Value;
  if FPosition < Min then Position := Min;
  if FPosition > Max then Position := Max;

  if Min <> Max then
    FPercent :=  Round(Abs((Position - Min) / (Max - Min)) * 100)
  else
    FPercent := 0;
    
  Invalidate;
end;

procedure TRbProgressBar.SetShowText(const Value: boolean);
begin
  if FShowText <> Value then begin
    FShowText := Value;
    Invalidate;
  end;
end;

procedure TRbProgressBar.SetStep(const Value: integer);
begin
  FStep := Value;
end;

procedure TRbProgressBar.StepIt;
begin
  Position := Position + Step;
end;

procedure TRbProgressBar.UpdateGradients;
begin
  FGrBitmap.Width := Width;
  FGrBitmap.Height := Height;
  DoBitmapGradient(FGrBitmap, FGrBitmap.Canvas.ClipRect, DefaultFrom, DefaultTo, GradientType, 0);
  Invalidate;
end;

end.
