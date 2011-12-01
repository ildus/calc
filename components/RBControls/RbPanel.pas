{-----------------------------------------------------------------------------
 Unit Name: RbPanel
 Purpose: Antialiased rounded rect panel w/ few more properties

 Author/Copyright: Nathanaël VERON - r.b.a.g@free.fr - http://r.b.a.g.free.fr

        Feel free to modify and improve source code, mail me (r.b.a.g@free.fr)
        if you make any big fix or improvement that can be included in the next
        versions. If you use the RbControls in your project please
        mention it or make a link to my website.


       ===============================================
        /*   08/09/2003    */
        Bug correction when drawing non antialiased panel

        /*   05/10/2003    */
        Bug correction when drawing as a groupbox

        /*   13/10/2003    */
        Bug correction on AdjustClientRect;

       /*   13/11/2003    */
       Modifications for D5 compatibility
       thx to Pierre Castelain -> www.micropage.fr.st

       /*   27/12/2003    */
       Gradient, Default from and DefaultTo properties added

       /*   29/12/2003    */
       Bug correction for client rect adjustement

-----------------------------------------------------------------------------}

unit RbPanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, ExtCtrls,
  RbDrawCore, Forms, TypInfo, Math;

type

  TRbPanel = class(TRbCustomControl)
  private
    FCornerWidth : integer;
    FBorderWidth : integer;
    FBorderColor : TColor;
    FOuterColor : TColor;
    FBFrame : TBitmap;
    FCaptionPosition : TRbCaptionPos;
    FTextShadowColor : TColor;
    FAntiAliased : boolean;
    FGradient: Boolean;
    FDefaultFrom : TColor;
    FDefaultTo : TColor;
    FGradientType: TGradientType;
    procedure UpdateFrame;
    procedure SetCornerWidth(const Value: integer);
    procedure SetBorderWidth(const Value: integer);
    procedure SetBorderColor(const Value: TColor);
    procedure SetOuterColor(const Value: TColor);
    procedure SeTRbCaptionPosition(const Value: TRbCaptionPos);
    procedure SetTextShadowColor(const Value: TColor);
    procedure SetAntialiased(const Value: boolean);
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure SetDefaultFrom(const Value: TColor);
    procedure SetDefaultTo(const Value: TColor);
    procedure SetGradient(const Value: Boolean);
    procedure SetGradientType(const Value: TGradientType);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure Paint; override;
    procedure EventResized; override;
    procedure Loaded; override;
    procedure UpdateGradients; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Caption;
    property CaptionPosition : TRbCaptionPos read FCaptionPosition write SeTRbCaptionPosition;
    property CornerWidth: integer read FCornerWidth write SetCornerWidth;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property OuterColor : TColor read FOuterColor write SetOuterColor;
    property TextShadowColor : TColor read FTextShadowColor write SetTextShadowColor;
    property Antialiased : boolean read FAntiAliased write SetAntialiased;
    property Gradient : Boolean read FGradient write SetGradient;
    property DefaultFrom: TColor read FDefaultFrom write SetDefaultFrom;
    property DefaultTo: TColor read FDefaultTo write SetDefaultTo;
    property GradientType: TGradientType read FGradientType write SetGradientType;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RbControls', [TRbPanel]);
end;

{---------------------------------------------
              TRbPanel
---------------------------------------------}

constructor TRbPanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csOpaque, csSetCaption, csDoubleClicks, csReplicatable];
  FBFrame := nil;
  FCornerWidth := 10;
  FBorderWidth := 2;
  FBorderColor := clGray;
  FOuterColor := clBtnFace;

  FGradient := False;
  FGradientType := gtVertical;
  FDefaultFrom := clWhite;
  FDefaultTo := $00E3DFDF;

  Font.Color := $00CE0000;
  FBFrame := TBitmap.Create;
  FBFrame.PixelFormat := pf24bit;
  FBFrame.Width := Width;
  FBFrame.Height := Height;
  FCaptionPosition := cpTopLeft;
  FTextShadowColor := clWhite;

  Color := $00E3DFDF;

  FAntialiased := true;
  Width := 185;
  Height := 105;
end;

procedure TRbPanel.UpdateFrame;
var
  Source : TBitmap;
  BWidth : integer;
  Sampling: integer;
  Rgn: HRGN;
begin
  if (csReading in ComponentState) or (FBFrame = nil) then Exit;

  if not Antialiased then begin
      Source := FBFrame;
      Sampling := 1;
  end else begin
    Source := TBitmap.Create;
    Sampling := 3;
  end;

  try
    Source.PixelFormat := pf24bit;

    Source.Width :=   FBFrame.Width * Sampling;
    Source.Height := FBFrame.Height * Sampling;

    BWidth := BorderWidth * Sampling - 1;

    Source.Canvas.Brush.Color := OuterColor;
    Source.Canvas.FillRect(Source.Canvas.ClipRect);


    //Draw Border Line
    Source.Canvas.Pen.Width := BWidth;
    Source.Canvas.Pen.Color := BorderColor;
    Source.Canvas.Brush.Color := Color;

    BWidth := BWidth div 2;

    if FGradient then begin
      Source.Canvas.Brush.Style := bsClear;
      if FCaptionPosition = cpGroupBox then
        Rgn := CreateRoundRectRgn(BWidth, BWidth + Canvas.TextHeight(Caption) * Sampling div 2, Source.Width - BWidth, Source.Height - BWidth, CornerWidth * Sampling, CornerWidth * Sampling)
      else
        Rgn := CreateRoundRectRgn(BWidth, BWidth, Source.Width - BWidth, Source.Height - BWidth, CornerWidth * Sampling, CornerWidth * Sampling);
      DoBitmapGradient(Source,Source.Canvas.ClipRect, DefaultFrom, DefaultTo, FGradientType, Rgn);
    end;

    //Draw the group round rect
    if FCaptionPosition = cpGroupBox then
      Source.Canvas.RoundRect(BWidth, BWidth + Canvas.TextHeight(Caption) * Sampling div 2, Source.Width - BWidth, Source.Height - BWidth, CornerWidth * Sampling, CornerWidth * Sampling)
    else
      Source.Canvas.RoundRect(BWidth, BWidth, Source.Width - BWidth, Source.Height - BWidth, CornerWidth * Sampling, CornerWidth * Sampling);

    //Antialias the rect
    if Antialiased then
      AntialiasShapeBitmap(Source, FBFrame, Sampling, CornerWidth + 20, Color);
  finally
    if Antialiased then
      Source.Free;
  end;

  Invalidate;
end;

procedure TRbPanel.Paint;
var
  TxtRect : TRect;
  Flags : integer;
begin
  inherited;
  Flags := 0;
  Canvas.Brush.Color := OuterColor;
  Canvas.FillRect(Canvas.ClipRect);
  BitBlt(Canvas.Handle, 0, 0, Width, Height, FBFrame.Canvas.Handle, 0, 0, SRCCOPY);

  Canvas.Font.Assign(Font);
  if CaptionPosition <> cpGroupBox then
    SetBkMode(Canvas.Handle, TRANSPARENT);

  TxtRect := Rect((CornerWidth + BorderWidth) div 2, BorderWidth, Width - (CornerWidth + BorderWidth) div 2, Height - BorderWidth);

  //Set text Flags, no multiline for the moment, sorry
  case FCaptionPosition of
    cpTopLeft     : Flags := DT_LEFT or DT_TOP;
    cpTopCenter   : Flags := DT_CENTER or DT_TOP;
    cpTopRight    : Flags := DT_RIGHT or DT_TOP;
    cpMiddleLeft  : begin
                      Flags := DT_LEFT or DT_VCENTER;
                      Dec(TxtRect.Left, (CornerWidth - BorderWidth) div 2);
                    end;
    cpMiddleCenter: Flags := DT_CENTER or DT_VCENTER;
    cpMiddleRight : begin
                      Flags := DT_RIGHT or DT_VCENTER;
                      Inc(TxtRect.Right, (CornerWidth - BorderWidth) div 2);
                    end;
    cpBottomLeft  : Flags := DT_LEFT or DT_BOTTOM;
    cpBottomCenter: Flags := DT_CENTER or DT_BOTTOM;
    cpBottomRight : Flags := DT_RIGHT or DT_BOTTOM;
    cpGroupBox: begin
                  Flags := DT_LEFT or DT_TOP;
                  Canvas.Brush.Color := Color;
                  Dec(TxtRect.Top, BorderWidth);
                  if CornerWidth + BorderWidth < 2 then
                    Inc(TxtRect.Left, 5);
                end;
  end;

  Flags := Flags or DT_SINGLELINE or DT_END_ELLIPSIS;

  if ShowCaption then
    if CaptionPosition = cpGroupBox then begin
      //DoDrawText(Canvas, Caption, Font, Enabled, false, TxtRect, Flags, TextShadow, TextShadowColor);
      Canvas.Brush.Color := OuterColor;
      Canvas.FillRect(Rect(0, 0, TxtRect.Right, TxtRect.Top + Canvas.TextHeight(Caption) div 2));
      Canvas.FillRect(Rect(TxtRect.Left, TxtRect.Top + Canvas.TextHeight(Caption) div 2, TxtRect.Left + Canvas.TextWidth(Caption), (TxtRect.Top + Canvas.TextHeight(Caption) div 2) + Min(BorderWidth, Canvas.TextHeight(Caption) div 2)));
      SetBkMode(Canvas.Handle, TRANSPARENT);
      DoDrawText(Canvas, Caption, Font, Enabled, false, TxtRect, Flags, TextShadow, TextShadowColor);
    end else
      DoDrawText(Canvas, Caption, Font, Enabled, false, TxtRect, Flags, TextShadow, TextShadowColor);
end;

destructor TRbPanel.Destroy;
begin
  FBFrame.Free;
  inherited;
end;

procedure TRbPanel.EventResized;
begin
  inherited;
  FBFrame.Width := Width;
  FBFrame.Height := Height;
  UpdateFrame;
end;

procedure TRbPanel.SetCornerWidth(const Value: integer);
begin
  if (Value >= 0) and (FCornerWidth <> Value) then begin
    FCornerWidth := Value;
    UpdateFrame;
  end;
end;

procedure TRbPanel.SetBorderWidth(const Value: integer);
begin
  if (Value > 0) and (FBorderWidth <> Value) then begin
    FBorderWidth := Value;
    RequestAlign;
    UpdateFrame;
  end;
end;

procedure TRbPanel.SetBorderColor(const Value: TColor);
begin
 if FBorderColor <> Value then begin
   FBorderColor := Value;
   UpdateFrame;
 end;
end;

procedure TRbPanel.SeTRbCaptionPosition(const Value: TRbCaptionPos);
var
  Rect : TRect;
begin
 if FCaptionPosition <> Value then
   if (Value = cpGroupBox) or (FCaptionPosition = cpGroupBox) then begin
     FCaptionPosition := Value;
     AlignControls(Self, Rect);
     UpdateFrame;
   end else begin
     FCaptionPosition := Value;
     AlignControls(Self, Rect);
     Invalidate;
   end;
end;

procedure TRbPanel.SetTextShadowColor(const Value: TColor);
begin
  if FTextShadowColor <> Value  then begin
    FTextShadowColor := Value;
    Invalidate;
  end;
end;

procedure TRbPanel.SetAntialiased(const Value: boolean);
begin
  if FAntiAliased <> Value then begin
    FAntiAliased := Value;
    if FAntialiased then FGradient := False;
    UpdateFrame;
  end;
end;

procedure TRbPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WindowClass.style := Params.WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TRbPanel.Loaded;
begin
  inherited;
  UpdateFrame;
end;

procedure TRbPanel.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  if CaptionPosition = cpGroupBox then begin
    InflateRect(Rect,  -BorderWidth - 1, -Canvas.TextHeight(Caption) div 2 - 2);
    OffsetRect(Rect, 0, Canvas.TextHeight(Caption) div 2 - 1);
  end else
    InflateRect(Rect, -BorderWidth - 1, -BorderWidth - 1);
end;

procedure TRbPanel.SetOuterColor(const Value: TColor);
begin
  if FOuterColor <> Value then begin
    FOuterColor := Value;
    UpdateFrame;
  end;  
end;


procedure TRbPanel.CMColorChanged(var Message: TMessage);
begin
  inherited;
  UpdateFrame;
end;

procedure TRbPanel.UpdateGradients;
begin
  UpdateFrame;
end;

procedure TRbPanel.CMParentColorChanged(var Message: TMessage);
begin
  inherited;
  if (Parent <> nil) and ParentColor then
      OuterColor := TPanel(Parent).Color;
end;

procedure TRbPanel.SetDefaultFrom(const Value: TColor);
begin
  if FDefaultFrom <> Value then begin
    FDefaultFrom := Value;
    Invalidate;
  end;
end;

procedure TRbPanel.SetDefaultTo(const Value: TColor);
begin
  if FDefaultTo <> Value then begin
    FDefaultTo := Value;
    Invalidate;
  end;
end;

procedure TRbPanel.SetGradient(const Value: Boolean);
begin
  if FGradient <> Value then
    if not FAntialiased then begin
      FGradient := Value;
      UpdateFrame;
    end else begin
      FGradient := False;
      UpdateFrame;
    end;
end;

procedure TRbPanel.SetGradientType(const Value: TGradientType);
begin
  if FGradientType <> Value then begin
    FGradientType := Value;
    UpdateFrame;
  end;
end;

end.
