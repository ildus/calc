unit HistoryOperations;

interface

uses Windows, Classes, ShellApi, SysUtils, Graphics, Calc_Vars;

type

  THistoryList = class
  private
    FSelected: Integer;
    history: TStringList;
    file_history: TFileName;

    function GetCount: Integer;

    function GetItem(Index: Integer): String;
  public
    constructor Create;
    procedure Load(fn: String = 'history.txt');
    procedure Save();
    property Count: Integer read GetCount;
    procedure Add(s: String);

    function GetExpression: String;
    function GetResult: String;
    procedure OpenFile;

    procedure Clear();
    property Items[Index: Integer]: String read GetItem;
    property Selected: Integer read FSelected write FSelected;
  end;

var HistoryList: THistoryList = nil;

implementation

var F: Text;

{ THistoryList }

procedure THistoryList.Add(s: String);
var Temp: TStringList;
    i: Integer;
    F: Text;
begin
  if history.IndexOf(s)>-1 then Exit;
  if HistoryCount<=history.Count then
    for i:=0 to history.Count - HistoryCount do history.Delete(0);
  //if HistoryCount = history.Count then history.Delete(0);
  history.Add(s);
  //UpdateHistory;
  if SaveHistory then begin
    {$I-}
    Assign(F, exePath+'History\'+FormatDateTime('dd.mm.yyyy', Now)+'.txt');
    Append(F);
    if IOResult<>0 then Rewrite(F);
    {$I+}
    Writeln(F, s);
    Close(F);
    Self.Save();
  end;
end;

procedure THistoryList.Clear;
var i: integer;
begin
  history.Clear();
  Save();
end;

constructor THistoryList.Create;
begin
  history := TStringList.Create();
  Selected := -1;
end;

function THistoryList.GetCount: Integer;
begin
  Result := history.Count;
end;

function THistoryList.GetExpression: String;
var P: Integer;
    S: String;
begin
    Result := '';
    if FSelected>-1 then begin
      S:=history.Strings[FSelected];
      P:=Pos('=', S);
      Result := Trim(Copy(S, 1, P-1));
    end;
end;

function THistoryList.GetResult: String;
var P: Integer;
    S: String;
begin
    Result := '';
    if FSelected>-1 then begin
      S:=History.Strings[FSelected];
      P:=Pos('=', S);
      Result := Trim(Copy(S, P+1, Length(S) - P+1));
    end;
end;

procedure THistoryList.Load(fn: String);
begin
  file_history := exePath+fn;
  if not FileExists(file_history) then begin
    Assign(F, file_history);
    Rewrite(F);
    Close(F);
  end;
  history.LoadFromFile(file_history);
end;

procedure THistoryList.Save();
begin
  history.SaveToFile(file_history);
end;

procedure THistoryList.OpenFile;
begin
  ShellExecute(0, 'open', PChar(file_history), nil, nil, 0);
end;
  
function THistoryList.GetItem(Index: Integer): String;
begin
  Result := history.Strings[Index];
end;

end.
