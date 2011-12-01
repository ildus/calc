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
  Res.Name := '���������� ��������';
  Res.HelpFile := 'null';
  Res.Autor := '������������ ������';
  Res.ShortInfo := '�� ������ �������� ������� ������ ������';
  Res.UseTComponent := False;
end;

exports GetVersion, ExecutePlugin;

begin

end.
