library ExPlugin;

uses
  Info in 'Info.pas',
  PlugForm in 'PlugForm.pas' {PluginWindow},
  MathExpression in '..\..\MathExpression.pas',
  MyStack in '..\..\MyStack.pas',
  Utils in '..\..\Utils.pas';

{$R *.res}
procedure GetVersion(Res: PPluginInformation);
begin
  Res.Name := 'Построение графиков';
  Res.HelpFile := 'null';
  Res.Autor := 'Курбангалиев Ильдус';
  Res.ShortInfo := 'На основе заданной формулы чертит график';
  Res.UseTComponent := False;
end;

exports GetVersion, ExecutePlugin;

begin

end.
