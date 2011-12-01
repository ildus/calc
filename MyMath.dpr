library MyMath;

uses
  Windows, Messages;

function MPI (x,y: Extended): Extended; export;
begin
  Result:=PI;
end;

function MXOR(x, y: Extended): Extended; export;
begin
  Result := trunc(x) xor trunc(y);
end;

function MOR(x, y: Extended): Extended; export;
begin
  Result := trunc(x) or trunc(y);
end;

function MAND(x, y: Extended): Extended; export;
begin
  Result := trunc(x) and trunc(y);
end;

function MMOD(x, y: Extended): Extended; export;
begin
  Result := trunc(x) mod trunc(y);
end;

function MDIV(x, y: Extended): Extended; export;
begin
  Result := trunc(x) div trunc(y);
end;

function MPOWER(x, y: Extended): Extended; export;
begin
  if x = 0 then
    Result := 0
  else if x > 0 then
    Result := exp(y * ln(x))
  else if trunc(y) <> y then begin
    MessageBox(0, 'Ошибка вычисления степени', '',MB_OK);
    Exit;
  end
  else if odd(trunc(y)) = true then
    Result := -exp(y * ln(-x))
  else
    Result := exp(y * ln(-x))
end;

function MSHL(x, y: Extended): Extended; export;
begin
  Result := trunc(x) shl trunc(y);
end;

function MSHR(x, y: Extended): Extended; export;
begin
  Result := trunc(x) shr trunc(y);
end;

function MNOT(x, y: Extended): Extended; export;
begin
  Result := not trunc(x);
end;

function MSINC(x, y: Extended): Extended; export;
begin
  if x = 0 then Result := 1
  else Result := sin(x) / x
end;

function MSINH(x, y: Extended): Extended; export;
begin
  Result := 0.5 * (exp(x) - exp(-x))
end;

function MCOSH(x, y: Extended): Extended; export;
begin
  Result := 0.5 * (exp(x) + exp(-x))
end;

function MTGH(x, y: Extended): Extended; export;
begin
  Result := MSINH(x, 0) / MCOSH(x, 0)
end;

function MCTGH(x, y: Extended): Extended; export;
begin
  Result := MCOSH(x, 0) / MSINH(x, 0)
end;

function MSIN(x, y: Extended): Extended; export;
begin
  Result := sin(x)
end;

function MCOS(x, y: Extended): Extended; export;
begin
  Result := cos(x)
end;

function MTG(x, y: Extended): Extended; export;
begin
  Result := sin(x) / cos(x)
end;

function MCTG(x, y: Extended): Extended; export;
begin
  Result := cos(x) / sin(x)
end;

function MSQRT(x, y: Extended): Extended; export;
begin
  Result  := sqrt(x)
end;

function MSQR(x, y: Extended): Extended; export;
begin
  Result := sqr(x)
end;

function MARCSINH(x, y: Extended): Extended; export;
begin
  Result := ln(x + sqrt(sqr(x) + 1))
end;

function MSGN(x, y: Extended): Extended; export;
begin
  if x = 0 then Result := 0
  else Result := x / abs(x)
end;

function MARCCOSH(x, y: Extended): Extended; export;
begin
  Result := ln(x + MSGN(x, 0) * sqrt(sqr(x) - 1))
end;

function MARCTGH(x, y: Extended): Extended; export;
begin
  Result := ln((1 + x) / (1 - x)) / 2
end;

function MARCCTGH(x, y: Extended): Extended; export;
begin
  Result := ln((1 - x) / (1 + x)) / 2
end;

function MARCSIN(x, y: Extended): Extended; export;
begin
  if x = 1 then Result := pi / 2
  else begin
    if abs(x)<=1 then Result := arctan(x / sqrt(1 - sqr(x)))
    else MessageBox(0,'Параметр арксинуса по модулю больше 1',
      'Ошибка', MB_OK or MB_ICONERROR);
  end;
end;

function MARCCOS(x, y: Extended): Extended; export;
begin
  if abs(x)<=1 then Result := pi / 2 - MARCSIN(x, 0)
  else MessageBox(0,'Параметр арккосинуса по модулю больше 1',
    'Ошибка', MB_OK or MB_ICONERROR);
end;

function MARCTG(x, y: Extended): Extended; export;
begin
  Result := arctan(x)
end;

function MARCCTG(x, y: Extended): Extended; export;
begin
  Result := pi / 2 - arctan(x)
end;

function MFRAC(x, y: Extended): Extended; export;
begin
  Result := frac(x)
end;

function MEXP(x, y: Extended): Extended; export;
begin
  Result := Exp(x)
end;

function MABS(x, y: Extended): Extended; export;
begin
  Result := Abs(x)
end;

function MTRUNC(x, y: Extended): Extended; export;
begin
  Result := trunc(x)
end;

function MLOG(x, y: Extended): Extended; export;
begin
  Result := Ln(y)/Ln(x);
end;

function MLN(x, y: Extended): Extended; export;
begin
  Result := ln(x)
end;

function MPRED(x, y: Extended): Extended; export;
begin
  Result := pred(trunc(x));
end;

function MSUCC(x, y: Extended): Extended; export;
begin
  Result := succ(trunc(x));
end;

function MROUND(x, y: Extended): Extended; export;
begin
  Result := round(x);
end;

function MINT(x, y: Extended): Extended; export;
begin
  Result := int(x);
end;

function MFACT(x, y: Extended): Extended; export;
var
  n: integer;
  r: Extended;
begin
  if x < 0 then begin
    MessageBox(0, 'Невозможно вычислить факториал (Параметр меньше 0)', '', MB_OK);
    Exit;
  end;
  if x = 0 then Result := 1
  else begin
    r := 1;
    for n := 1 to trunc(x) do r := r * n;
    Result := r;
  end;
end;

function MRND(x, y: Extended): Extended; export;
begin
  Result := Random(Trunc(x));
end;

exports
  MAND, MABS, MARCCOS, MARCCOSH, MARCCTG,
  MARCSIN, MARCSINH, MARCTG, MARCTGH, MCOS, MCOSH, MCTG, MCTGH, MDIV,
  MEXP, MFACT, MFRAC, MINT, MLN, MLOG, MMOD, MNOT, MOR, MPOWER, MPRED, MRND,
  MROUND, MSGN, MSHR, MSIN, MSINC, MSINH, MSQR, MSQRT, MSUCC, MTG,
  MTGH, MTRUNC, MXOR, MPI;
begin
end.
 