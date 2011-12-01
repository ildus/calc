program Calc;

uses
  Forms,
  Windows,
  Messages,
  Main in 'Main.pas' {CalcMain},
  MyStack in 'MyStack.pas',
  Utils in 'Utils.pas',
  VariableWindow in 'VariableWindow.pas' {VariableW},
  MathExpression in 'MathExpression.pas',
  KOLIniFile in 'KOLIniFile.pas',
  Preferences in 'Preferences.pas' {Options},
  HistoryOperations in 'HistoryOperations.pas',
  InsertTextForm in 'InsertTextForm.pas' {frmKeyInsertText},
  Calc_Vars in 'Calc_Vars.pas',
  Common_Utils in 'Common_Utils.pas',
  DeCAL in 'common\DeCAL.pas',
  mwFixedRecSort in 'common\mwFixedRecSort.pas',
  FunctionsUnit in 'FunctionsUnit.pas';

{$R *.res}

begin
  if CheckThisProgram then Exit;

  Application.Initialize;
  Application.CreateForm(TCalcMain, CalcMain);
  Application.CreateForm(TfrmKeyInsertText, frmKeyInsertText);
  Application.CreateForm(TVariableW, VariableW);
  Application.Run;
end.
