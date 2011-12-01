unit Common_Utils;

interface

uses Windows, Messages, Graphics, SysUtils, StrUtils, Math;

function  GetCaptionHeight: Integer;
function  GetScrollWidth: Integer;
function  GetClipText: String;
function  SetClipText( const S: String ): Boolean;

function CheckThisProgram: boolean;
//сокращает выражение. Например (5+5) = 10 на (5+ ... = 10
function Shorten(S: String; Canvas: TCanvas; Width: Integer): String;

function DecimalToXStr (aBase : Byte; Precision : Byte; aVal : Extended) : String;
function XcimalStrToNumber(aStrXcimal : String; aBase : Byte) : Extended;
function XcimalStrToYcimalStr (aSrcBase : Byte; aSrcNumStr : String; aTrgBase : Byte; aTrgPrecision : Byte) : String;

type ENTConversionError = class (Exception);

implementation

function CheckThisProgram: boolean;
var
  HM: THandle;
begin
  HM := OpenMutex(MUTEX_ALL_ACCESS, false, 'CalcMainMutex');
  Result := (HM <> 0);
  if HM = 0 then CreateMutex(nil, false, 'CalcMainMutex');
end;

function Shorten(S: String; Canvas: TCanvas; Width: Integer): String;
var W, P, MaxW, i: Integer;

    Res: String;
    Expr: String;
begin
    W:=Canvas.TextWidth(S);
    if W<Width then Result:=S
    else begin
      P:=Pos('=', S);
      if P<>0 then begin
        Res:=Trim(Copy(S, P+1, Length(S) - P +1));
        Delete(S, P, Length(S) - P+1);
      end;
      Expr:=Trim(S);
      MaxW:=Width - Canvas.TextWidth(' = '+Res)- GetScrollWidth - 5;
      Result:='... = '+Res;
      for i:=1 to Length(Expr) do
        if Canvas.TextWidth(Copy(S, 1, i)+'...')<MaxW then
          Result:=Copy(S, 1, i)+'... = '+Res;
    end;
end;

function GetScrollWidth: Integer;
var Metrics: TNonClientMetrics;
begin
   Metrics.cbSize:=SizeOf(TNonClientMetrics);
   SystemParametersInfo(SPI_GETNONCLIENTMETRICS, Metrics.cbSize,@Metrics, 0);
   Result:=Metrics.iScrollWidth;
end;

function GetCaptionHeight: Integer;
var Metrics: TNonClientMetrics;
begin
   Metrics.cbSize:=SizeOf(TNonClientMetrics);
   SystemParametersInfo(SPI_GETNONCLIENTMETRICS, Metrics.cbSize,@Metrics, 0);
   Result:=Metrics.iCaptionHeight;
end;

function GetClipText: String;
var gbl: THandle;
    str: PChar;
begin
  Result := '';
  if OpenClipboard( 0 ) then
  begin
    if IsClipboardFormatAvailable( CF_TEXT ) then
    begin
      gbl := GetClipboardData( CF_TEXT );
      if gbl <> 0 then
      begin
        str := GlobalLock( gbl );
        if str <> nil then
        begin
          Result := str;
          GlobalUnlock( gbl );
        end;
      end;
    end;
    CloseClipboard;
  end;
end;

function SetClipText( const S: String ): Boolean;
var gbl: THandle;
    str: PChar;
begin
  Result := False;
  if not OpenClipboard( 0 ) then Exit;
  EmptyClipboard;
  if S <> '' then
  begin
    gbl := GlobalAlloc( GMEM_DDESHARE, Length( S ) + 1 );
    if gbl <> 0 then
    begin
      str := GlobalLock( gbl );
      Move( S[ 1 ], str^, Length( S ) + 1 );
      GlobalUnlock( gbl );
      Result := SetClipboardData( CF_TEXT, gbl ) <> 0;
    end;
  end
    else
      Result := True;
  CloseClipboard;
end;

function ss_toDec(chislo : string; osnovanie : byte) : integer;
const hash_tableU : string = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      hash_tableL : string = '0123456789abcdefghijklmnopqrstuvwxyz';
var   otvet : integer;
      p, i  : integer;
begin
  otvet := 0;
  for i:= 1 to length(chislo) do
  begin
    p := pos(chislo[i], hash_tableu);
    if p=0 then p := pos(chislo[i], hash_tablel);
    if p in [1..osnovanie] then
      otvet := (otvet * osnovanie) + (p-1)
    else
    begin
      { нам встретился неверный символ }
      exit;
    end;
  end;
  { возвращаем результат }
  ss_toDec := otvet;
end; { ss_decTo() }
 
{/ ************************************************************************* //
//
// Функция   : ss_DecTo.
// Описание  : конвертирование числа из бинарного в строковое представление
//             с одновременным конвертированием в указанную СС.
// Параметры : chislo    - число, бинарном представлении;
//             osnovanie - основание CC в которую нужно сконвертировать
//               число.
/}
function ss_DecTo(chislo : integer; osnovanie : byte) : string;
const hash_table : string = '0123456789abcdefghijklmnopqrstuvwxyz';
var   otvet : string;
      t, i  : integer;
begin
  otvet := '';
  while chislo >= osnovanie do
  begin
    otvet  := hash_table[(chislo mod osnovanie)+1] + otvet;
    chislo := chislo div osnovanie;
  end;
  if chislo=osnovanie then
    otvet  := hash_table[chislo] + otvet
  else
    otvet  := hash_table[chislo + 1] + otvet;
  ss_DecTo := otvet;
end;

//Определяет какая цифра соответствует числу.
function IntToDigit(aNum : Byte) : String;
const
  SelfName : String = 'IntToDigit.';
begin
  case aNum of
    0..9 : Result := IntToStr(aNum);
    10   : Result := 'A';
    11   : Result := 'B';
    12   : Result := 'C';
    13   : Result := 'D';
    14   : Result := 'E';
    15   : Result := 'F';
  else
    Raise ENTConversionError.Create(SelfName + ' Числу не сопоставлена цифра!');
  end;
end;

function DecimalToXStr (aBase : Byte; Precision : Byte; aVal : Extended) : String;
var
  Val : Extended;
  IntVal : Int64;
  FracVal : Extended;
  StrInt : String;
  StrFrac : String;
  i : Integer;
begin
  // Получаем целую и дробную части числа.
  IntVal := Trunc(aVal);
  FracVal := Frac(aVal);
 
  //Переводим целую часть.
  StrInt := '';
  repeat
    StrInt := IntToDigit(IntVal mod aBase) + StrInt;
    IntVal := IntVal div aBase;
  until IntVal = 0;
 
  // Если дробная часть = 0, то перевод закончен.
  if FracVal = 0 then begin
    Result := StrInt;
    exit;
  end;
 
  //Переводим дробную часть. Точность - до Precision цифр после запятой.
  StrFrac := '';
  for i := 1 to Precision do begin
    Val := FracVal * aBase;
    StrFrac := StrFrac + IntToDigit(Trunc(Val));
    FracVal := Frac(Val);
    //Если дробная часть = 0, то перевод закончен.
    if FracVal = 0 then Break;
  end;
 
  Result := StrInt + ',' + StrFrac;
 
end;


 
//Определяет какое число соответствует цифре.
function DigitToInt(aDigit : AnsiChar; aBase : Byte) : Byte;
const
  SelfName : String = 'DigitToInt.';
begin
  if aBase < 2 then
    Raise ENTConversionError.Create(SelfName + ' Основание системы счисления должно быть >= 2!');
  case aDigit of
    '0'..'9' : Result := StrToInt(aDigit);
    'A', 'a' : Result := 10;
    'B', 'b' : Result := 11;
    'C', 'c' : Result := 12;
    'D', 'd' : Result := 13;
    'E', 'e' : Result := 14;
    'F', 'f' : Result := 15;
  else
    Raise ENTConversionError.Create(SelfName + ' Неизвестный символ в представлении числа!');
  end;
  if Result > aBase - 1 then
    Raise ENTConversionError.Create(SelfName + ' В данной системе счисления нет такой цифры!');
end;
 
//По записи числа в системе счисления с онованием aBase, определяет само это число.
function XcimalStrToNumber(aStrXcimal : String; aBase : Byte) : Extended;
const
  SelfName : String = 'XcimalStrToNumber.';
var
  i, j      : Integer;
  StrInt    : String;
  StrFrac   : String;
  Pos1      : Integer;
 
  IntPart    : Extended;
  FracPart   : Extended;
begin
  if Length(aStrXcimal) = 0 then
    Raise ENTConversionError.Create(SelfName + ' Не задано число!')
  ;
 
  //Ищем десятичную точку. Она у нас обозначается знаком запятая: ','.
  Pos1 := Pos(DecimalSeparator, aStrXcimal);
 
  //Определяем подстроку с записью целой части числа
  //и подстроку с записью дробной части.
  if Pos1 = 0 then begin
    //Значит число состоит только из целой части.
    StrInt := aStrXcimal;
    StrFrac := '';
  end else begin
    //Число имеет целую и дробную части.
    StrInt := LeftStr(aStrXcimal, Pos1 - 1);
    StrFrac := Copy(aStrXcimal, Pos1 + 1, Length(aStrXcimal) - Pos1);
  end;
 
  //Определяем значение целой части числа.
  IntPart := 0;
  for i := 1 to Length(StrInt) do begin
    //Порядок разряда = позиции разряда при отсчёте от нуля в направлении справа налево.
    j := Length(StrInt) - i;
    IntPart := IntPart + DigitToInt(StrInt[i], aBase) * Power(aBase, j);
  end;
 
  //Определяем значение дробной части числа.
  //В начале вычисляем значение аналогично тому, как это сделано для целой части:
  FracPart := 0;
  for i := 1 to Length(StrFrac) do begin
    j := Length(StrFrac) - i;
    FracPart := FracPart + DigitToInt(StrFrac[i], aBase) * Power(aBase, j);
  end;
  //Теперь учитываем экспоненциальную часть:
  FracPart := FracPart / Power(aBase, Length(StrFrac));
 
  //Получаем число, которое соответствует записи aStrXcimal
  //в системе счисления с основанием aBase.
  Result := IntPart + FracPart;
 
end;
 
//Преобразует запись числа в системе счисления с основанием aSrcBase в запись
//этого же числа в системе счисления с онованием aTrgBase.
//Преобразование производится с точностью до aTrgPrecision цифр после запятой
//в результирующем представлении числа.
function XcimalStrToYcimalStr (
  aSrcBase : Byte;
  aSrcNumStr : String;
  aTrgBase : Byte;
  aTrgPrecision : Byte
) : String;
var
  //Число соответствующее записи aSrcNumStr в системе счисления с основанием aSrcBase.
  SrcNum : Extended;
  //Целая часть, выделенная из числа SrcNum.
  IntPart : Int64;
  //Дробная часть, выделенная из числа SrcNum.
  FracPart : Extended;
  //Представление целой части числа SrcNum в системе счисления с основанием aTrgBase.
  StrInt : String;
  //Представление дробной части числа SrcNum в системе счисления с основанием aTrgBase.
  StrFrac : String;
  //Счетчик.
  i : Integer;
  //Для промежуточных вычислений.
  TempNum : Extended;
begin
 
  //Исходное число.
  SrcNum := XcimalStrToNumber(aSrcNumStr, aSrcBase);
 
  // Получаем целую и дробную части числа.
  IntPart := Trunc(SrcNum);
  FracPart := Frac(SrcNum);
 
  //Переводим целую часть.
  StrInt := '';
  repeat
    StrInt := IntToDigit(IntPart mod aTrgBase) + StrInt;
    IntPart := IntPart div aTrgBase;
  until IntPart = 0;
 
  // Если дробная часть = 0, то перевод закончен.
  if FracPart = 0 then begin
    Result := StrInt;
    exit;
  end;
 
  //Переводим дробную часть. Точность - до aTrgPrecision цифр после запятой.
  StrFrac := '';
  for i := 1 to aTrgPrecision do begin
    TempNum := FracPart * aTrgBase;
    StrFrac := StrFrac + IntToDigit(Trunc(TempNum));
    FracPart := Frac(TempNum);
    //Если дробная часть = 0, то перевод закончен.
    if FracPart = 0 then Break;
  end;
 
  Result := StrInt + DecimalSeparator + StrFrac; 
end;

end.
