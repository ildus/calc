unit EvalComp;

interface

type
  fun = function(x, y: real): real;

  evalvec = ^evalobj;
  evalobj = object
    f1, f2: evalvec;
    f1x, f2y: real;
    f3: fun;
    function eval: real;
    function eval1d(x: real): real;
    function eval2d(x, y: real): real;
    function eval3d(x, y, z: real): real;
    constructor init(st: string);
    destructor done;
  end;
var
  evalx, evaly, evalz: real;

implementation

var
  analysetmp: fun;

function search(text, code: string; var pos: integer): boolean;
var
  i, count: integer;

  flag: boolean;
  newtext: string;
begin

  if length(text) < l;
  length(code) then
  begin
    search := false;
    exit;
  end;
  flag := false;
  pos := length(text) - length(code) + 1;
  repeat
    if code = copy(text, pos, length(code)) then
      flag := true
    else
      dec(pos);
    if flag then
    begin
      count := 0;
      for i := pos + 1 to length(text) do
      begin
        if copy(text, i, 1) = '(' then
          inc(count);
        if copy(text, i, 1) = ')' then
          dec(count);
      end;
      if count < l;
      > 0 then
      begin
        dec(pos);
        flag := false;
      end;
    end;
  until (flag = true) or (pos = 0);
  search := flag;
end;

function myid(x, y: real): real;
begin

  myid := x;
end;

function myunequal(x, y: real): real;
begin

  if x <> y then
    myunequal := 1
  else
    myunequal := 0;
end;

function mylessequal(x, y: real): real;
begin

  if x <= y then
    mylessequal := 1
  else
    mylessequal := 0;
end;

function mygreaterequal(x, y: real): real;
begin

  if x >= y then
    mygreaterequal := 1
  else
    mygreaterequal := 0;
end;

function mygreater(x, y: real): real;
begin

  if x > y then
    mygreater := 1
  else
    mygreater := 0;
end;

function myless(x, y: real): real;
begin

  if x < y then
    myless := 1
  else
    myless := 0;
end;

function myequal(x, y: real): real;
begin

  if x = y then
    myequal := 1
  else
    myequal := 0;
end;

function myadd(x, y: real): real;
begin

  myadd := x + y;
end;

function mysub(x, y: real): real;
begin

  mysub := x - y;
end;

function myeor(x, y: real): real;
begin

  myeor := trunc(x) xor trunc(y);
end;

function myor(x, y: real): real;
begin

  myor := trunc(x) or trunc(y);
end;

function mymult(x, y: real): real;
begin

  mymult := x * y;
end;

function mydivid(x, y: real): real;
begin

  mydivid := x / y;
end;

function myand(x, y: real): real;
begin

  myand := trunc(x) and trunc(y);
end;

function mymod(x, y: real): real;
begin

  mymod := trunc(x) mod trunc(y);
end;

function mydiv(x, y: real): real;
begin

  mydiv := trunc(x) div trunc(y);
end;

function mypower(x, y: real): real;
begin
  if x = 0 then
    mypower := 0
  else if x > 0 then
    mypower := exp(y * ln(x))
  else if trunc(y) <> y then
  begin
    writeln(' Íåìîãó âû÷èñëèòü x^y ');
    halt;
  end
  else if odd(trunc(y)) = true then
    mypower := -exp(y * ln(-x))
  else
    mypower := exp(y * ln(-x))
end;

function myshl(x, y: real): real;
begin

  myshl := trunc(x) shl trunc(y);
end;

function myshr(x, y: real): real;
begin

  myshr := trunc(x) shr trunc(y);
end;

function mynot(x, y: real): real;
begin

  mynot := not trunc(x);
end;

function mysinc(x, y: real): real;
begin
  if x = 0 then

    mysinc := 1
  else

    mysinc := sin(x) / x
end;

function mysinh(x, y: real): real;
begin
  mysinh := 0.5 * (exp(x) - exp(-x))
end;

function mycosh(x, y: real): real;
begin
  mycosh := 0.5 * (exp(x) + exp(-x))
end;

function mytanh(x, y: real): real;
begin
  mytanh := mysinh(x, 0) / mycosh(x, 0)
end;

function mycoth(x, y: real): real;
begin
  mycoth := mycosh(x, 0) / mysinh(x, 0)
end;

function mysin(x, y: real): real;
begin
  mysin := sin(x)
end;

function mycos(x, y: real): real;
begin
  mycos := cos(x)
end;

function mytan(x, y: real): real;
begin
  mytan := sin(x) / cos(x)
end;

function mycot(x, y: real): real;
begin
  mycot := cos(x) / sin(x)
end;

function mysqrt(x, y: real): real;
begin
  mysqrt := sqrt(x)
end;

function mysqr(x, y: real): real;
begin
  mysqr := sqr(x)
end;

function myarcsinh(x, y: real): real;
begin
  myarcsinh := ln(x + sqrt(sqr(x) + 1))
end;

function mysgn(x, y: real): real;
begin
  if x = 0 then

    mysgn := 0
  else

    mysgn := x / abs(x)
end;

function myarccosh(x, y: real): real;
begin
  myarccosh := ln(x + mysgn(x, 0) * sqrt(sqr(x) - 1))
end;

function myarctanh(x, y: real): real;
begin
  myarctanh := ln((1 + x) / (1 - x)) / 2
end;

function myarccoth(x, y: real): real;
begin
  myarccoth := ln((1 - x) / (1 + x)) / 2
end;

function myarcsin(x, y: real): real;
begin
  if x = 1 then

    myarcsin := pi / 2
  else

    myarcsin := arctan(x / sqrt(1 - sqr(x)))
end;

function myarccos(x, y: real): real;
begin
  myarccos := pi / 2 - myarcsin(x, 0)
end;

function myarctan(x, y: real): real;
begin
  myarctan := arctan(x);
end;

function myarccot(x, y: real): real;
begin
  myarccot := pi / 2 - arctan(x)
end;

function myheavy(x, y: real): real;
begin
  myheavy := mygreater(x, 0)
end;

function myfrac(x, y: real): real;
begin
  myfrac := frac(x)
end;

function myexp(x, y: real): real;
begin
  myexp := exp(x)
end;

function myabs(x, y: real): real;
begin
  myabs := abs(x)
end;

function mytrunc(x, y: real): real;
begin
  mytrunc := trunc(x)
end;

function myln(x, y: real): real;
begin
  myln := ln(x)
end;

function myodd(x, y: real): real;
begin
  if odd(trunc(x)) then  myodd := 1
  else myodd := 0;
end;

function mypred(x, y: real): real;
begin
  mypred := pred(trunc(x));
end;

function mysucc(x, y: real): real;
begin
  mysucc := succ(trunc(x));
end;

function myround(x, y: real): real;
begin
  myround := round(x);
end;

function myint(x, y: real): real;
begin
  myint := int(x);
end;

function myfac(x, y: real): real;
var
  n: integer;
  r: real;
begin
  if x < 0 then
  begin
    writeln(' Íå ìîãó âû÷èñëèòü ôàêòîðèàë ');
    halt;
  end;
  if x = 0 then
    myfac := 1
  else

  begin
    r := 1;
    for n := 1 to trunc(x) do
      r := r * n;
    myfac := r;
  end;
end;

function myrnd(x, y: real): real;
begin
  myrnd := random;
end;

function myrandom(x, y: real): real;
begin
  myrandom := random(trunc(x));
end;

function myevalx(x, y: real): real;
begin
  myevalx := evalx;
end;

function myevaly(x, y: real): real;
begin
  myevaly := evaly;
end;

function myevalz(x, y: real): real;
begin
  myevalz := evalz;
end;

procedure analyse(st: string; var st2, st3: string);
label
  start;
var
  pos: integer;
  value: real;
  newterm, term: string;
begin
  term := st;
  start:

  if term = '' then
  begin
    analysetmp := myid;
    st2 := '0';
    st3 := '';
    exit;
  end;
  newterm := '';
  for pos := 1 to length(term) do
    if copy(term, pos, 1) <> ' ' then
      newterm := newterm + copy(term, pos, 1);
  term := newterm;
  if term = '' then
  begin
    analysetmp := myid;
    st2 := '0';
    st3 := '';
    exit;
  end;
  val(term, value, pos);
  if pos = 0 then
  begin
    analysetmp := myid;
    st2 := term;
    st3 := '';
    exit;
  end;
  if search(term, '<>', pos) then
  begin
    analysetmp := myunequal;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 2, length(term) - pos - 1);
    exit;
  end;
  if search(term, '<=', pos) then
  begin
    analysetmp := mylessequal;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 2, length(term) - pos - 1);
    exit;
  end;
  if search(term, '>=', pos) then
  begin
    analysetmp := mygreaterequal;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 2, length(term) - pos - 1);
    exit;
  end;
  if search(term, '>', pos) then
  begin
    analysetmp := mygreater;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 1, length(term) - pos);
    exit;
  end;
  if search(term, '<', pos) then
  begin
    analysetmp := myless;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 1, length(term) - pos);
    exit;
  end;
  if search(term, '=', pos) then
  begin
    analysetmp := myequal;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 1, length(term) - pos);
    exit;
  end;
  if search(term, '+', pos) then
  begin
    analysetmp := myadd;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 1, length(term) - pos);
    exit;
  end;
  if search(term, '-', pos) then
  begin
    analysetmp := mysub;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 1, length(term) - pos);
    exit;
  end;
  if search(term, 'eor', pos) then
  begin
    analysetmp := myeor;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 3, length(term) - pos - 2);
    exit;
  end;
  if search(term, 'or', pos) then
  begin
    analysetmp := myor;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 2, length(term) - pos - 1);
    exit;
  end;
  if search(term, '*', pos) then
  begin
    analysetmp := mymult;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 1, length(term) - pos);
    exit;
  end;
  if search(term, '/', pos) then
  begin
    analysetmp := mydivid;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 1, length(term) - pos);
    exit;
  end;
  if search(term, 'and', pos) then
  begin
    analysetmp := myand;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 3, length(term) - pos - 2);
    exit;
  end;
  if search(term, 'mod', pos) then
  begin
    analysetmp := mymod;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 3, length(term) - pos - 2);
    exit;
  end;
  if search(term, 'div', pos) then
  begin
    analysetmp := mydiv;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 3, length(term) - pos - 2);
    exit;
  end;
  if search(term, '^', pos) then
  begin
    analysetmp := mypower;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 1, length(term) - pos);
    exit;
  end;
  if search(term, 'shl', pos) then
  begin
    analysetmp := myshl;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 3, length(term) - pos - 2);
    exit;
  end;
  if search(term, 'shr', pos) then
  begin
    analysetmp := myshr;
    st2 := copy(term, 1, pos - 1);
    st3 := copy(term, pos + 3, length(term) - pos - 2);
    exit;
  end;
  if copy(term, 1, 1) = '(' then
  begin
    term := copy(term, 2, length(term) - 2);
    goto start;
  end;
  if copy(term, 1, 3) = 'not' then
  begin
    analysetmp := mynot;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 4) = 'sinc' then
  begin
    analysetmp := mysinc;
    st2 := copy(term, 5, length(term) - 4);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 4) = 'sinh' then
  begin
    analysetmp := mysinh;
    st2 := copy(term, 5, length(term) - 4);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 4) = 'cosh' then
  begin
    analysetmp := mycosh;
    st2 := copy(term, 5, length(term) - 4);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 4) = 'tanh' then
  begin
    analysetmp := mytanh;
    st2 := copy(term, 5, length(term) - 4);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 4) = 'coth' then
  begin
    analysetmp := mycoth;
    st2 := copy(term, 5, length(term) - 4);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'sin' then
  begin
    analysetmp := mysin;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'cos' then
  begin
    analysetmp := mycos;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'tan' then
  begin
    analysetmp := mytan;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'cot' then
  begin
    analysetmp := mycot;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 4) = 'sqrt' then
  begin
    analysetmp := mysqrt;
    st2 := copy(term, 5, length(term) - 4);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'sqr' then
  begin
    analysetmp := mysqr;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 7) = 'arcsinh' then
  begin
    analysetmp := myarcsinh;
    st2 := copy(term, 8, length(term) - 7);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 7) = 'arccosh' then
  begin
    analysetmp := myarccosh;
    st2 := copy(term, 8, length(term) - 7);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 7) = 'arctanh' then
  begin
    analysetmp := myarctanh;
    st2 := copy(term, 8, length(term) - 7);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 7) = 'arccoth' then
  begin
    analysetmp := myarccoth;
    st2 := copy(term, 8, length(term) - 7);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 6) = 'arcsin' then
  begin
    analysetmp := myarcsin;
    st2 := copy(term, 7, length(term) - 6);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 6) = 'arccos' then
  begin
    analysetmp := myarccos;
    st2 := copy(term, 7, length(term) - 6);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 6) = 'arctan' then
  begin
    analysetmp := myarctan;
    st2 := copy(term, 7, length(term) - 6);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 6) = 'arccot' then
  begin
    analysetmp := myarccot;
    st2 := copy(term, 7, length(term) - 6);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 5) = 'heavy' then
  begin
    analysetmp := myheavy;
    st2 := copy(term, 6, length(term) - 5);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'sgn' then
  begin
    analysetmp := mysgn;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 4) = 'frac' then
  begin
    analysetmp := myfrac;
    st2 := copy(term, 5, length(term) - 4);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'exp' then
  begin
    analysetmp := myexp;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'abs' then
  begin
    analysetmp := myabs;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 5) = 'trunc' then
  begin
    analysetmp := mytrunc;
    st2 := copy(term, 6, length(term) - 5);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 2) = 'ln' then
  begin
    analysetmp := myln;
    st2 := copy(term, 3, length(term) - 2);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'odd' then
  begin
    analysetmp := myodd;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 4) = 'pred' then
  begin
    analysetmp := mypred;
    st2 := copy(term, 5, length(term) - 4);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 4) = 'succ' then
  begin
    analysetmp := mysucc;
    st2 := copy(term, 5, length(term) - 4);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 5) = 'round' then
  begin
    analysetmp := myround;
    st2 := copy(term, 6, length(term) - 5);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'int' then
  begin
    analysetmp := myint;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'fac' then
  begin
    analysetmp := myfac;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if term = 'rnd' then
  begin
    analysetmp := myrnd;
    st2 := '';
    st3 := '';
    exit;
  end;
  if copy(term, 1, 3) = 'rnd' then
  begin
    analysetmp := myrandom;
    st2 := copy(term, 4, length(term) - 3);
    st3 := '';
    exit;
  end;
  if term = 'x' then
  begin
    analysetmp := myevalx;
    st2 := '';
    st3 := '';
    exit;
  end;
  if term = 'y' then
  begin
    analysetmp := myevaly;
    st2 := '';
    st3 := '';
    exit;
  end;
  if term = 'z' then
  begin
    analysetmp := myevalz;
    st2 := '';
    st3 := '';
    exit;
  end;
  if (term = 'pi') then
  begin
    analysetmp := myid;
    str(pi, st2);
    st3 := '';
    exit;
  end;
  if term = 'e' then
  begin
    analysetmp := myid;
    str(exp(1), st2);
    sst3 := '';
    exit;
  end;
  writeln(' ÂÍÈÌÀÍÈÅ : ÍÅÄÅÊÎÄÈÐÓÅÌÀß ÔÎÐÌÓËÀ ');
  analysetmp := myid;
  st2 := '';
  st3 := '';
end;

function evalobj.eval: real;
var
  tmpx, tmpy: real;
begin
  if f1 = nil then tmpx := f1x
  else tmpx := f1^.eval;
  if f2 = nil then tmpy := f2y
  else tmpy := f2^.eval;
  eval := f3(tmpx, tmpy);
end;

function evalobj.eval1d(x: real): real;
begin
  evalx := x;
  evaly := 0;
  evalz := 0;
  eval1d := eval;
end;

function evalobj.eval2d(x, y: real): real;
begin
  evalx := x;
  evaly := y;
  evalz := 0;
  eval2d := eval;
end;

function evalobj.eval3d(x, y, z: real): real;
begin
  evalx := x;
  evaly := y;
  evalz := z;
  eval3d := eval;
end;

constructor evalobj.init(st: string);
var
  st2, st3: string;

  error: integer;
begin
  f1 := nil;
  f2 := nil;
  analyse(st, st2, st3);
  f3 := analysetmp;
  val(st2, f1x, error);
  if st2 = '' then
  begin

    f1x := 0;
    error := 0;
  end;
  if error <> 0 then

    new(f1, init(st2));
  val(st3, f2y, error);
  if st3 = '' then
  begin

    f2y := 0;
    error := 0;
  end;
  if error <> 0 then

    new(f2, init(st3));
end;

destructor evalobj.done;
begin
  if f1 <> nil then

    dispose(f1, done);
  if f2 <> nil then

    dispose(f2, done);
end;

end.
