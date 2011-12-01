unit Preferences;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Menus, ToolWin, CheckLst;

type
  TOptions = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    EnableShow: TCheckBox;
    EnableHide: TCheckBox;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnApply: TBitBtn;
    SaveHistory: TCheckBox;
    HistoryCount: TEdit;
    UpDown1: TUpDown;
    History: TCheckBox;
    AddNulles: TCheckBox;
    StickyWindow: TCheckBox;
    EnableClear: TCheckBox;
    HideOnInactive: TCheckBox;
    ClearMemoryOnExit: TCheckBox;
    AutoBoot: TCheckBox;
    AutoReplaceLayout: TCheckBox;
    SaveVariables: TCheckBox;
    StayOnTop: TCheckBox;
    TabSheet3: TTabSheet;
    memoInvFunctions: TMemo;
    SaveInvParamsToFile: TButton;
    Label1: TLabel;
    KeyList: TPopupMenu;
    Esc1: TMenuItem;
    Del1: TMenuItem;
    Pause1: TMenuItem;
    NumLock1: TMenuItem;
    CapsLock1: TMenuItem;
    ScrollLock1: TMenuItem;
    Backspace1: TMenuItem;
    Home1: TMenuItem;
    End1: TMenuItem;
    Insert1: TMenuItem;
    PageUp1: TMenuItem;
    PageDown1: TMenuItem;
    edtShow: TEdit;
    edtHide: TEdit;
    edtClearField: TEdit;
    Bevel1: TBevel;
    Label2: TLabel;
    TestEdit: THotKey;
    Label3: TLabel;
    DoNotTerminateOnClose: TCheckBox;
    ShowHintWindowOnClick: TCheckBox;
    EnableInsertTexts: TCheckBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    TabSheet4: TTabSheet;
    Label4: TLabel;
    clbPanelsVisible: TCheckListBox;
    Bevel2: TBevel;
    Label5: TLabel;
    tsUpdate: TTabSheet;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Button1: TButton;
    GroupBox1: TGroupBox;
    CheckBox2: TCheckBox;
    procedure HistoryClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveInvParamsToFileClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Options: TOptions;

implementation

uses KOLIniFile, InsertTextForm, Common_Utils, Main;

{$R *.dfm}

procedure TOptions.HistoryClick(Sender: TObject);
begin
  btnApply.Enabled:=true;
end;

procedure TOptions.btnApplyClick(Sender: TObject);
begin
  LoadSaveOptions(True);
  btnApply.Enabled:=false;
end;

procedure TOptions.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then btnApplyClick(Sender);
end;

procedure TOptions.FormShow(Sender: TObject);
begin
  LoadSaveOptions(False);
  btnApply.Enabled:=false;
end;

procedure TOptions.SaveInvParamsToFileClick(Sender: TObject);
begin
  SaveReplacedCaptions(@memoInvFunctions.Lines);
end;

procedure TOptions.SpeedButton1Click(Sender: TObject);
begin
  frmKeyInsertText.ShowModal;
end;

procedure TOptions.SpeedButton2Click(Sender: TObject);
begin
  SetClipText(Menus.ShortCutToText(TestEdit.HotKey));
end;

procedure TOptions.FormCreate(Sender: TObject);
begin
  clbPanelsVisible.ItemEnabled[0]:=false;
  clbPanelsVisible.Checked[0]:=true;
  //clbPanelsVisible.Checked[1]:=
end;

end.
