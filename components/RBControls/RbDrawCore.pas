{-----------------------------------------------------------------------------
 Unit Name: RbDrawCore
 Purpose: base classes and graphics functions for the RbControls

 Author/Copyright: Nathanaël VERON - r.b.a.g@free.fr - http://r.b.a.g.free.fr


        Feel free to modify and improve source code, mail me (r.b.a.g@free.fr)
        if you make any big fix or improvement that can be included in the next
        versions. If you use the RbControls in your project please
        mention it or make a link to my website.


       ===============================================
       /*   03/09/2003    */
       creation of DoBitmapGradient proc, slower than older function but
       allow to do radial, fromTopLeft and fromTopRight gradients for
       RbCheckBox, RbRadioButton and RbSplitter

       /*   10/09/2003    */
       Replaced Windows AlphaBlend function w/ a homemade one...
       Now compatible w/ 98, 95 and NT.

       /*   02/10/2003    */
       Bug correction of Color/InnerColor property for TRbPanel

       /*   14/10/2003    */
       Creation of TRbStyleManager

       /*   13/11/2003    */
       Modifications for D5 compatibility
       thx to Pierre Castelain -> www.micropage.fr.st       
-----------------------------------------------------------------------------}

unit RbDrawCore;

interface

uses Windows, Messages, Classes, Graphics, Controls, Math, SysUtils, TypInfo, IniFiles;


type
  //Fade speed type
  TFadeSpeed = (fsSlow, fsMedium, fsFast, fsVeryFast);

  //Gradient type
  TGradientType = (gtHorizontal, gtVertical, gtFromTopLeft, gtFromTopRight,
                   gtRadial, gtDoubleHorz, gtDoubleVert);

  //Used for image manipulation
  TRGBArray = array[0..0] of TRGBTriple;
  PRGBArray = ^TRGBArray; 

  //Controls draw states
  TDrawStates = set of (dsMouseOver, dsClicking);

  //Controls bounds lines 
  TBorderLines = set of (blTop, blBottom, blLeft, blRight);

  //Panel caption position
  TRbCaptionPos = (cpGroupBox, cpTopLeft, cpTopCenter, cpTopRight,
                 cpMiddleLeft, cpMiddleCenter, cpMiddleRight,
                 cpBottomLeft, cpBottomCenter, cpBottomRight);

  TPanelBehaviour = (pbPanel, pbGroupBox);

  //Radio button size
  TRadioSize = (rsSmall, rsMedium, rsLarge);

  //RbSplitter grip align
  TGripAlign = (gaVertical, gaHorizontal);

const
    //Fade timer speeds in ms
    AFadeSpeed : array[TFadeSpeed] of integer = (40, 20, 12, 8);

    //Blend gradient percent interval, should be a multiplier of 100
    ClickBlendInterval = 25;
    OverBlendInterval = 10;

    sAboutString = 'RbControls v 1.00 - © Nathanaël VERON 2003';

type
  TRbStyleManager = class;

  TRbCustomColors = class(TPersistent)
  private
    FDefaultFrom : TColor;
    FDefaultTo : TColor;
    FOverFrom : TColor;
    FOverTo : TColor;
    procedure SetDefaultFrom(const Value: TColor);
    procedure SetDefaultTo(const Value: TColor);
    procedure SetOverFrom(const Value: TColor);
    procedure SetOverTo(const Value: TColor);
  protected
    FOwner: TObject;
    procedure DoUpdateGradients; virtual; abstract;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TComponent); virtual;
  published
    property DefaultFrom : TColor read FDefaultFrom write SetDefaultFrom;
    property DefaultTo : TColor read FDefaultTo write SetDefaultTo;
    property OverFrom : TColor read FOverFrom write SetOverFrom;
    property OverTo : TColor read FOverTo write SetOverTo;
  end;


  TRbControlColors = class(TRbCustomColors)
  private
    FClickedFrom : TColor;
    FClickedTo : TColor;
    FHotTrack : TColor;
    FBorderColor : TColor;
    FTextShadow : TColor;
    procedure SetClickedFrom(const Value: TColor);
    procedure SetClickedTo(const Value: TColor);
    procedure SetHotTrack(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetTextShadow(const Value: TColor);
  protected
    FOwner: TObject;
    procedure DoUpdateGradients; override;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ClickedFrom : TColor read FClickedFrom write SetClickedFrom;
    property ClickedTo : TColor read FClickedTo write SetClickedTo;
    property HotTrack : TColor read FHotTrack write SetHotTrack;
    property BorderColor : TColor read FBorderColor write SetBorderColor;
    property TextShadow : TColor read FTextShadow write SetTextShadow;
  end;

  TRbSplitterColors = class(TRbCustomColors)
  protected
    procedure DoUpdateGradients; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  //Base type for RbControls
  TRbCustomControl = class(TCustomControl)
  private
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FTextShadow: boolean;
    FRbStyleManager: TRbStyleManager;
    FAbout: string;
    FShowCaption: boolean;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFocusChanged(var Message: TMessage); message CM_FOCUSCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMMouseMove(var Message: TWMMouse); message WM_MOUSEMOVE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure SetTextShadow(const Value: boolean);
    procedure SetRbStyleManager(const Value: TRbStyleManager);
    procedure SetAbout(const Value: string);
    procedure SetShowCaption(const Value: boolean);
  protected
    FOverBlendPercent: integer;
    FClickedBlendPercent: integer;
    FDrawStates: TDrawStates;
    FFadeSpeed: TFadeSpeed;
    FOnFade : TNotifyEvent;
    procedure UpdateGradients; virtual; abstract;

    procedure EventEnabledChanged; virtual;
    procedure EventFocusChanged; virtual;
    procedure EventMouseDown; virtual;
    procedure EventMouseUp; virtual;
    procedure EventMouseEnter; virtual;
    procedure EventMouseLeave; virtual;
    procedure EventMouseMove; virtual;
    procedure EventParentColorChanged; virtual;
    procedure EventResized; virtual;
    procedure EventTextChanged; virtual;
    procedure DoBlendLess(Sender: TObject); virtual;
    procedure DoBlendMore(Sender: TObject); virtual;
    procedure UpdateTimer;
    procedure WndProc(var Msg: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure MouseDown(Button:TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button:TMouseButton; Shift:TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  published
    property Anchors;
    property Action;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property Align;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property TabOrder;
    property TabStop default True;
    property TextShadow: boolean read FTextShadow write SetTextShadow;
    property ShowCaption: boolean read FShowCaption write SetShowCaption;    
    property RbStyleManager: TRbStyleManager read FRbStyleManager write SetRbStyleManager;
    property About : string read FAbout write SetAbout stored false;
  end;

  TRbStyleManager = class(TComponent)
  private
    FFileName : string;
    FControlList : TList;

    //Buttons & check
    FControlColors : TRbControlColors;
    FShowFocusRect : boolean;
    FHotTrack : boolean;
    FGradientBorder : boolean;
    FTextShadow : boolean;
    FCheckColor : TColor;

    //Common
    FFadeSpeed : TFadeSpeed;

    //TRbPanel
    FPanelColor : TColor;
    FBorderColor : TColor;

    //TRbSplitter
    FSplitterColors : TRbSplitterColors;

    FFont : TFont;

    procedure SetBorderColor(const Value: TColor);
    procedure SetFadeSpeed(const Value: TFadeSpeed);
    procedure SetGradientBorder(const Value: boolean);
    procedure SetHotTrack(const Value: boolean);
    procedure SetPanelColor(const Value: TColor);
    procedure SetShowFocusRect(const Value: boolean);
    procedure SetTextShadow(const Value: boolean);
    procedure SetCheckColor(const Value: TColor);

    procedure ImportNumericValue(Instance: TObject; PropName, PropValue: string);
    procedure ImportEnumValue(Instance: TObject; PropName, PropValue : string);
    procedure ImportSetValue(Instance: TObject; PropName, PropValue : string);
  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadFromFile(AFileName: string);
    procedure SaveToFile(AFileName: string);

    procedure UpdateStyle;
    procedure AssignTo(Dest: TPersistent); override;
    procedure RegisterControl(AControl: TControl);
    procedure UnRegisterControl(AControl: TControl);
    property FileName : string read FFileName write FFileName;
  published
    property Colors : TRbControlColors read FControlColors write FControlColors;
    property ShowFocusRect : boolean read FShowFocusRect write SetShowFocusRect;
    property HotTrack : boolean read FHotTrack write SetHotTrack;
    property GradientBorder: boolean read FGradientBorder write SetGradientBorder;
    property TextShadow: boolean read FTextShadow write SetTextShadow;
    property CheckColor : TColor read FCheckColor write SetCheckColor;
    property FadeSpeed : TFadeSpeed read FFadeSpeed write SetFadeSpeed;
    property PanelColor : TColor read FPanelColor write SetPanelColor;
    property BorderColor : TColor read FBorderColor write SetBorderColor;
    property SplitterColors : TRbSplitterColors read FSplitterColors write FSplitterColors;
    property Font : TFont read FFont write FFont;
  end;

  {---------------------------------------------
                Drawing procedures
  ---------------------------------------------}

  //Does a gradient between Color1 and Color2 on the Bitmap in the region R
  procedure DoBitmapGradient(Bitmap: TBitmap; CurrRect: TRect; Color1, Color2: TColor; GradientType : TGradientType; Region: HRGN);

  //Draw text with specific flags on the canvas
  procedure DoDrawText(Canvas: TCanvas; AText: string; AFont : TFont; Enabled : boolean; ShowAccelChar : boolean; ARect: TRect; Flags: integer; TextShadow: boolean; ShadowColor : TColor);

  //Blend two bitmaps with a percent specified
  procedure BlendBitmaps(AFinal, ABitmap1, ABitmap2 : TBitmap; APercent : integer; ARect: TRect; Offset : integer);

  //Set text flags
  procedure SetTextFlags(Alignment: TAlignment; WordWrap: boolean; var Flags: integer);

  //Colorize a bitmap
  procedure ColorizeBitmap(ABitmap: TBitmap; Color : TColor);

  //Does SuperSampling reduction from a bitmap to another
  procedure AntialiasBitmap(ABitmap1, ABitmap2: TBitmap; Sampling: integer);

  //Does SuperSampling reduction from a bitmap to another, spécific to RbPanel
  procedure AntialiasShapeBitmap(ABitmap1, ABitmap2: TBitmap; Sampling: integer; CornerWidth: integer; InnerColor: TColor);

  //Alphablend 2 bitmaps
  procedure RbAlphaBlend(ABitmap1, ABitmap2: TBitmap; ARect: TRect; percent : integer);


  procedure Register;

implementation

{$R-}

uses RbPanel, RbSplitter, RbProgressBar, RbButton, RbCheckBox, RbRadioButton;

const
  sFileNotExists = 'File not exists!';
  sInvalidOrEmptyFile = 'Empty or invalid file';


procedure Register;
begin
  RegisterComponents('RbControls', [TRbStyleManager]);
end;

{$IFDEF VER130}
function GetPropList(TypeInfo: PTypeInfo; out PropList: PPropList): Integer; overload;
begin
  Result := GetTypeData(TypeInfo)^.PropCount;
  if Result > 0 then
  begin
    GetMem(PropList, Result * SizeOf(Pointer));
    GetPropInfos(TypeInfo, PropList);
  end;
end;

function GetPropList(AObject: TObject; out PropList: PPropList): Integer; overload;
begin
  Result := GetPropList(PTypeInfo(AObject.ClassInfo), PropList);
end;
{$ENDIF}

//Does a gradient between Color1 and Color2 on the Bitmap inside the region R (only 24 bits)
procedure DoBitmapGradient(Bitmap: TBitmap; CurrRect: TRect; Color1, Color2: TColor; GradientType : TGradientType; Region: HRGN);
var
  y, x, MaxDist, C1, C2 : integer;
  rowDest : PRGBArray;
  Dep : array[0..2] of integer;
  Dif : array[0..2] of Double;
  Coef : Double;
begin
  if (Bitmap.Width <= 0) or (Bitmap.Height <= 0) then Exit;

  if Color1 = Color2  then begin
    Bitmap.Canvas.Brush.Color := Color1;
    if Region > 0 then
      FillRgn(Bitmap.Canvas.Handle, Region, Bitmap.Canvas.Brush.Handle)
    else
      Bitmap.Canvas.FillRect(CurrRect);
    Exit;
  end;

  C1 := ColorToRGB(Color1);
  C2 := ColorToRGB(Color2);

  case GradientType of
    gtVertical : MaxDist := CurrRect.Bottom - CurrRect.Top;

    gtHorizontal : MaxDist := CurrRect.Right - CurrRect.Left;

    gtFromTopLeft,
    gtFromTopRight: MaxDist := (Round(Sqrt( Sqr(CurrRect.Right - CurrRect.Left)
                              + Sqr(CurrRect.Bottom - CurrRect.Top)))
                              - CurrRect.Left);
    gtRadial: MaxDist := (Round(Sqrt( Sqr(CurrRect.Right - CurrRect.Left)
                              + Sqr(CurrRect.Bottom - CurrRect.Top)))
                              - CurrRect.Left) div 2;
    gtDoubleHorz: MaxDist :=  (CurrRect.Right - CurrRect.Left) div 2;
    gtDoubleVert: MaxDist :=  (CurrRect.Bottom - CurrRect.Top) div 2;
  end;

  Dep[0] := GetRValue(C1);
  Dep[1] := GetGValue(C1);
  Dep[2] := GetBValue(C1);

  Dif[0] := (GetRValue(C2) - Dep[0]) / MaxDist;
  Dif[1] := (GetGValue(C2) - Dep[1]) / MaxDist;
  Dif[2] := (GetBValue(C2) - Dep[2]) / MaxDist;

  if Dif[0] > 255 then Dif[0] := 255;
  if Dif[1] > 255 then Dif[1] := 255;
  if Dif[2] > 255 then Dif[2] := 255;

  for y:= CurrRect.Top to CurrRect.Bottom -1 do
  begin
    rowDest := Bitmap.ScanLine[y];
    for x := CurrRect.Left to CurrRect.Right - 1 do
    begin
      if (Region > 0) and not PtInRegion(Region, x, y) then Continue;
      case GradientType of
        gtHorizontal : Coef := x - CurrRect.Left;
        gtVertical :   Coef := y - CurrRect.Top;
        gtFromTopLeft :Coef := Sqrt(Sqr(x - CurrRect.Left) + Sqr(y - CurrRect.Top));
        gtFromTopRight:Coef := Sqrt(Sqr(CurrRect.Right - x) + Sqr(y - CurrRect.Top));
        gtRadial: Coef := Sqrt(Sqr(((CurrRect.Right - CurrRect.Left) shr 1) - x) + Sqr(y - ((CurrRect.Bottom - CurrRect.Top) shr 1)));
        gtDoubleHorz: Coef := Abs(x - MaxDist - CurrRect.Left);
        gtDoubleVert: Coef := Abs(y - MaxDist - CurrRect.Top);
      end;
      RowDest[x].rgbtRed := Byte(Round(Dep[0] + (Dif[0] * Coef)));
      RowDest[x].rgbtGreen := Byte(Round(Dep[1] + (Dif[1] * Coef)));
      RowDest[x].rgbtBlue := Byte(Round(Dep[2] + (Dif[2] * Coef)));
    end;
 end;
end;


//Draw text with specific flags on the canvas
procedure DoDrawText(Canvas: TCanvas; AText: string; AFont : TFont; Enabled : boolean; ShowAccelChar : boolean; ARect: TRect; Flags: integer; TextShadow: boolean; ShadowColor : TColor);
var
  OldColor : TColor;
begin
  with Canvas do begin
    Canvas.Font.Assign(AFont);
    if Enabled then begin
      if TextShadow then begin
        OldColor := Font.Color;
        Font.Color := ShadowColor;
        OffsetRect(ARect, 1, 1);
        DrawTextEx(Handle, PChar(AText), Length(AText), ARect, Flags, nil);
        Font.Color := OldColor;
        OffsetRect(ARect, -1, -1);
      end;
      DrawTextEx(Handle, PChar(AText), Length(AText), ARect, Flags, nil);

    end else begin
      Font.Color := clBtnHighlight;
      OffsetRect(ARect, 1, 1);
      DrawTextEx(Handle, PChar(AText), Length(AText), ARect, Flags, nil);

      Font.Color := clBtnShadow;
      OffsetRect(ARect, -1, -1);
      DrawTextEx(Handle, PChar(AText), Length(AText), ARect, Flags, nil);
    end;
  end;
end;


//Blend 2 bitmaps into a third with the Percent value
procedure BlendBitmaps(AFinal, ABitmap1, ABitmap2 : TBitmap; APercent : integer; ARect: TRect; Offset : integer);
begin
  BitBlt(AFinal.Canvas.Handle, ARect.Left + Offset, ARect.Top + Offset, ARect.Right - ARect.Left - Offset, ARect.Bottom - ARect.Top - Offset,
         ABitmap1.Canvas.Handle, 0, 0, SRCCOPY);
  if APercent <= 0 then Exit;
  if APercent > 100 then APercent := 100;


  RbAlphaBlend(AFinal, ABitmap2, ARect, APercent);
end;

procedure SetTextFlags(Alignment: TAlignment; WordWrap: boolean; var Flags: integer);
begin
  Flags := DT_END_ELLIPSIS or DT_VCENTER or DT_NOPREFIX;

  case Alignment of
    taLeftJustify:
      Flags := Flags or DT_LEFT;
    taCenter:
      Flags := Flags or DT_CENTER;
    taRightJustify:
      Flags := Flags or DT_RIGHT;
  end;

  if WordWrap then
    Flags := Flags or DT_WORDBREAK
  else
    Flags := Flags or DT_SINGLELINE;
end;

//Colorize a bitmap to color
//Slow, not efficient, only for small images, used for glyphs & radio glyph
procedure ColorizeBitmap(ABitmap: TBitmap; Color : TColor);
var
  i,j,l,Col: integer;
  R,G,B : Integer;
begin
  Color := ColorToRGB(Color);
  for i := 0 to ABitmap.Height - 1 do
    for j := 0 to ABitmap.Width - 1 do
      begin
        Col := ColorToRGB(ABitmap.Canvas.Pixels[j, i]);

        l := Round(((Col shr 16) + ((Col shr 8) and $00FF) + (Col and $0000FF)) div 3);

        R := GetRValue(Color) + l;
        G := GetGValue(Color) + l;
        B := GetBValue(Color) + l;
        if R > 255 then R := 255;
        if G > 255 then G := 255;
        if B > 255 then B := 255;
        ABitmap.Canvas.Pixels[j, i] := RGB(R, G, B);
      end;
end;

//Does SuperSampling reduction from a bitmap to another (only 24 bits)
procedure AntialiasBitmap(ABitmap1, ABitmap2: TBitmap; Sampling: integer);
var
  yDest, xDest, i, j, R, G, B : integer;
  rowDest, rowSrc : PRGBArray;
begin
  for yDest:= 0 to ABitmap2.Height -1 do
  begin
    rowDest := ABitmap2.ScanLine[yDest];
    rowSrc := ABitmap1.ScanLine[yDest*Sampling];
    for xDest :=0 to ABitmap2.Width-1 do
    begin
      R:=0; G:=0; B:=0;
      // Make the sampling on Src image
      for i:=0 to Sampling-1 do
      begin
        for j:=0 to Sampling-1 do
        begin
          R := R + rowSrc[(xDest*Sampling)+j].rgbtRed;
          G := G + rowSrc[(xDest*Sampling)+j].rgbtGreen;
          B := B + rowSrc[(xDest*Sampling)+j].rgbtBlue;
        end;
      rowSrc := ABitmap1.ScanLine[(yDest*Sampling)+i];
      end;
      // Assign to the result image
      rowDest[xDest].rgbtRed := R div Sqr(Sampling);
      rowDest[xDest].rgbtGreen := G div Sqr(Sampling);
      rowDest[xDest].rgbtBlue := B div Sqr(Sampling);
    end;
  end;
end;


//Does SuperSampling reduction from a bitmap to another, spécific to RbPanel
procedure AntialiasShapeBitmap(ABitmap1, ABitmap2: TBitmap; Sampling: integer; CornerWidth: integer; InnerColor: TColor);
var
  yDest, xDest, i, j, R, G, B : integer;
  rowDest, rowSrc : PRGBArray;
begin
  InnerColor := ColorToRGB(InnerColor);

  if CornerWidth < 1 then CornerWidth := Sampling;
  CornerWidth := CornerWidth div 2;

  try
    for yDest:= 0 to ABitmap2.Height - 1 do
    begin
      rowDest := ABitmap2.ScanLine[yDest];
      rowSrc := ABitmap1.ScanLine[yDest*Sampling];
      for xDest :=0 to ABitmap2.Width - 1 do
      begin
        R:=0; G:=0; B:=0;
        // Make the sampling on Src image
        if (xDest <= CornerWidth) or (yDest <= CornerWidth) or
           (xDest >= ABitmap2.Width - CornerWidth) or (yDest >= ABitmap2.Height - CornerWidth) then begin
          for i:=0 to Sampling-1 do
          begin
            for j:=0 to Sampling-1 do
            begin
              R := R + rowSrc[(xDest*Sampling)+j].rgbtRed;
              G := G + rowSrc[(xDest*Sampling)+j].rgbtGreen;
              B := B + rowSrc[(xDest*Sampling)+j].rgbtBlue;
            end;
          rowSrc := ABitmap1.ScanLine[(yDest*Sampling)+i];

          end;
          // Assign to the result image
          rowDest[xDest].rgbtRed := R div Sqr(Sampling);
          rowDest[xDest].rgbtGreen := G div Sqr(Sampling);
          rowDest[xDest].rgbtBlue := B div Sqr(Sampling);
        end;
      end;
    end;
  except
  end;

  ABitmap2.Canvas.Brush.Color := InnerColor;
  ABitmap2.Canvas.FillRect(Rect(CornerWidth, CornerWidth, ABitmap2.Width - CornerWidth, ABitmap2.Height - CornerWidth));
end;

procedure RbAlphaBlend(ABitmap1, ABitmap2: TBitmap; ARect: TRect; percent : integer);
var
  yDest, xDest: integer;
  rowDest, rowSrc : PRGBArray;
  WeightA, WeightB: Double;
begin
  WeightA := (100 - percent) / 100;
  WeightB := 1- WeightA;
  for yDest := ARect.Top to ARect.Bottom - 1 do
  begin
    rowDest := ABitmap1.ScanLine[yDest];
    rowSrc := ABitmap2.ScanLine[yDest - ARect.Top];
    for xDest := ARect.Left to ARect.Right - 1 do
    begin
      // Assign to the result image
      rowDest[xDest].rgbtRed := Round((rowDest[xDest].rgbtRed * WeightA + rowSrc[xDest - ARect.Left].rgbtRed * WeightB));
      rowDest[xDest].rgbtGreen := Round((rowDest[xDest].rgbtGreen * WeightA + rowSrc[xDest - ARect.Left].rgbtGreen * WeightB));
      rowDest[xDest].rgbtBlue := Round((rowDest[xDest].rgbtBlue * WeightA + rowSrc[xDest - ARect.Left].rgbtBlue * WeightB));
    end;
  end;
end;
{---------------------------------------------
              TRbCustomControl
---------------------------------------------}

procedure TRbCustomControl.CMEnabledChanged(var Message: TMessage);
begin
  EventEnabledChanged;
  inherited;
end;

procedure TRbCustomControl.CMFocusChanged(var Message: TMessage);
begin
  EventFocusChanged;
  inherited;
end;

procedure TRbCustomControl.CMMouseEnter(var Message: TMessage);
begin
  EventMouseEnter;
  inherited;
end;

procedure TRbCustomControl.CMMouseLeave(var Message: TMessage);
begin
  EventMouseLeave;
  inherited;
end;

procedure TRbCustomControl.CMParentColorChanged(var Message: TMessage);
begin
  EventParentColorChanged;
  inherited;
end;

procedure TRbCustomControl.CMTextChanged(var Message: TMessage);
begin
  EventTextChanged;
  inherited;
end;

constructor TRbCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque, csReplicatable] - [csDoubleClicks];
  DoubleBuffered := True;
  TabStop := True;
  FTextShadow := true;
  FShowCaption := true;
  FAbout := sAboutString;
end;

destructor TRbCustomControl.Destroy;
begin
  if FRbStyleManager <> nil then
    FRbStyleManager.UnRegisterControl(Self);
  inherited;
end;

procedure TRbCustomControl.DoBlendMore(Sender: TObject);
begin
  if (dsClicking in FDrawStates) and (dsMouseOver in FDrawStates) then
  begin
    if FClickedBlendPercent >= 100 then
    begin
      FClickedBlendPercent := 100;
      Invalidate;
      KillTimer(Handle, 1);
      Exit;
    end else
    begin
      Inc(FClickedBlendPercent, ClickBlendInterval);
    end;
  end else
  begin
    if FClickedBlendPercent > 0 then Dec(FClickedBlendPercent, ClickBlendInterval);

    if FOverBlendPercent >= 100 then begin
      FOverBlendPercent := 100;
    end else
     Inc(FOverBlendPercent, OverBlendInterval);
    if (FClickedBlendPercent <= 0) and (FOverBlendPercent >= 100) then begin
       Invalidate;
       KillTimer(Handle, 1);
       Exit;
    end;
  end;
  Invalidate;
end;

procedure TRbCustomControl.DoBlendLess(Sender: TObject);
begin
  if FClickedBlendPercent > 0 then Dec(FClickedBlendPercent, ClickBlendInterval);
  if (FOverBlendPercent <= 0) and (FClickedBlendPercent <= 0) then
  begin
    FOverBlendPercent := 0;
    FClickedBlendPercent := 0;
    KillTimer(Handle, 1);
  end else
    Dec(FOverBlendPercent, OverBlendInterval);
  Invalidate;
end;

procedure TRbCustomControl.EventEnabledChanged;
begin
  Invalidate;
end;

procedure TRbCustomControl.EventFocusChanged;
begin
  ;
end;

procedure TRbCustomControl.EventMouseDown;
begin
  if not Focused and CanFocus then
    SetFocus;
end;

procedure TRbCustomControl.EventMouseEnter;
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TRbCustomControl.EventMouseLeave;
begin
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

procedure TRbCustomControl.EventMouseMove;
begin
  ;
end;

procedure TRbCustomControl.EventMouseUp;
begin
  ;
end;

procedure TRbCustomControl.EventParentColorChanged;
begin
  ;
end;

procedure TRbCustomControl.EventResized;
begin
  ;
end;

procedure TRbCustomControl.EventTextChanged;
begin
  Invalidate;
end;

procedure TRbCustomControl.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then EventMouseDown;
end;

procedure TRbCustomControl.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then EventMouseUp;
end;

procedure TRbCustomControl.SetTextShadow(const Value: boolean);
begin
  if FTextShadow <> Value then begin
    FTextShadow := Value;
    Invalidate;
  end;
end;

procedure TRbCustomControl.WMMouseMove(var Message: TWMMouse);
begin
  EventMouseMove;
  inherited;
end;

procedure TRbCustomControl.WMSize(var Message: TWMSize);
begin
  EventResized;
  inherited;
end;

procedure TRbCustomControl.UpdateTimer;
begin
  KillTimer(Handle, 1);
  SetTimer(Handle, 1, AFadeSpeed[FFadeSpeed], nil);
end;

procedure TRbCustomControl.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_TIMER then
      try
        FOnFade(Self);
      except
      end;
  inherited;
end;

procedure TRbCustomControl.SetRbStyleManager(const Value: TRbStyleManager);
begin
  if Value <> FRbStyleManager then
  begin
    if Value <> nil then begin
      Value.RegisterControl(Self);
    end else
      FRbStyleManager.UnregisterControl(Self);
    FRbStyleManager := Value;
  end;
end;

procedure TRbCustomControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent is TRbStyleManager) then FRbStyleManager := nil;
  inherited Notification(AComponent, Operation);
end;

procedure TRbCustomControl.SetAbout(const Value: string);
begin
end;

procedure TRbCustomControl.SetShowCaption(const Value: boolean);
begin
  if FShowCaption <> Value then begin
    FShowCaption := Value;
    Invalidate;
  end;
end;

{---------------------------------------------
              TRbControlColors
---------------------------------------------}

procedure TRbControlColors.AssignTo(Dest: TPersistent);
begin
  if (Dest is TRbControlColors) or Dest.InheritsFrom(TRbControlColors) then
    with TRbControlColors(Dest) do begin
      FDefaultFrom := Self.FDefaultFrom;
      FDefaultTo := Self.FDefaultTo;
      FOverFrom := Self.FOverFrom;
      FOverTo := Self.FOverTo;
      FClickedFrom := Self.FClickedFrom;
      FClickedTo := Self.FClickedTo;
      FBorderColor := Self.FBorderColor;
      FHotTrack := Self.FHotTrack;
      FTextShadow := Self.FTextShadow;
    end
  else
    inherited AssignTo(Dest);
end;

constructor TRbControlColors.Create(AOwner: TComponent);
begin
  inherited;
  FOwner := AOwner;

  FClickedFrom := $00C6CFD6;
  FClickedTo   := $00EBF3F7;
  FHotTrack    := clBlue;
  FBorderColor := clGray;
  FTextShadow  := clWhite;
end;

procedure TRbControlColors.DoUpdateGradients;
begin
  if FOwner <> nil then
    TRbCustomControl(FOwner).UpdateGradients;
end;

procedure TRbControlColors.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then begin
    FBorderColor := Value;
    DoUpdateGradients;
  end;
end;

procedure TRbControlColors.SetClickedFrom(const Value: TColor);
begin
  if Value <> FClickedFrom then begin
    FClickedFrom := Value;
    DoUpdateGradients;
  end;
end;

procedure TRbControlColors.SetClickedTo(const Value: TColor);
begin
 if FClickedTo <> Value then begin
   FClickedTo := Value;
   DoUpdateGradients;
 end;
end;

procedure TRbControlColors.SetHotTrack(const Value: TColor);
begin
  if FHotTrack <> Value then begin
    FHotTrack := Value;
    if FOwner <> nil then
      TCustomControl(FOwner).Invalidate;
  end;
end;

procedure TRbControlColors.SetTextShadow(const Value: TColor);
begin
  if FTextShadow <> Value then begin
    FTextShadow := Value;
    if FOwner <> nil then
      TCustomControl(FOwner).Invalidate;
  end;
end;

{---------------------------------------------
             TRbCustomColors
---------------------------------------------}

procedure TRbCustomColors.AssignTo(Dest: TPersistent);
begin
  if Dest.InheritsFrom(TRbCustomColors) or (Dest is TRbCustomColors) then
    with TRbCustomColors(Dest) do begin
      FDefaultFrom := Self.FDefaultFrom;
      FDefaultTo := Self.FDefaultTo;
      FOverFrom := Self.FOverFrom;
      FOverTo := Self.FOverTo;
    end
  else
    inherited AssignTo(Dest);
end;

constructor TRbCustomColors.Create(AOwner: TComponent);
begin
  FOwner := AOwner;

  FDefaultFrom := clWhite;
  FDefaultTo   := $00D1BEAF;
  FOverFrom    := clWhite;
  FOverTo      := $00BE9476;
end;

procedure TRbCustomColors.SetDefaultFrom(const Value: TColor);
begin
  if FDefaultFrom <> Value then begin
    FDefaultFrom := Value;
    DoUpdateGradients;
 end;
end;

procedure TRbCustomColors.SetDefaultTo(const Value: TColor);
begin
  if FDefaultTo <> Value then begin
    FDefaultTo := Value;
    DoUpdateGradients;
 end;
end;

procedure TRbCustomColors.SetOverFrom(const Value: TColor);
begin
  if FOverFrom <> Value then begin
    FOverFrom := Value;
    DoUpdateGradients;
 end;
end;

procedure TRbCustomColors.SetOverTo(const Value: TColor);
begin
 if FOverTo <> Value then begin
    FOverTo := Value;
    DoUpdateGradients;
 end;
end;

{---------------------------------------------
                TRbSplitterColors
---------------------------------------------}

constructor TRbSplitterColors.Create(AOwner: TComponent);
begin
  inherited;
  DefaultFrom := clBtnFace;
  DefaultTo   := clBtnFace;
  OverFrom    := clWhite;
  OverTo      := $00BE9476;
end;



procedure TRbSplitterColors.DoUpdateGradients;
begin
  if FOwner <> nil then
    TRbSplitter(FOwner).UpdateGradients;
end;

{---------------------------------------------
              TRbStyleManager
---------------------------------------------}

constructor TRbStyleManager.Create(AOwner: TComponent);
begin
  inherited;
  FFileName := '';

  FControlList := TList.Create;
  FControlColors := TRbControlColors.Create(nil);
  FSplitterColors := TRbSplitterColors.Create(nil);

  FShowFocusRect := true;
  FHotTrack := false;
  FGradientBorder := true;
  FCheckColor := clGreen;
  FTextShadow := true;

  FFadeSpeed := fsMedium;
  FPanelColor := $00E3DFDF;
  FBorderColor := clGray;

  FFont := TFont.Create;
end;

destructor TRbStyleManager.Destroy;
begin
  FControlList.Free;
  FControlColors.Free;
  FSplitterColors.Free;
  FFont.Free;
  inherited;
end;

procedure TRbStyleManager.ImportEnumValue(Instance: TObject; PropName, PropValue : string);
begin
  if IsPublishedProp(Instance, PropName) then            
    SetEnumProp(Instance, PropName, PropValue);
end;

procedure TRbStyleManager.ImportNumericValue(Instance: TObject; PropName, PropValue: string);
begin
  if IsPublishedProp(Instance, PropName) then
    SetOrdProp(Instance, PropName, StrToIntDef(PropValue, 0));
end;

procedure TRbStyleManager.ImportSetValue(Instance: TObject; PropName, PropValue: string);
begin
  if IsPublishedProp(Instance, PropName) then
    SetSetProp(Instance, PropName, PropValue);
end;

procedure TRbStyleManager.LoadFromFile(AFileName: string);
var
  ini : TIniFile;
  SL : TStringList;
  i : integer;
  Pre : string;
  TpObj: TObject;
begin
  FileName := AFileName;
  if not FileExists(FileName) then
    raise Exception.Create(sFileNotExists);

  ini := TIniFile.Create(FileName);
  SL := TStringList.Create;
  try
    ini.ReadSection('RbControls', SL);

    if SL.Count <= 0 then
      raise Exception.Create(sInvalidOrEmptyFile);

    for i := 0 to SL.Count - 1 do begin

      if Pos('TRbStyleManager', SL[i]) > 0 then begin
        Pre := 'TRbStyleManager';
        SL[i] := copy(SL[i], Length('TRbStyleManager') + 1, Length(SL[i]));
        TpObj := Self;
      end;

      if Pos('TRbControlColors', SL[i]) > 0 then begin
        Pre := 'TRbControlColors';
        SL[i] := copy(SL[i], Length('TRbControlColors') + 1, Length(SL[i]));
        TpObj := Self.FControlColors;
      end;

      if Pos('TRbSplitterColors', SL[i]) > 0 then begin
        Pre := 'TRbSplitterColors';
        SL[i] := copy(SL[i], Length('TRbSplitterColors') + 1, Length(SL[i]));
        TpObj := Self.FSplitterColors;
      end;

      if Pos('TFont', SL[i]) > 0 then begin
        Pre := 'TFont';
        SL[i] := copy(SL[i], Length('TFont') + 1, Length(SL[i]));
        TpObj := Self.FFont;
      end;

      //Import numerical properties
      if SL[i][1] = 'N' then
        ImportNumericValue(TpObj, Copy(SL[i], 2, Length(SL[i])), ini.ReadString('RbControls', pre + SL[i], ''));

      //Import enumeration properties (bool, set...)
      if SL[i][1] = 'E' then
        ImportEnumValue(TpObj, Copy(SL[i], 2, Length(SL[i])), ini.ReadString('RbControls', pre + SL[i], ''));

      //Import Set properties
      if SL[i][1] = 'S' then
        ImportSetValue(TpObj, Copy(SL[i], 2, Length(SL[i])), ini.ReadString('RbControls', pre + SL[i], ''));
    end;

  finally
    ini.Free;
    SL.Free;
  end;
end;

procedure TRbStyleManager.RegisterControl(AControl: TControl);
begin
  if FControlList.IndexOf(AControl) < 0 then
    FControlList.Add(AControl);
end;

procedure TRbStyleManager.UnRegisterControl(AControl: TControl);
begin
  if not (csDestroying in ComponentState) and (FControlList.IndexOf(AControl) >= 0) then
    FControlList.Delete(FControlList.IndexOf(AControl));
end;

procedure TRbStyleManager.SaveToFile(AFileName: string);
var
  ini : TIniFile;
  procedure WriteProps(AObject: TObject; Prefix : string);
  var
    i : integer;
    PropCount : integer;
    P : PPropList;
  begin
    PropCount  := GetPropList(AObject, P);
    for i := 0 to PropCount - 1 do begin
      if ((P^[i].Name = 'Tag') or (P^[i].Name = 'Name')) and (AObject = Self) then Continue;
      case P^[i].PropType^.Kind of
        tkInteger: begin
                     ini.WriteInteger('RbControls', AObject.ClassName + 'N' + P^[i].Name, GetPropValue(AObject, P^[i].Name));
                   end;
        tkEnumeration: begin
                         ini.WriteString('RbControls', AObject.ClassName + 'E' + P^[i].Name, GetPropValue(AObject, P^[i].Name));
                       end;
        tkSet: begin
                 ini.WriteString('RbControls', AObject.ClassName + 'S' + P^[i].Name, GetPropValue(AObject, P^[i].Name));
               end;
        tkClass: WriteProps(GetObjectProp(AObject, P^[i].Name), '');

      end;
    end;
  end;
begin
  FileName := AFileName;
  ini := TIniFile.Create(FileName);
  try
    WriteProps(Self, '');
  finally
    ini.Free;
  end;
end;

procedure TRbStyleManager.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
end;

procedure TRbStyleManager.SetCheckColor(const Value: TColor);
begin
  FCheckColor := Value;
end;

procedure TRbStyleManager.SetFadeSpeed(const Value: TFadeSpeed);
begin
  FFadeSpeed := Value;
end;

procedure TRbStyleManager.SetGradientBorder(const Value: boolean);
begin
  FGradientBorder := Value;
end;

procedure TRbStyleManager.SetHotTrack(const Value: boolean);
begin
  FHotTrack := Value;
end;

procedure TRbStyleManager.SetShowFocusRect(const Value: boolean);
begin
  FShowFocusRect := Value;
end;

procedure TRbStyleManager.SetTextShadow(const Value: boolean);
begin
  FTextShadow := Value;
end;

procedure TRbStyleManager.UpdateStyle;
var
  i, j  : integer;
  PropCount : integer;
  P : PPropList;
  PropName : string;
begin
  if csLoading in ComponentState then Exit;
  //Update the properties of the controls
  PropCount := GetPropList(Self, P);
  for j := 0 to PropCount - 1 do begin
    PropName := P^[j].Name;

    for i := 0 to FControlList.Count - 1 do begin
      if (TObject(FControlList.Items[i]) is TRbPanel) then
        SetOrdProp(TObject(FControlList.Items[i]), 'Color', Self.PanelColor);

      if IsPublishedProp(TObject(FControlList.Items[i]), 'Font') and PropIsType(TObject(FControlList.Items[i]), 'Font', tkClass) then
        TFont(GetObjectProp(TObject(FControlList.Items[i]), 'Font')).Assign(Self.Font);

      //Common controls property affectation
      if (P^[j].Name = 'SplitterColors') and (TObject(FControlList.Items[i]) is TRbSplitter) then
        PropName := 'Colors'
      else
        PropName := P^[j].Name;

      if IsPublishedProp(TObject(FControlList.Items[i]), PropName) then begin
        case P^[j].PropType^.Kind of
          tkInteger: SetOrdProp(TObject(FControlList.Items[i]), PropName, GetPropValue(Self, P^[j].Name));
          {$IFDEF VER130}
          tkEnumeration: SetEnumProp(TObject(FControlList.Items[i]), PropName, VarToStr(GetPropValue(Self, P^[j].Name)));
          tkSet: SetSetProp(TObject(FControlList.Items[i]), PropName, VarToStr(GetPropValue(Self, P^[j].Name)));
          {$ELSE}
          tkEnumeration: SetEnumProp(TObject(FControlList.Items[i]), PropName, GetPropValue(Self, P^[j].Name));
          tkSet: SetSetProp(TObject(FControlList.Items[i]), PropName, GetPropValue(Self, P^[j].Name));
          {$ENDIF}
          tkClass: TPersistent(GetObjectProp(TObject(FControlList.Items[i]), PropName)).Assign(TPersistent(GetObjectProp(Self, P^[j].Name)));
        end;
      end;

      //Update gradients
      if TObject(FControlList.Items[i]) is TRbButton then
        TRbButton(FControlList.Items[i]).UpdateGradients;

      if TObject(FControlList.Items[i]) is TRbCheckBox then
        TRbCheckBox(FControlList.Items[i]).UpdateGradients;

      if TObject(FControlList.Items[i]) is TRbRadioButton then
        TRbRadioButton(FControlList.Items[i]).UpdateGradients;

      if TObject(FControlList.Items[i]) is TRbSplitter then
        TRbSplitter(FControlList.Items[i]).UpdateGradients;
    end;
  end;
end;

procedure TRbStyleManager.AssignTo(Dest: TPersistent);
begin
  if Dest is TRbStyleManager then begin
    with TRbStyleManager(Dest) do begin
      Self.Colors.AssignTo(Colors);
      Self.SplitterColors.AssignTo(SplitterColors);
      ShowFocusRect := Self.ShowFocusRect;
      HotTrack := Self.HotTrack;
      GradientBorder := Self.GradientBorder;
      CheckColor := Self.CheckColor;
      Font.Assign(Self.Font);
      FadeSpeed := Self.FadeSpeed;
      PanelColor := Self.PanelColor;
      BorderColor := Self.BorderColor;
      TextShadow := Self.TextShadow;
    end;
  end else
    inherited AssignTo(Dest);
end;

procedure TRbStyleManager.SetPanelColor(const Value: TColor);
begin
  FPanelColor := Value;
end;

end.


