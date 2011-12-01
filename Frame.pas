unit Frame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, Utils;

type
  TMyKeyPad = class(TFrame)
    Bevel2: TBevel;
    btnNumber: TButton;
    btnN2: TButton;
    btnN3: TButton;
    btnN4: TButton;
    btnN5: TButton;
    btnN6: TButton;
    btnN7: TButton;
    btnN8: TButton;
    btnN9: TButton;
    btnN0: TButton;
    btnPoint: TButton;
    btnUnary: TButton;
    btnOpenBracket: TButton;
    btnCloseBracket: TButton;
    btnOperation: TButton;
    btnDel: TButton;
    btnAdd: TButton;
    btnSub: TButton;
    btnMod: TButton;
    btnDiv: TButton;
    btnCalcExpression: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Main;

{$R *.dfm}

end.
