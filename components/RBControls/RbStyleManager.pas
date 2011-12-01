unit RbStyleManager;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, TypInfo,
  IniFiles, RbDrawCore;

type
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
    FFontColor: TColor;
    FFadeSpeed : TFadeSpeed;

    //TRbPanel
    FInnerColor : TColor;
    FBorderColor : TColor;

    //TRbSplitter
    FSplitterColors : TRbSplitterColors;

    procedure SetBorderColor(const Value: TColor);
    procedure SetFadeSpeed(const Value: TFadeSpeed);
    procedure SetGradientBorder(const Value: boolean);
    procedure SetHotTrack(const Value: boolean);
    procedure SetInnerColor(const Value: TColor);
    procedure SetShowFocusRect(const Value: boolean);
    procedure SetTextShadow(const Value: boolean);
    procedure SetCheckColor(const Value: TColor);

    procedure ImportNumericValue(Instance: TObject; PropName, PropValue: string);
    procedure ImportEnumValue(Instance: TObject; PropName, PropValue : string);
    procedure ImportSetValue(Instance: TObject; PropName, PropValue : string);
    procedure SetFontColor(const Value: TColor);
  protected
    procedure RegisterControl(AControl: TControl);
    procedure UnRegisterControl(AControl: TControl);    
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadFromFile(FileName: string);
    procedure SaveToFile(FileName: string);

    procedure UpdateStyle;

    property FileName : string read FFileName write FFileName;

  published
    property ControlColors : TRbControlColors read FControlColors write FControlColors;
    property ShowFocusRect : boolean read FShowFocusRect write SetShowFocusRect;
    property HotTrack : boolean read FHotTrack write SetHotTrack;
    property GradientBorder: boolean read FGradientBorder write SetGradientBorder;
    property TextShadow: boolean read FTextShadow write SetTextShadow;
    property CheckColor : TColor read FCheckColor write SetCheckColor;
    property FadeSpeed : TFadeSpeed read FFadeSpeed write SetFadeSpeed;
    property InnerColor : TColor read FInnerColor write SetInnerColor;
    property BorderColor : TColor read FBorderColor write SetBorderColor;
    property SplitterColors : TRbSplitterColors read FSplitterColors write FSplitterColors;
    property FontColor : TColor read FFontColor write SetFontColor;
  end;

procedure Register;

implementation

const
  sFileNotExists = 'File not exists!';
  sInvalidOrEmptyFile = 'Empty or invalid file';


procedure Register;
begin
  RegisterComponents('RbControls', [TRbStyleManager]);
end;

{ TRbStyleManager }

constructor TRbStyleManager.Create(AOwner: TComponent);
begin
  inherited;
  FFileName := '';

  FControlList := TList.Create;
  FControlColors := TRbControlColors.Create(nil);
  FSplitterColors := TrbSplitterColors.Create(nil);

  FShowFocusRect := true;
  FHotTrack := false;
  FGradientBorder := true;
  FTextShadow := true;
  FCheckColor := clGreen;

  FFadeSpeed := fsMedium;
  FInnerColor := $00E3DFDF;
  FBorderColor := clGray;
  FFontColor := clWindowText;
end;

destructor TRbStyleManager.Destroy;
begin
  FControlList.Free;
  FControlColors.Free;
  FSplitterColors.Free;
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

procedure TRbStyleManager.LoadFromFile(FileName: string);
var
  ini : TIniFile;
  SL : TStringList;
  i : integer;
  Pre : string;
  TpObj: TObject;
begin
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

     if Pos('TControlColors', SL[i]) > 0 then begin
       Pre := 'TControlColors';
       SL[i] := copy(SL[i], Length('TControlColors') + 1, Length(SL[i]));
       TpObj := Self.FControlColors;
     end;

     if Pos('TSplitterColors', SL[i]) > 0 then begin
       Pre := 'TSplitterColors';
       SL[i] := copy(SL[i], Length('TSplitterColors') + 1, Length(SL[i]));
       TpObj := Self.FSplitterColors;
     end;

//     if Pos('TFont', SL[i]) > 0 then begin
//       Pre := 'TFont';
//       SL[i] := copy(SL[i], Length('TFont') + 1, Length(SL[i]));
//       TpObj := Self.Font;
//     end;

     //Import numerical properties
     if SL[i][1] = 'N' then
       ImportNumericValue(TpObj, SL[i], ini.ReadString('RbControls', pre + SL[i], ''));

     //Import enumeration properties (bool, set...)
     if SL[i][1] = 'E' then
       ImportEnumValue(TpObj, SL[i], ini.ReadString('RbControls', pre + SL[i], ''));

     //Import Set properties  
     if SL[i][1] = 'S' then
       ImportSetValue(TpObj, SL[i], ini.ReadString('RbControls', pre + SL[i], ''));
    end;

  finally
    ini.Free;
    SL.Free;
  end;
end;

procedure TRbStyleManager.RegisterControl(AControl: TControl);
begin
  FControlList.Add(AControl);
end;

procedure TRbStyleManager.UnRegisterControl(AControl: TControl);
begin

end;

procedure TRbStyleManager.SaveToFile(FileName: string);
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

procedure TRbStyleManager.SetFontColor(const Value: TColor);
begin
  FFontColor := Value;
end;

procedure TRbStyleManager.SetGradientBorder(const Value: boolean);
begin
  FGradientBorder := Value;
end;

procedure TRbStyleManager.SetHotTrack(const Value: boolean);
begin
  FHotTrack := Value;
end;

procedure TRbStyleManager.SetInnerColor(const Value: TColor);
begin
  FInnerColor := Value;
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
begin

end;

end.
