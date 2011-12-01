unit MathExpression;

interface

uses Windows, Classes, SysUtils, FunctionsUnit, DeCAL;

const Brackets: set of char = ['(',')'];
      Delims: set of char = ['+','-','/','*','%','^','!','&',';'];
      Latin: set of char = ['A'..'Z','a'..'z', '_'];
      LatinEx: set of char = ['A'..'Z','a'..'z', '0'..'9'];
      Numbers: set of char = ['0'..'9','.',','];
      NumbersEx: set of char = ['0'..'9','.',',','A'..'F','a'..'f'];

var LongDelims: DSet;
    Trigs: DSet;

type

  TNumberType = (ntDec = 10, ntHex=16, ntBin=2, ntOct=8);

  TMathAnalyzer = class
  private
    CurPos: Cardinal;               //��������� ��������� ������
    Token, PrevToken, FErrorText: String;     //������� � ���������� ������
    TokenType: Integer;      //���� ������
    function GetToken: String; //������� ��������� �����
    procedure Level2(var Res: Extended); //������� 1  - (+-)  ������
    procedure Level3(var Res: Extended); //... 2        (*/%&) ��������
    procedure Level4(var Res: Extended); //... 3        (^)
    procedure Level5(var Res: Extended); //... 4        ������� (+-)
    procedure Level6(var Res: Extended); //... 5        ������
    procedure Primitive(var Res: Extended); //... 7     ����� ��� �������
    //procedure SetErrorText(ErrText: string);
    procedure Arith(O: String; var r,h: Extended);
    //��������� ������� �� �������������� ����������
    function  CheckBrackets(B, E: Word): Boolean;
    function  GetVariable(VName: String): Extended;
    procedure Factorial(var Res: Extended);
    function FromNumberType(Value: String): Extended; //���������� ���������������� ��������
  public
    ErrorPosition: integer;
    Radian: boolean;              //���� True, �� ���-�� ��������, ����� �������
    Expression: AnsiString;       //����� ����������� �������
    Answer: Extended;             //�������� �����
    Variables: ^TStringList;      //���������� � ���� ������
    InNumberType: TNumberType;      //������� ���������, � �������
    //��������� ����������
    procedure Evaluate;
    constructor Create;
  end;

  EMathAnalyzerError = class (Exception);

function GetType(c: Char): byte;
function FormatData(s: Extended; i: Integer): Extended;
procedure ChangeSeparator(var Variable: String);

implementation

uses MyStack, Utils, Common_Utils;

const FUNC = 1;      //�������
      DELIMITER = 2; //�����������
      NUMBER = 3;    //�����
      FINISH = 4;    //����� ������

//����� �������

//����������
function FormatData(S: Extended; I: Integer): Extended;
begin
  Result:=Round(S*Exp(I*Ln(10)))/(Exp(I*Ln(10)));
end;

{TMathAnalyzer}

//������ ������� � ����� � ����������� �� ��������� ����������
procedure ChangeSeparator(var Variable: String);
var p: integer;
begin
  p:=Pos('.', Variable);
  if p = 0 then p:=Pos(',',Variable);
  if p<>0 then Variable[p]:=DecimalSeparator;
end;

function GetType(c: Char): byte;
begin
  Result:=0;
  if c in Numbers then Result:=NUMBER
  else
    if c in Latin then Result:=FUNC
      else if (c in Delims+Brackets) then Result:=DELIMITER;
end;

//������� �������

function TMathAnalyzer.GetVariable(VName: String): Extended;
var Value: string;
begin
  Variables.NameValueSeparator:='=';
  Value:=Variables.Values[VName];
  if Value = '' then raise EMathAnalyzerError.Create('���������� "'+VName+'" �� ����������')
  else begin
    ChangeSeparator(Value);
    try
      Result:=StrToFloat(Value);
    except
      raise EMathAnalyzerError.Create('������� ������ �������� ����������');
    end;
  end;
end;

//������� �����������

//���������� ��������� �����
function TMathAnalyzer.GetToken: String;
begin
    PrevToken:=Token; Token:=''; Result:='';
    if (Length(Expression)<=CurPos-1) then begin
      TokenType:=FINISH;
      Exit
    end;    
    while GetType(Expression[CurPos]) = 0 do Inc(CurPos);  // ������� ��������
    TokenType:=GetType(Expression[CurPos]);
    case TokenType of
        DELIMITER: begin
                      Token:=Expression[CurPos];
                      Inc(CurPos);
                   end;
        NUMBER:    begin
                        while Expression[CurPos] in NumbersEx do begin
                          Token:=Token+Expression[CurPos];
                          Inc(CurPos);
                        end;
                        
                   end;
        FUNC:      begin // ���������� ��� �������
                      while Expression[CurPos] in LatinEx do begin
                        Token := Token + Expression[CurPos];
                        Inc(CurPos);
                      end;
                      Token:=AnsiUpperCase(Token);
                      if LongDelims.includes([Token]) then TokenType:=DELIMITER;
                   end;
    end;
    Token:=AnsiUpperCase(Token);
    Result:=Token;
end;

//�������� ������������ ������
function TMathAnalyzer.CheckBrackets(B, E: Word): boolean;
var i: integer;
    LastPosition: integer;
begin
  Result:=false; LastPosition:=0;
  for i:=B to E do begin
    if Expression[i] = '(' then begin
      LastPosition:=i;
      Push('(');
    end;
    if Expression[i] = ')' then
      if Pop <> '(' then
        raise EMathAnalyzerError.Create('������ ����������� ������ � ������� '+IntToStr(i));
    if (i = E) then
      if (Pop = #0) then begin
        Result:=true;
        Exit;
      end;
  end;
  raise EMathAnalyzerError.Create('������ ����������� ������ � ������� '+IntToStr(LastPosition));
end;

//����� ���������� ����������� �������
procedure TMathAnalyzer.Evaluate;
begin
  CurPos:=1;
  if(GetToken = '') then raise EMathAnalyzerError.Create('')
  else
    if CheckBrackets(1, Length(Expression)) then begin
        Answer:=0;
        Level2(Answer);
    end;
end;

//�������� ��� ��������� ���� ������
procedure TMathAnalyzer.Level2(var Res: Extended);
var Hold: Extended;
    Operator: string;
begin
  Hold:=0; Level3(Res);
  while ((Token='+') or (Token = '-')) do begin
    Operator:=Token;
    GetToken;
    Level3(Hold);
    Arith(Operator, Res, Hold);
  end;
end;

//���������� ������������ ��� �������� ���� ��������
procedure TMathAnalyzer.Level3(var Res: Extended);
var Operator: String;
    Hold: Extended;
begin
  Hold:=0; Level4(Res);
  while ((Token = '*') or (Token = '/')
      or (LongDelims.includes([Token])))  do begin
    Operator:=Token;
    GetToken;
    Level4(Hold);
    Arith(Operator,Res,Hold);
  end;
end;

//��������� ������� ����� (�������������)
procedure TMathAnalyzer.Level4(var Res: Extended);
var Hold: Extended;
begin
  Level5(Res);
  if (Token = '^') then begin
    GetToken;
    Level4(Hold);
    Arith('^', Res, Hold);
  end;
end;

//������� + ��� -
procedure TMathAnalyzer.Level5(var Res: Extended);
var Op: String;
begin
  op := #0;
  if (TokenType=DELIMITER) then
    if (Token = '+') or (Token = '-') then begin
      if (CurPos = 2) or (PrevToken ='(') then op := Token
      else
        raise EMathAnalyzerError.Create('������������ ������������ �������� ���������');
      GetToken;
  end;
  Level6(Res);
  if (op = '-') then Res:= - Res;
end;

procedure TMathAnalyzer.Factorial(var Res: Extended);
begin
  Res := ExecFunction('MFACT', Res, 0);
  GetToken;
end;

//��������� ��������� � ������� �������
procedure TMathAnalyzer.Level6(var Res: Extended);
begin
  if (token = '(') and (TokenType = DELIMITER) then begin
    GetToken;
    Level2(Res);
    GetToken;
    if Token = '!' then Factorial(Res);
  end
  else Primitive(res);
end;

//����������� �������� ���������� �� �� ����� � ���������� �������
procedure TMathAnalyzer.Primitive(var res: Extended);
var FName, num: string;
    x,y: Extended;
    params: TParamsArray;
    len: Integer;
begin
  x:=0; y:=0; Res:=0; num := '';
  case (TokenType) of
    NUMBER: try
        while TokenType = NUMBER do begin
          num := num+Token;
          GetToken();
        end;
        ChangeSeparator(num);
        Res  := FromNumberType(num);
        if Token = '!' then Factorial(Res);
      except
        on EConvertError do
          raise EMathAnalyzerError.Create('������ ��� ����� �����');
        else raise;
    end;
    FUNC: begin
      while TokenType = FUNC do begin
        FName:= FName+Token;
        GetToken();
      end;
      if Token = '(' then begin
        //��� �������
        repeat
          GetToken;
          Level2(x);
          if (not Radian) and (trigs.includes([FName])) then x:=x*(PI/180);
          len := Length(params);
          SetLength(params, len+1);
          params[len] := x;
        until Token<>';';

        if (Token<>')') then
          raise EMathAnalyzerError.CreateFmt('������� ����� ��������� ����������� �������. ������� %d', [CurPos-1]);

        Res:=FunctionsList.Call(fname, params);
        if not Radian then
          if Pos('ARC', FName)<>0 then Res:=Res*(180/PI);
        GetToken;
      end
      else begin
        if Ord(InNumberType) > 10 then begin
          try
            Res := FromNumberType(FName);
            Exit;
          except
          end;
        end;
        Res := GetVariable(FName);
      end;
    end;
    else
      raise EMathAnalyzerError.CreateFmt('�������������� ������ � ������� %d', [CurPos - Length(Token)-1]);
  end;

end;

//���������� ����������������� ����������
procedure TMathAnalyzer.Arith(O: String; var r,h: Extended);
begin
    If o = 'OR' then r:=Trunc(r) or Trunc(h);
    If o = 'XOR' then r:=Trunc(R) xor Trunc(h);
    If o = 'MOD' then r:=Trunc(R) mod Trunc(h);
    If (o = 'DIV') or (o = '%') then r := Trunc(r) div Trunc(h);
    If (o = 'AND') or (o = '&') then r := Trunc(r) and Trunc(h);
    case o[1] of
      '+': r := r+h;
      '-': r := r-h;
      '*': r := r*h;
      '/': r := r/h;
      '^': r := ExecFunction('MPOWER',r,h);
      '!': r := ExecFunction('MFACT', r, 0);
    end;
end;

constructor TMathAnalyzer.Create;
begin
  Variables := nil;
  InNumberType := ntDec;
end;

function TMathAnalyzer.FromNumberType(Value: String): Extended;
begin
  Result := XcimalStrToNumber(Value, Ord(InNumberType));
end;

initialization

  LongDelims := DSet.Create;
  with LongDelims do begin
    add(['MOD']);
    add(['DIV']);
    add(['AND']);
    add(['OR']);
    add(['XOR']);
  end;

  Trigs := DSet.Create;
  with Trigs do begin
    add(['SIN']);
    add(['COS']);
    add(['TG']);
    add(['CTG']);
  end;

finalization

  LongDelims.Free;
  Trigs.Free;

end.
