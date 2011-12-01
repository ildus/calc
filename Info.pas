unit Info;

interface

type PPluginInformation = ^TPluginInformation;
     TPluginInformation = record
        Name: PChar;
        HelpFile: PChar;
        Autor: PChar;
        ShortInfo: PChar;
        UseTComponent: Boolean;
     end;

implementation

//ИНФОРМАЦИЯ - КАК СДЕЛАТЬ ПЛАГИН К КАЛЬКУЛЯТОРУ

{
-------------------------------------------------------------------
Во-первых добавьте этот модуль в uses

ОБЯЗАТЕЛЬНЫЕ ФУНКЦИИ

1 * G E T V E R S I O N *

  ОПИСАНИЕ
  procedure GetVersion(PlugInfo: PPluginInformation);
  ЭТА ФУНКЦИЯ ЗАПОЛНЯЕТ ЭТУ ЗАПИСЬ ДАННЫМИ - ПОТОМ ЭТИ ДАННЫЕ
  ИСПОЛЬЗУЮТСЯ КАЛЬКУЛЯТОРОМ ДЛЯ ПОКАЗА ИНФОРМАЦИИ ОБ ЭТОМ ПЛАГИНЕ

2 * E X E C U T E P L U G I N *

  ОПИСАНИЕ
  procedure ExecutePlugin(MainForm: THandle);

  В этой функции вы создаете свое окно и связываете ее с главным
  окном программы

-------------------------------------------------------------------
}

end.
