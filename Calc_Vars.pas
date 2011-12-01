unit Calc_Vars;

interface

uses SysUtils;

var

  exePath: String = '';

  //НАСТРОЙКИ ПРОГРАММЫ, ПРЕДВАРИТЕЛЬНО ЗАПОЛНЯЮТСЯ ИЗ INI-ФАЙЛА

  HKOnShow: String = 'CTRL+LEFT';  //КЛАВИШИ НА СКРЫТИЕ И ОТОБРАЖЕНИЕ
  HKOnHide: String = 'ESC';  //КЛАВИШИ НА СКРЫТИЕ
  HKOnClearField: String = 'DELETE'; //КЛАВИШИ НА ОЧИСТКУ ПОЛЯ

  EnableHKOnShow: boolean = true;
  EnableHKOnHide: boolean = true;
  EnableHKOnClearField: boolean = true;

  //HistoryListHeight: Integer = 40; //ширина списка истории
  //CalcFieldHeight: Integer = 40; //ширина вычислений

  MainWindowParams: record
    Height, Width: Integer;
    PagerHeight: Integer;
    PageIndex: Integer;
  end;

  WriteToHistory: Boolean = true; //использовать историю
  HistoryCount: Word = 20; //количество пометок истории
  SaveHistory: Boolean = true; //сохранять историю?

  StickyWindow: Boolean = true; //липкие окна доступность
  HideOnInactive: Boolean = true; //скрытие при деактивации
  StayOnTop: Boolean = false; //всегда наверху
  AutoBoot: Boolean = false;  //автозагрузка
  SaveVariables: Boolean = false; //сохранять переменные
  AutoReplaceLayout: Boolean = false; //автораскладка клавы
  ClearMemoryOnExit: Boolean = false; //очищать память при выходе
  AddNulles: Boolean = true;
  MeasureChecked: Boolean = true; //градусы или радианы

  VisibleVariableWindow: Boolean = false;
  VisibleHistoryWindow: Boolean = false;
  AutoCopy: Boolean = true; //автокопирование результата
  DoNotTerminateOnClose: Boolean = True;
  ShowHintWindowOnClick: Boolean = True;
  InNumberType: Byte = 10; //система счисления
  OutNumberType: Byte = 10; //система счисления

  update_exe: String = '';
  update_version: String = 'version.txt';

implementation

initialization

exePath := ExtractFilePath(ParamStr(0));

end.
