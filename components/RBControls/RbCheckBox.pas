{-----------------------------------------------------------------------------
 Unit Name: RbCheckBox
 Purpose: Fade in/out CheckBox button

 Author/Copyright: Nathanaël VERON - r.b.a.g@free.fr - http://r.b.a.g.free.fr


        Feel free to modify and improve source code, mail me (r.b.a.g@free.fr)
        if you make any big fix or improvement that can be included in the next
        versions. If you use the RbControls in your project please
        mention it or make a link to my website.


       ===============================================
       /*   13/11/2003    */
       Modifications for D5 compatibility
       thx to Pierre Castelain -> www.micropage.fr.st
-----------------------------------------------------------------------------}

unit RbCheckBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, ExtCtrls, RbDrawCore,
  Buttons;

type
  TRbCheckBox = class(TRbCustomControl)
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
    FGradientBorder: boolean;
    FOnClick : TNotifyEvent;
    procedure SetBorderLines(const Value: TBorderLines);
    procedure SetBorderLinesColor(const Value: TColor);
    procedure SetChecked(const Value: boolean);
    procedure SetFadeSpeed(const Value: TFadeSpeed);
    procedure SetHotTrack(const Value: boolean);
    procedure SetSpacing(const Value: integer);
    procedure SetFocusRect(const Value: boolean);
    procedure SetCheckColor(const Value: TColor);
    procedure SelfOnClick(Sender: TObject);
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
    property GradientBorder: boolean read FGradientBorder write FGradientBorder;
    property OnClick : TNotifyEvent read FOnClick write FOnClick;
  end;

procedure Register;

implementation

{$R RbCheckBox.res}

const
  CheckSize = 13;
  
procedure Register;
begin
  RegisterComponents('RbControls', [TRbCheckBox]);
end;

{ TRbCheckBox }

constructor TRbCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  Height := 17;
  Width := 130;

  FColors := TRbControlColors.Create(Self);

  FGrBitmap := TBitmap.Create;
  FGrBitmap.PixelFormat := pf24bit;
  FGrBitmap.Width := CheckSize;
  FGrBitmap.Height := CheckSize;

  FGrMouseOver := TBitmap.Create;
  FGrMouseOver.PixelFormat := pf24bit;
  FGrMouseOver.Width := CheckSize;
  FGrMouseOver.Height := CheckSize;

  FGrClicked := TBitmap.Create;
  FGrClicked.PixelFormat := pf24bit;
  FGrClicked.Width := CheckSize;
  FGrClicked.Height := CheckSize;

  SetFadeSpeed(fsMedium);
  FClickedBlendPercent := 0;
  FOverBlendPercent := 0;
  FShowFocusRect := true;
  FDrawStates := [];
  FBorderLines := [];
  FSpacing := 3;
  FCheckColor := clGreen;
  FBorderLinesColor := clGray;
  FGradientBorder := true;
  inherited OnClick := SelfOnClick;
  FOnClick := nil;
  UpdateGradients;  
end;

destructor TRbCheckBox.Destroy;
begin
  FGrBitmap.Free;
  FGrMouseOver.Free;
  FGrClicked.free;
  FColors.Free;
  inherited;
end;

procedure TRbCheckBox.EventMouseDown;
begin
  inherited;
  Include(FDrawStates, dsClicking);
  FonFade := DoBlendMore;
  UpdateTimer;
end;

procedure TRbCheckBox.EventMouseEnter;
begin
  inherited;
  Include(FDrawStates, dsMouseOver);
  FonFade := DoBlendMore;
  UpdateTimer;
end;

procedure TRbCheckBox.EventMouseLeave;
begin
  inherited;
  Exclude(FDrawStates, dsMouseOver);
  Exclude(FDrawStates, dsClicking);
  FonFade := DoBlendLess;
  UpdateTimer;
end;

procedure TRbCheckBox.EventMouseUp;
begin
  inherited;
  if dsClicking in FDrawStates then begin
    Exclude(FDrawStates, dsClicking);
    FOnFade := DoBlendMore;
    UpdateTimer;
  end;
end;

procedure TRbCheckBox.EventResized;
begin
  inherited;
  Invalidate;
end;

procedure TRbCheckBox.EventFocusChanged;
begin
  inherited;
  Invalidate;
end;

procedure TRbCheckBox.Paint;
var
  R : TRect;
  Flags: integer;
  FinalBitmap: TBitmap;
  CheckBitmap : TBitmap;
  Oft : integer;
begin
  inherited;
  FinalBitmap := TBitmap.Create;
  CheckBitmap := TBitmap.Create;
  try
    FinalBitmap.PixelFormat := pf24bit;
    FinalBitmap.Width := Width;
    FinalBitmap.Height := Height;

    R := GetClientRect;
    FinalBitmap.Canvas.Brush.Color := Color;
    FinalBitmap.Canvas.FillRect(R);

    R.Right := R.Left + CheckSize;
    R.Bottom := R.Top + CheckSize;
    OffsetRect(R, 1, (Height - CheckSize) div 4);


    //Blend the base gradient and the MouseOver Gradient
    BlendBitmaps(FinalBitmap, FGrBitmap, FGrMouseOver, FOverBlendPercent, R, 0);

    if GradientBorder then
      Oft := 2
    else
      Oft := 1;

    //Blend the previous gradient and the Selection Gradient
    if FClickedBlendPercent > 0 then begin
      InflateRect(R, -Oft, -Oft);
      BlendBitmaps(FinalBitmap, FinalBitmap, FGrClicked, FClickedBlendPercent, R, 10);
      InflateRect(R, Oft, Oft);
    end;

    //Draw the tick
    if FChecked then begin
      CheckBitmap.LoadFromResourceName(hInstance, 'CHECK');
      CheckBitmap.PixelFormat := pf24bit;
      CheckBitmap.Transparent := true;

      if Enabled then
        ColorizeBitmap(CheckBitmap, FCheckColor)
      else
        ColorizeBitmap(CheckBitmap, clGray);

        FinalBitmap.Canvas.Draw(R.Left + 2, R.Top + 2, CheckBitmap);
      end;
      
    BitBlt(Canvas.Handle, R.Left, R.Top, width, Height, FinalBitmap.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    FinalBitmap.Free;
    CheckBitmap.Free;
  end;
  R := GetClientRect;
  
  SetBkMode(Canvas.Handle, windows.TRANSPARENT);
  SetTextFlags(taLeftJustify, false, Flags);
  R.Left := R.Left + CheckSize + FSpacing + 3;
  Canvas.Font.Assign(Font);

  if FHotTrack and (dsMouseOver in FDrawStates) then Canvas.Font.Color := FColors.HotTrack;
  if ShowCaption then
    DoDrawText(Canvas, Caption, Canvas.Font, Enabled, false, R, Flags, TextShadow, Colors.TextShadow);

  R := GetClientRect;
  //Draw border lines
  Canvas.Pen.Color := BorderLinesColor;
  if blTop in BorderLines then
  begin
    Canvas.MoveTo(R.Left, R.Top);
    Canvas.LineTo(R.Right, R.Top);
  end;

  if blBottom in BorderLines then
  begin
    Canvas.MoveTo(R.Left, R.Bottom - 1);
    Canvas.LineTo(R.Right, R.Bottom - 1);
  end;

  if blLeft in BorderLines then
  begin
    Canvas.MoveTo(R.Left, R.Top);
    Canvas.LineTo(R.Left, R.Bottom);
  end;

  if blRight in BorderLines then
  begin
    Canvas.MoveTo(R.Right - 1, R.Top);
    Canvas.LineTo(R.Right - 1, R.Bottom);
  end;

  if Focused and FShowFocusRect then DrawFocusRect(Canvas.Handle, R);
end;

procedure TRbCheckBox.SetBorderLines(const Value: TBorderLines);
begin
  if FBorderLines <> Value then
  begin
    FBorderLines := Value;
    Invalidate;
  end;
end;

procedure TRbCheckBox.SetBorderLinesColor(const Value: TColor);
begin
  if FBorderLinesColor <> Value then
  begin
    FBorderLinesColor := Value;
    Invalidate;
  end;
end;

procedure TRbCheckBox.SetChecked(const Value: boolean);
begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    Invalidate;
  end;
end;

procedure TRbCheckBox.SetFadeSpeed(const Value: TFadeSpeed);
begin
  FFadeSpeed := Value;
end;

procedure TRbCheckBox.SetFocusRect(const Value: boolean);
begin
  if FShowFocusRect <> Value then
  begin
    FShowFocusRect := Value;
    Invalidate;
  end;
end;

procedure TRbCheckBox.SetHotTrack(const Value: boolean);
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    Invalidate;
  end;
end;

procedure TRbCheckBox.SetSpacing(const Value: integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TRbCheckBox.UpdateGradients;
begin
  DoBitmapGradient(FGrBitmap, FGrBitmap.Canvas.ClipRect, Colors.DefaultFrom, Colors.DefaultTo, gtFromTopLeft, 0);
  FGrBitmap.Canvas.Brush.Style := bsClear;
  FGrBitmap.Canvas.Pen.Color := Colors.BorderColor;
  FGrBitmap.Canvas.Rectangle(0, 0, FGrBitmap.Width, FGrBitmap.Height);

  DoBitmapGradient(FGrMouseOver, FGrMouseOver.Canvas.ClipRect, Colors.OverFrom, Colors.OverTo, gtFromTopLeft, 0);
  FGrMouseOver.Canvas.Brush.Style := bsClear;
  FGrMouseOver.Canvas.Pen.Color := Colors.BorderColor;
  FGrMouseOver.Canvas.Rectangle(0, 0, FGrMouseOver.Width, FGrMouseOver.Height);

  DoBitmapGradient(FGrClicked, FGrClicked.Canvas.ClipRect, Colors.ClickedFrom, Colors.ClickedTo, gtFromTopLeft, 0);
  Invalidate;
end;

procedure TRbCheckBox.SetCheckColor(const Value: TColor);
begin
  if FCheckColor <> Value then begin
    FCheckColor := Value;
    Invalidate;
  end;  
end;

procedure TRbCheckBox.SelfOnClick(Sender: TObject);
begin
  SetChecked(not FChecked);
  if Assigned(FOnClick) then FOnClick(Self);
end;

end.
