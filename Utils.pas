unit Utils;

interface

uses Windows, Messages, StdCtrls, ComCtrls, SysUtils, MathExpression, Common_Utils, Calc_Vars, VariableWindow;

var TruncateValue: Integer = -1;

type TLexeme = record
        Lexeme: String;
        LexemeType, Beginning: Integer;
     end;

const ltFunction = 1;
      ltNumber = 2;
      ltFactorial = 3;
      ltOpenBracket = 4;
      ltCloseBracket = 5;
      ltOperation = 6;
      ltLongOperation = 7;
      ltBegin = 8;
      ltPoint = 9;
      ltUnary = 10;
      ltText = 11;

//Œ¡Ÿ»≈ ‘”Õ ÷»»



procedure Msg(Mes: String);

//‘”Õ ÷»» ƒÀﬂ –¿¡Œ“€ — –≈ƒ¿ “Œ–ŒÃ

type  TMathEdit = class
      private
        procedure MAdd(T: string; Sel: integer);
        procedure AddFunction(Lexeme: String; CurPos: Integer; PrevL: TLexeme);
        procedure AddOperation(Lexeme: String; CurPos: Integer; PrevL: TLexeme);
        procedure AddUnary(CurPos: Integer; PrevL: TLexeme);
      public
        MemoHandle: TMemo;
        BarHandle: TStatusBar;

        procedure ClearSelection;
        function  GetResult: String;
        procedure AddLexeme(AddedLexeme: String; TypeAdded: Integer);
        function  GetPrevLexeme(Expr: String; CurPos: Integer): TLexeme;
        function  DeleteEquality: Boolean;
        function  BracketPos(CurrentPos: Integer): Integer;
        procedure GetFocusByEditor;
        procedure DeletePrevItem;
        procedure ShowError(Mes: String);
      end;

implementation

//Œ¡Ÿ»≈ ‘”Õ ÷»»

procedure Msg(Mes: String);
begin
  MessageBox(0, PChar(Mes),'',0);
end;

procedure TMathEdit.ShowError(Mes: String);
begin
  BarHandle.SimpleText:=Mes;
end;

procedure TMathEdit.ClearSelection;
var Expr: PChar;
begin
  Expr:='';
  SendMessage(MemoHandle.Handle, EM_REPLACESEL, 0, Integer(Expr));
end;

function TMathEdit.GetResult: String;
var P: Integer;
begin
  Result:='';
  with MemoHandle do begin
    P:=Pos('=', Text);
    if P<>0 then begin
        Result:=Copy(Text, P+1, Length(Text) - P +1);
        Result:=Trim(Result);
    end;
  end;
end;

procedure TMathEdit.MAdd(T: string; Sel: integer);
var s: string;
    p: integer;
begin
  with MemoHandle do begin
    s:=Text; p:=Sel;
    System.Insert(t,s,Sel+1); Text:=s;
    SelStart:=p+Length(t);
  end;
end;

procedure TMathEdit.AddFunction(Lexeme: String; CurPos: Integer; PrevL: TLexeme);
var i: Integer;
    Lex: TLexeme;
    Memo: String;
begin
  Lexeme:=Lexeme+'(';
  with MemoHandle do
    case PrevL.LexemeType of
      ltCloseBracket: begin
                        Memo:=Text;
                        i:=BracketPos(CurPos);
                        Lex:=GetPrevLexeme(Memo, i-1);
                        if Lex.LexemeType=ltFunction then begin
                          Delete(Memo, Lex.Beginning, Length(Lex.Lexeme))
                        end;
                        Text:=Memo;
                        MAdd(Copy(Lexeme, 1, Length(Lexeme)-1), i-1-Length(Lex.Lexeme));
                        SelStart:=CurPos+Length(Lexeme)-Length(Lex.Lexeme)-1;
      end;
      ltNumber: begin
                        MAdd(')',CurPos);
                        MAdd(Lexeme, PrevL.Beginning-1);
                        SelStart:=CurPos+Length(Lexeme)+1;
      end;
      else MAdd(Lexeme, CurPos);
    end;
end;

procedure TMathEdit.AddOperation(Lexeme: String; CurPos: Integer; PrevL: TLexeme);
var Memo: String;
begin
  with MemoHandle do
    if PrevL.LexemeType=ltOperation then begin
                    Memo:=Text;
                    Delete(Memo, PrevL.Beginning, Length(PrevL.Lexeme));
                    Insert(Lexeme, Memo, Prevl.Beginning);
                    Text:=Memo;
                    SelStart:=PrevL.Beginning+Length(Lexeme)-1;
    end
    else MAdd(Lexeme, CurPos);
end;

procedure TMathEdit.AddUnary(CurPos: Integer; PrevL: TLexeme);
var i: Integer;
    Memo: String;
begin
  with MemoHandle do
    case PrevL.LexemeType of
      ltCloseBracket: begin
                        Memo:=Text;
                        i:=BracketPos(CurPos);
                        //if (i<>1) then
                          case Memo[i-1] of
                             '+': Memo[i-1] := '-';
                             '-': Memo[i-1] := '+';
                             else begin
                                 MAdd(')', CurPos);
                                 MAdd('(-', i - 1);
                                 SelStart:=CurPos+3;
                                 Exit;
                             end;
                          end;
                        Text:=Memo; SelStart:=CurPos;
      end;
      ltNumber: begin

                        MAdd(')',CurPos);
                        MAdd('(-', PrevL.Beginning-1);
                        SelStart:=CurPos+3;
      end;
      ltOperation:      AddOperation('-', CurPos, PrevL);
      else MAdd('-', CurPos);
    end;
end;


procedure TMathEdit.AddLexeme(AddedLexeme: String; TypeAdded: Integer);
var CurrentPos: Integer;
    PrevL: TLexeme;
    Lexeme: String;
begin
 Lexeme:=AddedLexeme;
 with MemoHandle do begin
    DeleteEquality; ClearSelection;
    CurrentPos:=SelStart;
    PrevL:=GetPrevLexeme(Text, SelStart);
    case TypeAdded of
      ltFunction: AddFunction(Lexeme, CurrentPos, PrevL);
      ltOperation: AddOperation(Lexeme, CurrentPos, PrevL);
      ltUnary: AddUnary(CurrentPos, PrevL);
      else MAdd(Lexeme, CurrentPos);
    end;
  GetFocusByEditor;
 end;
end;

procedure OverWindLexeme(var S: String);  //ÔÂÂ‚ÂÌÛÚ¸ ÎÂÍÒÂÏÛ
var i: integer;
    t: char;
begin
  for i:=1 to Length(S) div 2 do begin
    t:=S[i];
    S[i]:=S[Length(S)-i+1];
    S[Length(S)-i+1]:=t;
  end;
end;

//‚ÓÁ‚‡˘‡ÂÚ ÔÂ‰˚‰Û˘Û˛ ÎÂÍÒÂÏÛ
function TMathEdit.GetPrevLexeme(Expr: String; CurPos: Integer): TLexeme;
var P: Integer;
begin
  with Result do begin
    Lexeme:='';
    If CurPos <= 0 Then LexemeType:=ltBegin
    else begin
      P:=CurPos;
      while Expr[P] in [' ',#9] do begin
        Dec(P);
        if P <= 0 Then Begin
          LexemeType:=ltBegin;
          Exit;
        end;
      end;
      if Expr[P] in ['(',')','+','-','*','/','&','%','^','!'] then begin
        Lexeme:=Expr[P];
        Beginning:=P;
      end;
      case Expr[P] of
        '(': LexemeType:=ltOpenBracket;
        ')': LexemeType:=ltCloseBracket;
        '0'..'9': begin
          LexemeType:=ltNumber;
          while Expr[P] in NumbersEx do begin
            Lexeme:=Lexeme+Expr[P];
            Dec(P);
            if P=0 then Break
          end;
          Beginning:=P+1;
        end;
        'A'..'Z','a'..'z': begin
          LexemeType:=ltFunction;
          while Expr[P] in LatinEx do begin
            Lexeme:=Lexeme+Expr[P];
            Dec(P);
            if P=0 then Break
          end;
          OverWindLexeme(Lexeme); //ÔÂÂ‚ÂÌÛÚ¸
          if LongDelims.includes([AnsiUpperCase(Lexeme)]) then LexemeType:=ltOperation;
          Beginning:=P+1;
        end;
        '+','-','*','/','&','%','^': LexemeType:=ltOperation;
        '.',',': LexemeType:=ltPoint;
        '!': LexemeType:=ltFactorial;
      end;
    end;
  end;
end;

//Û‰‡ÎˇÂÚ ÂÁÛÎ¸Ú‡Ú
function TMathEdit.DeleteEquality: Boolean;
var Expr: String;
    P, SS: Integer;
begin
  with MemoHandle do begin
    Expr:=Text;
    P:=Pos('=', Expr);
    if P <> 0 then begin
      SS:=SelStart;
      Delete(Expr, P, Length(Expr) - P+1);
      Expr:=TrimRight(Expr);
      Text:=Expr;
      SelStart:=SS;
      Result := True;
    end
    else Result := False;
  end;
end;

function TMathEdit.BracketPos(CurrentPos: Integer): Integer;
var Temp: String;
    b, i: Integer;
begin
  b:=0;
  with MemoHandle do begin
    Temp:=Text;
    for i:=CurrentPos downto 1 do begin
      if Temp[i] = ')' then Inc(b);
      if Temp[i] = '(' then Dec(b);
      if b = 0 then Break;
    end;
  end;
  Result:=i;
end;

procedure TMathEdit.GetFocusByEditor;
begin
  SetFocus(MemoHandle.Handle);
end;

procedure TMathEdit.DeletePrevItem;
var Lex: TLexeme;
    Memo: String;
begin
  DeleteEquality;
  with MemoHandle do begin
    Memo:=Text;
    Lex:=GetPrevLexeme(Memo, SelStart);
    Delete(Memo, Lex.Beginning, Length(Lex.Lexeme));
    Memo:=TrimRight(Memo);
    Lex:=GetPrevLexeme(Memo, Lex.Beginning -1);
    Text:=Memo;
    SelStart:=Lex.Beginning+Length(Lex.Lexeme)-1;
  end;
end;

end.
