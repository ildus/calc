{-----------------------------------------------------------------------------
 Unit Name: RbSplitter
 Purpose: gradient animated splitter

 Author/Copyright: Nathanaël VERON - r.b.a.g@free.fr - http://r.b.a.g.free.fr

        Feel free to modify and improve source code, mail me (r.b.a.g@free.fr)
        if you make any big fix or improvement that can be included in the next
        versions. If you use the RbControls in your project please
        mention it or make a link to my website.


       ===============================================
       /*   04/10/2003    */
       Creation

-----------------------------------------------------------------------------}


unit RbSplitter;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, ExtCtrls, RbDrawCore,
  Buttons, Forms;

type
  TRbSplitter = class(TSplitter)
  private
    FGrBitmap: TBitmap;
    FGrMouseOver: TBitmap;
    FDrawStates: TDrawStates;
    FGradientType : TGradientType;
    FGripAlign: TGripAlign;
    FOverBlendPercent: integer;
    FColors: TRbSplitterColors;
    FFadeSpeed: TFadeSpeed;
    FShowGrip: boolean;
    FOnFade : TNotifyEvent;
    Handle : HWND;
    FRbStyleManager: TRbStyleManager;
    FDrawAll : boolean;
    FVAbout : string;
    procedure DrawPicksBt(ACanvas: TCanvas; BLeft, BTop : integer);
    procedure SetGradientType(const Value: TGradientType);
    procedure SetGripAlign(const Value: TGripAlign);
    procedure UpdateTimer;
    procedure SetFadeSpeed(const Value: TFadeSpeed);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetShowGrip(const Value: boolean);
    procedure SetRbStyleManager(const Value: TRbStyleManager);
    procedure SetDrawAll(const Value: boolean);
    procedure SetAbout(const Value: string);
  protected
    procedure Paint; override;
    procedure Loaded; override;
    procedure DoBlendMore(Sender: TObject); virtual;
    procedure DoBlendLess(Sender: TObject); virtual;
    procedure WndProc(var Msg: TMessage); override;
    procedure Resize; override;
    procedure RequestAlign; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateGradients;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  published
    property GradientType : TGradientType read FGradientType write SetGradientType;
    property GripAlign: TGripAlign read FGripAlign write SetGripAlign;
    property FadeSpeed : TFadeSpeed read FFadeSpeed write SetFadeSpeed;
    property Colors: TRbSplitterColors read FColors write FColors;
    property ShowGrip: boolean read FShowGrip write SetShowGrip;
    property RbStyleManager: TRbStyleManager read FRbStyleManager write SetRbStyleManager;
    property DrawAll : boolean read FDrawAll write SetDrawAll;
    property About : string read FVAbout write SetAbout stored False;
  end;

procedure Register;


implementation

procedure Register;
begin
  RegisterComponents('RbControls', [TRbSplitter]);
end;

{ TRbSplitter }


procedure TRbSplitter.CMMouseEnter(var Message: TMessage);
begin
  Include(FDrawStates, dsMouseOver);
  FOnFade := DoBlendMore;
  UpdateTimer;
end;

procedure TRbSplitter.CMMouseLeave(var Message: TMessage);
begin
  Exclude(FDrawStates, dsMouseOver);
  FOnFade := DoBlendLess;
  UpdateTimer;
end;

constructor TRbSplitter.Create(AOwner: TComponent);
begin
  inherited;
  FColors := TRBSplitterColors.Create(Self);
  FGrBitmap := TBitmap.Create;
  FGrBitmap.PixelFormat := pf24bit;
  FGrMouseOver := TBitmap.Create;
  FGrMouseOver.PixelFormat := pf24bit;
  FDrawStates := [];
  FOverBlendPercent := 0;
  FGradientType := gtHorizontal;
  FGripAlign := gaVertical;
  FShowGrip := true;
  FFadeSpeed := fsMedium;
  {$IFDEF VER130}
  Handle := Forms.AllocateHWnd(WndProc);
  {$ELSE}
  Handle := Classes.AllocateHWnd(WndProc);
  {$ENDIF}
  FDrawAll := true;
  FVAbout := sAboutString;
  Width := 5;
end;

destructor TRbSplitter.Destroy;
begin
  if FRbStyleManager <> nil then
    FRbStyleManager.UnRegisterControl(Self);
    
  FGrBitmap.Free;
  FGrMouseOver.Free;
  Colors.Free;
  {$IFDEF VER130}
  Forms.DeallocateHWnd(Handle);
  {$ELSE}
  Classes.DeallocateHWnd(Handle);
  {$ENDIF}
  inherited;
end;

procedure TRbSplitter.DoBlendLess(Sender: TObject);
begin
  if (FOverBlendPercent <= 0) then
  begin
    FOverBlendPercent := 0;
    KillTimer(Handle, 1);
  end else
    Dec(FOverBlendPercent, OverBlendInterval);
  Invalidate;
end;

procedure TRbSplitter.DoBlendMore(Sender: TObject);
begin
  if FOverBlendPercent >= 100 then begin   
    FOverBlendPercent := 100;
  end else
   Inc(FOverBlendPercent, OverBlendInterval);
  if FOverBlendPercent >= 100 then begin
     Invalidate;
     KillTimer(Handle, 1);
     Exit;
  end;
  Invalidate;
end;
procedure TRbSplitter.DrawPicksBt(ACanvas: TCanvas; BLeft, BTop: integer);

    procedure DrawPickBt(ACanvas: TCanvas; BLeft, BTop: integer; BigDots : boolean);
    begin
      if BigDots then begin
        ACanvas.Brush.Color := clGray;
        ACanvas.FillRect(Rect(BLeft, BTop, BLeft + 2, BTop + 2));

        ACanvas.Brush.Color := clWhite;
        ACanvas.FillRect(Rect(BLeft + 1, BTop + 1, BLeft + 3, BTop + 3));
        ACanvas.Pixels[BLeft + 1, BTop +2] := clSilver;

        ACanvas.Pixels[BLeft + 1 , BTop + 1] :=  clGray;
        ACanvas.Pixels[BLeft , BTop] :=  clWhite;
      end else begin
        ACanvas.Pixels[BLeft + 1, BTop + 1] := clGray;
        ACanvas.Pixels[BLeft, BTop + 1] := clWhite;
      end;
    end;

var
  i : integer;
begin
  i := -40;
  while i <= 40 do begin
    if GripAlign = gaVertical then
      DrawPickBt(ACanvas, BLeft, BTop + i, true)
    else
      DrawPickBt(ACanvas, BLeft + i, BTop, true);
    Inc(i, 3);
  end;
end;

procedure TRbSplitter.Loaded;
begin
  inherited;
  //Activate double buffering for parent control
  if (Parent <> nil) and Parent.InheritsFrom(TWinControl) then
    Parent.DoubleBuffered := true;
end;

procedure TRbSplitter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent is TRbStyleManager) then FRbStyleManager := nil;
  inherited Notification(AComponent, Operation);
end;

procedure TRbSplitter.Paint;
var
  FinalBitmap : TBitmap;
begin
  inherited;
  if FGrBitmap.Height <> Height then UpdateGradients;

  FinalBitmap := TBitmap.Create;
  try
    FinalBitmap.PixelFormat := pf24bit;
    FinalBitmap.Width := Width;
    FinalBitmap.Height := Height;
    BlendBitmaps(FinalBitmap, FGrBitmap, FGrMouseOver, FOverBlendPercent, Canvas.ClipRect, 0);

    BitBlt(Canvas.Handle, 0, 0, Width, Height, FinalBitmap.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    FinalBitmap.Free;
  end;
end;

procedure TRbSplitter.RequestAlign;
begin
  inherited;
    if Align in [alLeft, alRight] then
      GripAlign := gaVertical
    else
      if Align in [alTop, alBottom] then
        GripAlign := gaHorizontal;
end;

procedure TRbSplitter.Resize;
begin
  inherited;
  UpdateGradients;
end;

procedure TRbSplitter.SetAbout(const Value: string);
begin
end;

procedure TRbSplitter.SetDrawAll(const Value: boolean);
begin
  if FDrawAll <> Value then begin
    FDrawAll := Value;
    UpdateGradients;
  end;  
end;

procedure TRbSplitter.SetFadeSpeed(const Value: TFadeSpeed);
begin
  if FFadeSpeed <> Value then
    FFadeSpeed := Value;
end;

procedure TRbSplitter.SetGradientType(const Value: TGradientType);
begin
  if FGradientType <> Value then begin
    FGradientType := Value;
    UpdateGradients;
  end;
end;

procedure TRbSplitter.SetGripAlign(const Value: TGripAlign);
begin
  if FGripAlign <> Value then begin
    FGripAlign := Value;
    UpdateGradients;
  end;
end;

procedure TRbSplitter.SetRbStyleManager(const Value: TRbStyleManager);
begin
  if Value <> FRbStyleManager then
  begin
    if Value <> nil then
      Value.RegisterControl(Self)
    else
      FRbStyleManager.UnregisterControl(Self);
    FRbStyleManager := Value;
  end;
end;

procedure TRbSplitter.SetShowGrip(const Value: boolean);
begin
  if FShowGrip <> Value then begin
    FShowGrip := Value;
    UpdateGradients;
  end;
end;

procedure TRbSplitter.UpdateGradients;
var
  BtLeft, BtTop : integer;
  R : TRect;
begin
  inherited;
  if (FGrBitmap = nil) or (FGrMouseOver = nil) then Exit;

  FGrBitmap.Width := Width;
  FGrBitmap.Height := Height;

  FGrBitmap.Canvas.Brush.Color := Color;
  FGrBitmap.Canvas.FillRect(FGrBitmap.Canvas.ClipRect);
  FGrMouseOver.Canvas.Brush.Color := Color;
  FGrMouseOver.Canvas.FillRect(FGrBitmap.Canvas.ClipRect);
      
  if GripAlign = gaVertical then begin
    BtTop := FGrBitmap.Height div 2;
    BtLeft := (FGrBitmap.Width - 3) div 2;
  end else begin
    BtTop := (FGrBitmap.Height - 3) div 2;
    BtLeft := FGrBitmap.Width div 2;
  end;

  R := FGrBitmap.Canvas.ClipRect;

  if not DrawAll then
    if GripAlign = gaVertical then begin
      R.Top := BtTop - 40;
      R.Bottom  := BtTop + 40;
    end else begin
      R.Left := BtLeft - 40;
      R.Right  := BtLeft + 40;
    end;

  DoBitmapGradient(FGrBitmap, R, Colors.DefaultFrom, Colors.DefaultTo, FGradientType, 0);
  if ShowGrip then
    DrawPicksBt(FGrBitmap.Canvas, BtLeft, BtTop);

  FGrMouseOver.Width := Width;
  FGrMouseOver.Height := Height;
  DoBitmapGradient(FGrMouseOver, R, Colors.OverFrom, Colors.OverTo, FGradientType, 0);

  if ShowGrip then
    DrawPicksBt(FGrMouseOver.Canvas, BtLeft, BtTop);
  Invalidate;
end;

procedure TRbSplitter.UpdateTimer;
begin
  KillTimer(Handle, 1);
  SetTimer(Handle, 1, AFadeSpeed[FFadeSpeed], nil);
end;

procedure TRbSplitter.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_TIMER then
      try
        FOnFade(Self);
      except
      end;
  inherited;
end;

end.

