unit FunctionsUnit;

interface

uses Windows, Messages, Classes, SysUtils, DeCAL;

const MathLibrary = 'MyMath.dll';

type

  TParamsArray = array of Extended;

  TFunction = class
  private
    name: String;
    pcount: Integer;
    function Exec(params: TParamsArray): Extended; virtual; abstract;
  public
    constructor Create; virtual;
    property ParamCount: Integer read pcount;
  end;

  TStandartFunctionOne = class (TFunction)
    function Exec(params: TParamsArray): Extended; override;
  end;

  TStandartFunctionTwo = class (TFunction)
    constructor Create; override;
    function Exec(params: TParamsArray): Extended; override;
  end;

  TFunctionsList = class
  private
    functions: DMap;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Load(folder: String = 'Functions');

    function Call(fname: String; params: TParamsArray): Extended;
    function getFunctionNames(): TStringList;
  end;

  TFunctionClass = class of TFunction;
  EFunctionsError = class (Exception);

function ExecFunction(FName: string; x,y: Extended): Extended;

var FunctionsList: TFunctionsList;

implementation

function ExecFunction(FName: string; x,y: Extended): Extended;
var Func: function (x,y: Extended): Extended;
    hLib: HWND;
begin
    hLib:=LoadLibrary(PChar(MathLibrary));
    fname := AnsiUpperCase(fname);
    if HLib <> 0 then begin
        Func:=GetProcAddress(hLib, PChar(FName));
        if @Func <> nil then
          try
            Result:=Func(x,y);
          except
            on EZeroDivide do raise EFunctionsError.Create('Деление на ноль');
            on E: Exception do raise;
          end
        else
          raise EFunctionsError.Create('В библиотеке нет функции ' +Copy(FName, 2, Length(FName)-1));
    end
    else raise EFunctionsError.CreateFmt('Не найдено библиотеки математических функций (%s)', [MathLibrary]);
    FreeLibrary(hLib); FreeLibrary(hLib);
end;

{ TFunction }

constructor TFunction.Create;
begin
  pcount := 1;
end;

//------------------------------------------------------------------------------


{ TStandartFunctionOne }

function TStandartFunctionOne.Exec(params: TParamsArray): Extended;
var x: Extended;
begin
  x := params[0];
  try
    Result := ExecFunction('m'+self.name, x, 0);
  except
    on E: Exception do
      raise EFunctionsError.CreateFmt('Ошибка во время выполнения функции "%s".'#13#10' %s'
                                        , [name, E.Message]);
  end;
end;

{ TStandartFunctionTwo }

constructor TStandartFunctionTwo.Create;
begin
  inherited;
  pcount := 2;
end;

function TStandartFunctionTwo.Exec(params: TParamsArray): Extended;
var x, y: Extended;
begin
  x := params[0];
  y := params[1];
  try
    Result := ExecFunction('m'+self.name, x, y);
  except
    on E: Exception do
      raise EFunctionsError.CreateFmt('Ошибка во время выполнения функции "%s".'#13#10' %s'
                                        , [name, E.Message]);
  end;
end;

{ TFunctionsList }

function TFunctionsList.Call(fname: String; params: TParamsArray): Extended;
var fc: TFunctionClass;
    func: TFunction;
    iter : DIterator;
begin
  iter := functions.locate([fname]);
  if not AtEnd(iter) then begin
    fc := TFunctionClass(getClass(iter));
    func := fc.Create;
    func.name := fname;
    if func.ParamCount <> Length(params) then
      raise EFunctionsError.CreateFmt('У функции "%s" %d параметр(а)', [fname, func.ParamCount]);
    Result := func.Exec(params);
  end
  else raise EFunctionsError.CreateFmt('Не найдена функция "%s"', [fname]);
end;

constructor TFunctionsList.Create;
begin
  functions := DMap.Create;

  functions.putPair(['SIN', TStandartFunctionOne]);
  functions.putPair(['SINC', TStandartFunctionOne]);
  functions.putPair(['SINH', TStandartFunctionOne]);
  functions.putPair(['ARCSIN', TStandartFunctionOne]);
  functions.putPair(['ARCSINH', TStandartFunctionOne]);

  functions.putPair(['COS', TStandartFunctionOne]);
  functions.putPair(['ARCCOS', TStandartFunctionOne]);
  functions.putPair(['COSH', TStandartFunctionOne]);
  functions.putPair(['ARCCOSH', TStandartFunctionOne]);

  functions.putPair(['TG', TStandartFunctionOne]);
  functions.putPair(['ARCTG', TStandartFunctionOne]);
  functions.putPair(['TGH', TStandartFunctionOne]);
  functions.putPair(['ARCTGH', TStandartFunctionOne]);

  functions.putPair(['CTG', TStandartFunctionOne]);
  functions.putPair(['CTGH', TStandartFunctionOne]);
  functions.putPair(['ARCCTGH', TStandartFunctionOne]);
  functions.putPair(['ARCCTG', TStandartFunctionOne]);

  functions.putPair(['NOT', TStandartFunctionOne]);
  functions.putPair(['SQRT', TStandartFunctionOne]);
  functions.putPair(['SQR', TStandartFunctionOne]);
  functions.putPair(['SGN', TStandartFunctionOne]);

  functions.putPair(['FRAC', TStandartFunctionOne]);
  functions.putPair(['EXP', TStandartFunctionOne]);
  functions.putPair(['ABS', TStandartFunctionOne]);
  functions.putPair(['TRUNC', TStandartFunctionOne]);
  functions.putPair(['INT', TStandartFunctionOne]);

  functions.putPair(['PRED', TStandartFunctionOne]);
  functions.putPair(['SUCC', TStandartFunctionOne]);
  functions.putPair(['ROUND', TStandartFunctionOne]);

  functions.putPair(['XOR', TStandartFunctionTwo]);
  functions.putPair(['OR', TStandartFunctionTwo]);
  functions.putPair(['AND', TStandartFunctionTwo]);
  functions.putPair(['MOD', TStandartFunctionTwo]);
  functions.putPair(['DIV', TStandartFunctionTwo]);
  functions.putPair(['POWER', TStandartFunctionTwo]);
  functions.putPair(['SHL', TStandartFunctionTwo]);
  functions.putPair(['SHR', TStandartFunctionTwo]);

  functions.putPair(['LN', TStandartFunctionOne]);
  functions.putPair(['LOG', TStandartFunctionTwo]);
  functions.putPair(['FACT', TStandartFunctionTwo]);
end;

destructor TFunctionsList.Destroy;
begin
  functions.Free();
  inherited;
end;

function TFunctionsList.getFunctionNames: TStringList;
var iter: DIterator;
begin
  Result := TStringList.Create();
  iter := functions.start();
  SetToKey(iter);
  while not atEnd(iter) do begin
    Result.Add(getString(iter));
    advance(iter);
  end;
end;

procedure TFunctionsList.Load(folder: String);
begin

end;

initialization
  FunctionsList := TFunctionsList.Create;
  FunctionsList.Load();

finalization
  FunctionsList.Free();

end.
