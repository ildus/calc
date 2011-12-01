unit MyStack;

interface

type PStack = ^TStack;
     TStack = record
        Bracket: char;
        Previous: PStack;
     end;

procedure Push(br: char);
function Pop: char;

var Stack: PStack = nil;
    IsEmpty: boolean = true;

implementation

procedure Push(br: char);
var NewRecord: PStack;
begin
    if Stack = nil then begin
        New(Stack);
        Stack.Bracket:=br;
        Stack.Previous:=nil;
        IsEmpty:=false;
    end
    else begin
        New(NewRecord);
        NewRecord.Bracket:=br;
        NewRecord.Previous:=Stack;
        Stack:=NewRecord;
    end;
end;

function Pop: char;
var Temp: PStack;
begin
    if Stack <> nil then begin
        Result:=Stack.Bracket;
        Temp:=Stack;
        Stack:=Temp.Previous;
        Dispose(Temp);
        if Stack <> nil then IsEmpty:=false
                        else IsEmpty:=true;
    end
    else begin
        IsEmpty:=true;
        Result:=#0;
    end;
end;

end.
 