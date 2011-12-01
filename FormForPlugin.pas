unit FormForPlugin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, MSScriptControl_TLB, VCLScriptControl;

type
  TFormForPlugins = class(TForm)
    VCLScriptControl1: TVCLScriptControl;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormForPlugins: TFormForPlugins;

implementation

{$R *.dfm}

end.
