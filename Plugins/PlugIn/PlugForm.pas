unit PlugForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ToolWin, ComCtrls, ExtCtrls, TeeProcs,
  TeEngine, Chart;

type
  TPluginWindow = class(TForm)
    Bevel1: TBevel;
    ToolBar1: TToolBar;
    Label1: TLabel;
    ExprEdit: TEdit;
    Chart1: TChart;
    SpeedButton1: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PluginWindow: TPluginWindow; e: TWinControl;

procedure ExecutePlugin(PluginHandle: HMODULE; MainForm: TComponent);

implementation

{$R *.dfm}

var MainHandle: THandle = 0;
    MyHandle: THandle = 0;

procedure ExecutePlugin(PluginHandle: HMODULE; MainForm: TComponent);
begin
  MainHandle:= TForm(MainForm).Handle;
  MyHandle:= PluginHandle;
  PluginWindow := TPluginWindow.Create(MainForm);
  with PluginWindow do begin
    Show;
    SetForegroundWindow(Handle);
    //Free;
  end;
end;

procedure TPluginWindow.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //Free;
  //SendMessage(MainHandle, WM_USER+2, MyHandle, 0);
end;

end.
