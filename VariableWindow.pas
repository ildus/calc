unit VariableWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, HTMListB, Grids, BaseGrid, AdvGrid;

type
  TVariableW = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormMoving(var Msg: TWMWINDOWPOSCHANGING); message WM_WINDOWPOSCHANGING;
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VariableW: TVariableW;

implementation

uses Main, KOLIniFile, Calc_Vars;

{$R *.dfm}

procedure TVariableW.FormCreate(Sender: TObject);
begin
  LoadSaveVariable(False);
  Visible := VisibleVariableWindow;
end;

procedure TVariableW.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  VisibleVariableWindow := False;
  Action:=caHide;
end;

procedure TVariableW.FormMoving(var Msg: TWMWINDOWPOSCHANGING);
var MainRect: TRect;
    //HistoryRect: TRect;
begin
  if StickyWindow then begin
    GetWindowRect(CalcMain.Handle, MainRect);
    with MainRect, Msg.WindowPos^ do begin
      if Abs(x - Right) <= STICK_AT then x:=Right;
      if Abs((x+cx) - Left) <= STICK_AT then x:=Left - cx;
      if Abs(y - Bottom) <= STICK_AT then y := Bottom;
      if Abs((y+cy) - Top) <= STICK_AT then y:=Top  - cy;
    end;
  end;
  inherited;
end;

procedure TVariableW.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['+', '/', '*', '-'] then begin
    Key := #0;
    Memo1.SetFocus;
  end;
  if not (Key in ['A'..'Z','a'..'z','0'..'9',
    '.',',', Chr(VK_BACK), Chr(VK_DELETE), #13,'=']) then Key:=#0;
end;

procedure TVariableW.FormDestroy(Sender: TObject);
begin
  //сохранения переменных
  if SaveVariables then
    Memo1.Lines.SaveToFile('Variables.txt');
end;

end.
