unit InsertTextForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, CheckLst, Buttons, ExtCtrls, Grids, ValEdit;

type
  TfrmKeyInsertText = class(TForm)
    SpeedButton3: TSpeedButton;
    HotKey1: THotKey;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Bevel1: TBevel;
    Edit1: TEdit;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    vleTexts: TValueListEditor;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKeyInsertText: TfrmKeyInsertText;

implementation

{$R *.dfm}

procedure TfrmKeyInsertText.SpeedButton1Click(Sender: TObject);
var S: String;
begin
  S:=InputBox('¬вод', '¬ведите нужный текст', '');
  //if (S<>'') and (vleTexts.Items.IndexOf(S) = -1) then
    //lbTexts.AddItem(S, nil);
end;

procedure TfrmKeyInsertText.SpeedButton2Click(Sender: TObject);
begin
  vleTexts.DeleteRow(vleTexts.Row);
end;

procedure TfrmKeyInsertText.SpeedButton3Click(Sender: TObject);
begin
  //vleTexts.Clear;
end;

end.
