unit Main;

interface

uses 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ActnList, ToolWin, ActnMan, ActnCtrls,
  XPStyleActnCtrls, CustomizeDlg, Menus, ComCtrls, ImgList,
  StdStyleActnCtrls, XPMan, StdActns, ExtCtrls, ActnMenus, HotKeyManager, AppEvnts,
  ActnColorMaps,
  AdvToolBar, AdvOfficePager, AdvToolBtn, AdvToolBarStylers,
  AdvOfficeTabSet, AdvOfficeTabSetStylers, AdvPanel, AdvOfficePagerStylers,
  AdvGlowButton, AdvSplitter, AdvShapeButton, AdvMemo, Advmxml,
  AdvMemoStylerManager, AdvMenus, AdvMenuStylers, Grids, BaseGrid, AdvGrid;

type
  TCalcMain = class(TForm)
    XPManifest: TXPManifest;
    OkrPopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    ActionManager1: TActionManager;
    actInvert: TAction;
    actOkrugl: TAction;
    actBack: TAction;
    actClearAll: TAction;
    HKeys: THotKeyManager;
    ApplicationEvents: TApplicationEvents;
    Functions: TPopupMenu;
    FontDialog: TFontDialog;
    HistoryListMenu: TPopupMenu;
    itemShowFile: TMenuItem;
    itemClearHistory: TMenuItem;
    itemUpdate: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    itemInsertResult: TMenuItem;
    itemInsertExpression: TMenuItem;
    N7: TMenuItem;
    itemFont: TMenuItem;
    actToMemory: TAction;
    actFromMemory: TAction;
    actClearMemory: TAction;
    actShowVariableWindow: TAction;
    actShowHistoryWindow: TAction;
    actAddFactorial: TAction;
    actAddPI: TAction;
    actShowAllFunctions: TAction;
    actSin: TAction;
    actCos: TAction;
    actTG: TAction;
    actCtg: TAction;
    actLN: TAction;
    actLog: TAction;
    actExp: TAction;
    actPower: TAction;
    actToMemoryDown: TAction;
    actFromMemoryDown: TAction;
    ImageList1: TImageList;
    actN1: TAction;
    actN2: TAction;
    actN3: TAction;
    actN4: TAction;
    actN5: TAction;
    actN6: TAction;
    actN7: TAction;
    actN8: TAction;
    actN9: TAction;
    actN0: TAction;
    actUnary: TAction;
    actPoint: TAction;
    actOpenBracket: TAction;
    actCloseBracket: TAction;
    actPlus: TAction;
    actMinus: TAction;
    actDelenie: TAction;
    actProizvedenie: TAction;
    actMod: TAction;
    actDiv: TAction;
    actRavno: TAction;
    ErrorBar: TStatusBar;
    N6: TMenuItem;
    N8: TMenuItem;
    menuCountHistory: TMenuItem;
    N23: TMenuItem;
    N33: TMenuItem;
    N43: TMenuItem;
    N53: TMenuItem;
    N9: TMenuItem;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    atbPager: TAdvToolBarPager;
    apCalculations: TAdvPage;
    pageHistory: TAdvPage;
    splitterMain: TAdvSplitter;
    AdvMemoStylerManager1: TAdvMemoStylerManager;
    CalcField: TMemo;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    actAutoCopy: TAction;
    actPasteFromClipboard: TAction;
    listHistory: TAdvStringGrid;
    actAddHistoryResult: TAction;
    actAddHistoryExpression: TAction;
    btnInNumberType: TAdvGlowButton;
    btnOutNumberType: TAdvGlowButton;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvGlowButton4: TAdvGlowButton;
    btnAutoCopy: TAdvGlowButton;
    btnRadian: TAdvGlowButton;
    btnGrad: TAdvGlowButton;
    AdvToolBar3: TAdvToolBar;
    AdvGlowButton9: TAdvGlowButton;
    AdvGlowButton10: TAdvGlowButton;
    AdvGlowButton11: TAdvGlowButton;
    AdvGlowButton12: TAdvGlowButton;
    AdvGlowButton13: TAdvGlowButton;
    AdvGlowButton14: TAdvGlowButton;
    AdvGlowButton15: TAdvGlowButton;
    AdvGlowButton16: TAdvGlowButton;
    mNumberSystem: TAdvPopupMenu;
    miNumberType: TMenuItem;
    Hex1: TMenuItem;
    Bin1: TMenuItem;
    Oct1: TMenuItem;
    actDec: TAction;
    actHex: TAction;
    actBin: TAction;
    actOct: TAction;
    AdvGlowButton1: TAdvGlowButton;
    actMainMenu: TAction;
    btnPasteFromClipbrd: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    menuTray: TAdvPopupMenu;
    N12: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    menuMain: TAdvPopupMenu;
    N18: TMenuItem;
    actOptionsMain: TAction;
    actAbout: TAction;
    actRestoreWindow: TAction;
    actVariables: TAction;
    actCalcFieldFont: TAction;
    actHistoryFont: TAction;
    actExit: TAction;
    N19: TMenuItem;
    N20: TMenuItem;
    N22: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    menuAdditional: TMenuItem;
    AdvGlowButton3: TAdvGlowButton;
    menuOkrugl: TAdvPopupMenu;
    N3: TMenuItem;
    N01: TMenuItem;
    N13: TMenuItem;
    N28: TMenuItem;
    N32: TMenuItem;
    N42: TMenuItem;
    N52: TMenuItem;
    N62: TMenuItem;
    procedure OnTrayMessage(var Msg: TMessage); message WM_USER+1;
    procedure OnPluginMessage(var Msg: TMessage); message WM_USER+2;
    procedure listHistoryMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OkrPopupMenuClick(Sender: TObject);
    procedure actOkruglExecute(Sender: TObject);
    procedure actInvertExecute(Sender: TObject);
    procedure actClearAllExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSINClick(Sender: TObject);
    procedure btnPowerClick(Sender: TObject);
    procedure actBackExecute(Sender: TObject);
    procedure tbFactorialClick(Sender: TObject);
    procedure tbAddPINumberClick(Sender: TObject);
    procedure HKeysHotKeyPressed(HotKey: Cardinal; Index: Word);
    //Процедуры полного режима
    procedure OperationClick(Sender: TObject);
    procedure CalcExpressionClick(Sender: TObject);
    procedure TerminateApplication;
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure ApplicationEventsActivate(Sender: TObject);
    procedure ApplicationEventsRestore(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure FormMoving(var Msg: TWMWINDOWPOSCHANGING); message WM_WINDOWPOSCHANGING;
    procedure WMSys(var Msg: TMessage); message WM_SYSCOMMAND;
    procedure ShowTrayIcon;
    procedure CalcFieldKeyPress(Sender: TObject; var Key: Char);
    procedure FunctionItemClick(Sender: TObject);
    procedure OnPluginItem(Sender: TObject);
    procedure listHistoryExit(Sender: TObject);
    procedure itemUpdateClick(Sender: TObject);
    procedure itemClearHistoryClick(Sender: TObject);
    procedure itemShowFileClick(Sender: TObject);
    procedure listHistoryMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure menuCountHistoryClick(Sender: TObject);
    procedure CalcFieldKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actShowAllFunctionsExecute(Sender: TObject);
    procedure AdvToolBar3OptionClick(Sender: TObject; ClientPoint,
      ScreenPoint: TPoint);
    procedure actPasteFromClipboardExecute(Sender: TObject);
    procedure actAutoCopyExecute(Sender: TObject);
    procedure btnGradClick(Sender: TObject);
    procedure splitterMainMoved(Sender: TObject);
    procedure listHistorySelectionChanged(Sender: TObject; ALeft, ATop,
      ARight, ABottom: Integer);
    procedure listHistoryDblClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure actAddHistoryResultExecute(Sender: TObject);
    procedure actAddHistoryExpressionExecute(Sender: TObject);
    procedure actDecExecute(Sender: TObject);
    procedure btnInNumberTypeDropDown(Sender: TObject);
    procedure btnOutNumberTypeDropDown(Sender: TObject);
    procedure atbPagerChange(Sender: TObject);
    procedure actOptionsMainExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actRestoreWindowExecute(Sender: TObject);
    procedure actVariablesExecute(Sender: TObject);
    procedure actCalcFieldFontExecute(Sender: TObject);
    procedure actHistoryFontExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure listHistoryResize(Sender: TObject);

  private
    NumberTypeSelectMode: (ntsIn, ntsOut, ntsNone);
    procedure UpdateHistoryList;
    procedure UpdateNumberTypes;
    procedure CalcExpression; //процедура вычисления
    procedure ShowAllWindows;
    procedure HideAllWindows;
    procedure LoadAllParameters;
  public
    { Public declarations }
  end;

var
  CalcMain: TCalcMain;

implementation

uses VariableWindow, Utils, MathExpression, Info,
      KOLIniFile, ShellApi, Preferences, StrUtils, ImageHlp, HistoryOperations,
      Calc_Vars, Common_Utils, FunctionsUnit, DeCAL;

var IconData: TNotifyIconData;

    MM_SHOW: Word = 0; //сообщение о показе

    OnShowKey: Cardinal; //клавиши на показ
    OnHideKey: Cardinal; //клавиша не скрытие
    OnClearKey: Cardinal; //клавиша на очистку

    Analyzer: TMathAnalyzer; //класс анализатора

    HHint: THintWindow;

    Calced: Boolean = False;
    MathEdit: TMathEdit = nil;

{$R *.dfm}

//показать иконку в трее
procedure TCalcMain.ShowTrayIcon;
begin
  //заполнение данных иконки
  with IconData do begin
    cbSize:=SizeOf(TNotifyIconData);
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
    uCallbackMessage := WM_USER+1;
    hIcon := Application.Icon.Handle;
    szTip:='Инженерный калькулятор';
  end;
  Shell_NotifyIcon(NIM_ADD, @IconData); //модуль ShellAPI
end;

//СООБЩЕНИЯ ИЗ ПАНЕЛИ ЗАДАЧ
procedure TCalcMain.OnTrayMessage(var Msg: TMessage);
var P: TPoint;
begin
  CASE Msg.LParam OF
    //левая кнопка
    WM_LButtonDown: begin
      //если невидимо показать все окна
      if not Visible then ShowAllWindows
      else HideAllWindows;
    end;
    //правая кнопка
    WM_RButtonDown: begin
      //показать главное меню
      GetCursorPos(P);
      menuTray.Popup(P.X, P.Y);
    end;
  END;
end;

procedure TCalcMain.LoadAllParameters;
begin
    ReadOrWriteParameters(False);

    //Установка клавиш
    HKeys.ClearHotKeys;
      //Показ/скрытие - глобальная клавиша
    OnShowKey := TextToHotKey(HKOnShow, True);
      //Скрытие и очистка - неглобальные, проверяются обработчиком
      //клавиш самой формы
    OnHideKey := TextToHotKey(HKOnHide, True);
    OnClearKey := TextToHotKey(HKOnClearField, True);

    if EnableHKOnShow then MM_SHOW := HKeys.AddHotKey(OnShowKey);
    //Установка окна поверх всех окон
    if StayOnTop then FormStyle := fsStayOnTop else FormStyle := fsNormal;
    //Показать иконку в трее
    ShowTrayIcon; //показать иконку в трее
    //Включить автокопирование
    btnAutoCopy.Down := AutoCopy;
    if MeasureChecked then btnGrad.Down := True else btnRadian.Down := True;

    NumberTypeSelectMode := ntsNone;
    UpdateNumberTypes();
    //Height:=MainPanel.Height+HistoryListHeight+
      //HistorySplitter.Height+ErrorBar.Height+30;

    Height:=MainWindowParams.Height;
    Width:=MainWindowParams.Width;
    atbPager.Height := MainWindowParams.PagerHeight;

    if MainWindowParams.PageIndex in [0..1] then
      atbPager.ActivePageIndex := MainWindowParams.PageIndex
    else
      atbPager.ActivePageIndex := 0;

    //listHistory.Height:=HistoryListHeight;
    //CalcField.Height:=CalcFieldHeight;

    HistoryList := THistoryList.Create();
    HistoryList.Load();
    UpdateHistoryList();
end;

//ВЫЧИСЛЕНИЕ ВЫРАЖЕНИЯ
procedure TCalcMain.CalcExpression;
var Expr, S: String;
    P, i: Integer;
begin

  Analyzer.InNumberType := TNumberType(InNumberType);
  with Analyzer, MathEdit do begin
    ShowError('');
    DeleteEquality;
    Expr:=CalcField.Text;
    Expression:=Expr;
    Radian:= not MeasureChecked; //градусы или радианы
    Variables:=@VariableW.Memo1.Lines;
    try
      Evaluate; //вычислить выражение
      Calced := True;

      if TruncateValue <> -1 then
      //то округлить число
        try Answer:=FormatData(Answer, TruncateValue);
        except
        //Это сделано для того чтобы ничего не выводилось при ошибке
        //Например, если FormatData возвратит ошибку, то выведется
        //полное число - т.е. без округления
        end;

      S:=FloatToStr(Answer);
      if OutNumberType = 10 then begin
        //добавление нулей в конец
        if AddNulles then begin
          P:=Pos(DecimalSeparator, S);
          if (P<>0) and ((Length(S) - P)<TruncateValue) then
            for i:=1 to TruncateValue-(Length(S)-P) do S:=S+'0';
        end;
      end
      else
        S:=XcimalStrToYcimalStr(10, S, outNumberType, TruncateValue);

      Expr:=Expr+' = '+S;
      //копировать в буфер при условии
      if AutoCopy then SetClipText(FloatToStr(Answer));
      CalcField.Text:=Expr; //показать ответ
      //добавить в историю
      if WriteToHistory then begin
        HistoryList.Add(Expr);
        UpdateHistoryList();
      end;
    except
      on E:Exception do
        ShowError(E.Message);
    end;
    GetFocusByEditor; //фокус на редакторе
    CalcField.SelStart:=Pos('=', Expr) - 2; //позиция в конце выр-я
   end;
end;

//ОБРАБОТКА СООБЩЕНИЯ ПРИ ВЫБОРЕ ИЗ МЕНЮ ОКРУГЛЕНИЯ
procedure TCalcMain.OkrPopupMenuClick(Sender: TObject);
begin
  actOkrugl.Caption:=(Sender as TMenuItem).Caption;
end;

//ВЫВОД МЕНЮ ОКРУГЛЕНИЯ
procedure TCalcMain.actOkruglExecute(Sender: TObject);
begin
end;

//ИНВЕРТИРУЕТ НАЗВАНИЯ НЕКОТОРЫХ КНОПОК
procedure TCalcMain.actInvertExecute(Sender: TObject);
begin
  ReplaceCaptions;
end;

//ОЧИСТКА ПОЛЯ
procedure TCalcMain.actClearAllExecute(Sender: TObject);
begin
  CalcField.Clear;
end;

procedure TCalcMain.ShowAllWindows;
begin
  Visible := True; //главное окно
  //окно переменных
  if VisibleVariableWindow then VariableW.Visible:= True;

  //автораскладка клавы
  if AutoReplaceLayout then SetEnglishLayout;

  if StayOnTop then
    //поставить поверх всех окон
    SetForegroundWindow(Application.Handle);
end;

procedure TCalcMain.HideAllWindows;
begin
  //главное окно
  Visible := False;
  //окно переменных
  with VariableW do
    if Visible then Visible:= False;
end;


procedure TCalcMain.OnPluginMessage(var Msg: TMessage);
begin
  ShowMessage(IntToStr(Msg.WParam));
  FreeLibrary(Msg.WParam);
end;

//обработка перемещения окна
procedure TCalcMain.FormMoving(var Msg: TWMWINDOWPOSCHANGING);
var
  WorkArea: TRect;
  StickAt : Word;
begin
  if StickyWindow then begin
    StickAt := STICK_AT;
    SystemParametersInfo(SPI_GETWORKAREA, 0, @WorkArea, 0);
    with WorkArea, Msg.WindowPos^ do
    begin
      // Сдвигаем границы для сравнения с левой и верхней сторонами
      Right:=Right-cx;
      Bottom:=Bottom-cy;
      if abs(Left - x) <= StickAt then
        x := Left;
      if abs(Right - x) <= StickAt then
        x := Right;
      if abs(Top - y) <= StickAt then
        y := Top;
      if abs(Bottom - y) <= StickAt then
        y := Bottom;
    end;
  end;
  inherited;
end;

procedure TCalcMain.WMSys(var Msg: TMessage);
begin
  if (Msg.wParam = SC_MINIMIZE) then
    HideAllWindows
  else
    inherited;
end;

//Сообщение на запуск плагина
procedure TCalcMain.OnPluginItem(Sender: TObject);
var Plugin: HMODULE;
    ExecutePlugin: procedure (PluginHandle: HMODULE; MainForm: TComponent);
begin
  with Sender as TMenuItem do begin
    Plugin:=LoadLibrary(PChar('PlugIns\'+Name+'.dll'));
    if Plugin = 0 then
      MathEdit.ShowError('Плагин не доступен - занят или перемещен')
    else begin
      //ShowMessage(IntToStr(Plugin));
      ExecutePlugin:=GetProcAddress(Plugin, 'ExecutePlugin');
      ExecutePlugin(Plugin, CalcMain);
    end;
  end;
end;

//СОЗДАНИЕ ФОРМЫ
procedure TCalcMain.FormCreate(Sender: TObject);
var L: LongInt;
    GetVersion: procedure (Res: PPluginInformation);
    Inf: TPluginInformation;
    NewItem: TMenuItem;
    PlugIn: HModule;
    sr: TSearchRec;
begin
  Analyzer:=TMathAnalyzer.Create;

  //Делаем программу невидимой в таскбаре
  L:=GetWindowLong(Application.Handle, GWL_EXSTYLE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE, L or WS_EX_TOOLWINDOW);

  //загрузить все параметры окна и все клавиши
  LoadAllParameters;

  MathEdit:=TMathEdit.Create;
  MathEdit.MemoHandle:=CalcField;
  MathEdit.BarHandle:=ErrorBar;
  HHint:=THintWindow.Create(listHistory);

  if DirectoryExists('Plugins') then begin
    //Создание окна, используемой для подсказки
    if FindFirst('Plugins\*.dll', faAnyFile, sr) = 0 then begin
      repeat
        PlugIn := LoadLibrary(PChar('Plugins\'+SR.Name));
        if Plugin <> 0 then begin
          @GetVersion := GetProcAddress(Plugin, 'GetVersion');
          if @GetVersion = nil then begin
            ShowMessage('No function');
          end
          else begin
            GetVersion(@Inf);
            NewItem := TMenuItem.Create(menuMain);
            with NewItem do begin
              Caption:=Inf.Name;
              Hint:=Inf.ShortInfo;
              Name:=Copy(SR.Name, 1, Length(sr.Name)-4);
              OnClick:=OnPluginItem;
            end;
            with menuMain.Items do
              Items[IndexOf(menuAdditional)].Add(NewItem);
          end;
          FreeLibrary(PlugIn); FreeLibrary(PlugIn);
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  end
  else menuAdditional.Visible := False;
end;

procedure TCalcMain.TerminateApplication;
begin
  //удалить значок из треи
  Shell_NotifyIcon(NIM_DELETE, @IconData);
  MainWindowParams.PagerHeight := atbPager.Height;
  //записать все параметры (True - записать, False - читать)
  ReadOrWriteParameters(True);
  
  //сохранить параметры окна переменных
  LoadSaveVariable(True);
  //очистка памяти
  If ClearMemoryOnExit then ClearMemory;

  //удалить горячую клавишу
  HKeys.RemoveHotKeyByIndex(MM_SHOW);

  Analyzer.Free;

  Application.Terminate;
end;

//ЗАКРЫТИЕ ФОРМЫ
procedure TCalcMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DoNotTerminateOnClose then begin
    Action:=caNone;
    HideAllWindows;
  end
  else TerminateApplication;
end;

//СООБЩЕНИЕ О НАЖАТОЙ ГОРЯЧЕЙ КЛАВИШЕ
procedure TCalcMain.HKeysHotKeyPressed(HotKey: Cardinal; Index: Word);
begin
   if Index = MM_SHOW then
      if Visible then HideAllWindows else ShowAllWindows;
end;

//ЧИСЛО ОКРУГЛЕНИЯ ВЫЧИСЛЯЕТСЯ ИЗ ИМЕНИ КНОПКИ
procedure TCalcMain.N1Click(Sender: TObject);
var i: Integer;
begin
  actOkrugl.Caption:=(Sender as TMenuItem).Caption;
  for i:=0 to 6 do
    if Pos(Chr(i+48), actOkrugl.Caption)<>0 then
      TruncateValue:=i;
  if Pos('Без', actOkrugl.Caption)<>0 then TruncateValue:=-1;
end;

//ФУНКЦИИ
procedure TCalcMain.btnSINClick(Sender: TObject);
begin
  with Sender as TAction do
    MathEdit.AddLexeme(AnsiLowerCase(AnsiReplaceStr(Caption,'&', '')), ltFunction);
end;

//СТЕПЕНИ
procedure TCalcMain.btnPowerClick(Sender: TObject);
begin
  with Sender as TAction do
    MathEdit.AddLexeme('^', -1);
end;

//Удалить предыдущую лексему
procedure TCalcMain.actBackExecute(Sender: TObject);
begin
  MathEdit.DeletePrevItem;
end;

//открыть окно настроек
var Write: Boolean;

//добавить факториал
procedure TCalcMain.tbFactorialClick(Sender: TObject);
begin
  MathEdit.AddLexeme('!', ltFactorial);
end;
//добавить число пи
procedure TCalcMain.tbAddPINumberClick(Sender: TObject);
begin
  MathEdit.AddLexeme('PI', -1)
end;

procedure TCalcMain.ApplicationEventsDeactivate(Sender: TObject);
begin
  HHint.ReleaseHandle;
  if HideOnInActive then HideAllWindows;
end;

procedure TCalcMain.ApplicationEventsActivate(Sender: TObject);
begin
    if Visible then CalcField.SetFocus;
end;

procedure TCalcMain.ApplicationEventsRestore(Sender: TObject);
begin
  ShowAllWindows;
end;

procedure TCalcMain.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if Msg.message = WM_KEYDOWN then begin
    if EnableHKOnHide then
      if Msg.wParam = Integer(OnHideKey) then HideAllWindows;
    if EnableHKOnClearField then
      if Msg.wParam = Integer(OnClearKey) then CalcField.Clear;
  end;
end;

//обработка ввода символьных нажатий
procedure TCalcMain.CalcFieldKeyPress(Sender: TObject; var Key: Char);
var Res: String;
    memo: TMemo;
begin
  memo := Sender as TMemo;

  if Key in Latin+Brackets+Delims+Numbers then MathEdit.DeleteEquality;
  case Key of
    #13: begin
      Res:=MathEdit.GetResult();
      if Res = '' then CalcExpression
      else begin
        CalcField.Text:=Res;
        CalcField.SelStart:=Length(Res);
      end;
    end;
    '=': begin
      CalcExpression;
      Key:=#0;
    end;
    '+','-','*','/','&','%','^': begin
      MathEdit.AddLexeme(Key, ltOperation);
      Key:=#0;
    end;
    '`','~': begin
      MathEdit.AddLexeme(Key, ltUnary);
      Key:=#0
    end;
    'A'..'Z','a'..'z','(',')','0'..'9','.',',',';','!',' ': ; //пусто
    Chr(VK_BACK): ;
    else Key:=#0;
  end;
end;

procedure ListDLLExports(const FileName: string; List: TStrings);
 type
   TDWordArray = array [0..$FFFFF] of DWORD;
 var
   imageinfo: LoadedImage;
   pExportDirectory: PImageExportDirectory;
   dirsize: Cardinal;
   pDummy: PImageSectionHeader;
   i: Cardinal;
   pNameRVAs: ^TDWordArray;
   Name: string;
 begin
   List.Clear;
   if MapAndLoad(PChar(FileName), nil, @imageinfo, True, True) then
   begin
     try
       pExportDirectory := ImageDirectoryEntryToData(imageinfo.MappedAddress,
         False, IMAGE_DIRECTORY_ENTRY_EXPORT, dirsize);
       if (pExportDirectory <> nil) then
       begin
         pNameRVAs := ImageRvaToVa(imageinfo.FileHeader, imageinfo.MappedAddress,
           DWORD(pExportDirectory^.AddressOfNames), pDummy);
         for i := 0 to pExportDirectory^.NumberOfNames - 1 do
         begin
           Name := PChar(ImageRvaToVa(imageinfo.FileHeader, imageinfo.MappedAddress,
             pNameRVAs^[i], pDummy));
           List.Add(Name);
         end;
       end;
     finally
       UnMapAndLoad(@imageinfo);
     end;
   end;
 end;

var FunctionsMenuCreated: Boolean = false;

procedure TCalcMain.FunctionItemClick(Sender: TObject);
var F: String;
begin
  F:=AnsiReplaceStr((Sender as TMenuItem).Caption, '&','');
  MathEdit.AddLexeme(F, ltFunction);
end;

//-----------------------------------------------------------------

//СООБЩЕНИЯ ДЛЯ ФРЕЙМА (ЧИСЛА, ОПЕРАЦИИ и.т.д.)

procedure TCalcMain.OperationClick(Sender: TObject);
var S: String;
begin
  with Sender as TAction do begin
    S:=Caption;
    MathEdit.AddLexeme(S, (Sender as TAction).Tag);
  end;
end;

//кнопка равно
procedure TCalcMain.CalcExpressionClick(Sender: TObject);
begin
  CalcExpression;
end;

//-----------------------------------------------------------------
procedure TCalcMain.listHistoryMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Index: Integer;
    Rect: TRect;
    P: TPoint;
begin
  {with (Sender as TListBox) do begin
    Index := ItemAtPos(Point(X, Y), true);
    listHistory.Selected[Index]:=True;
    if not ShowHintWindowOnClick then Exit;
    HHint.ReleaseHandle;
    GetCursorPos(P);
    if (Index<>-1) and (Pos('...', Items[Index]) <> 0) then begin
      Rect.Left:=P.X;
      Rect.Top:=P.Y;
      Rect.Bottom:=HHint.Canvas.TextHeight(HistoryList[Index])+P.Y;//Top+History.Top+GetCaptionHeight;
      Rect.Right:=HHint.Canvas.TextWidth(Records.Strings[Index])+P.X+20;
      HHint.ActivateHint(Rect, Records.Strings[Index]);
    end;
  end;}
end;

procedure TCalcMain.listHistoryMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var Index: Integer;
    box: TAdvStringGrid;
    point : TPoint;
begin
  box := Sender as TAdvStringGrid;
  
  {with (box) do begin

    Index := ItemAtPos(Point(X, Y), true);
    if Index<>-1 then Hint:=Records.Strings[Index];
  end; }
end;

procedure TCalcMain.listHistoryExit(Sender: TObject);
begin
  HHint.ReleaseHandle;
end;

procedure TCalcMain.itemUpdateClick(Sender: TObject);
begin
  UpdateHistoryList();
end;

procedure TCalcMain.itemClearHistoryClick(Sender: TObject);
begin
  HistoryList.Clear();
  UpdateHistoryList();
end;

procedure TCalcMain.itemShowFileClick(Sender: TObject);
begin
  HistoryList.OpenFile();
end;

procedure TCalcMain.menuCountHistoryClick(Sender: TObject);
var count, h: Integer;
    s: TSize;
begin
  count:=(Sender as TMenuItem).Tag;
  try
    if count<1 then
      count:=StrToInt(InputBox('Список истории', 'Введите количество строк', ''));
  except
    on EConvertError do Exit;
  end;

  h := listHistory.RowHeights[0]*count;
  atbPager.Height := h + 5+(atbPager.Height - listHistory.Height);
end;

//обработка несимвольных нажатий
procedure TCalcMain.CalcFieldKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var p: Integer;
    memo: TMemo;
begin
  memo := Sender as TMemo;
  if (Key in [VK_BACK, VK_DELETE]) then begin
    if Pos('=', memo.SelText) = 0 then
      MathEdit.DeleteEquality;
  end;
  if Shift = [ssCtrl] then
    if (Key = Ord('V')) or (Key = Ord('v')) then
      with MathEdit do begin
        DeleteEquality;
        AddLexeme(GetClipText, ltText);
      end;
end;

procedure TCalcMain.actShowAllFunctionsExecute(Sender: TObject);
var Item: TMenuItem;
    F: TStringList;
    i: Integer;
    p: TPoint;
    iter: DIterator;
begin
  if not FunctionsMenuCreated then begin
    F:=FunctionsList.getFunctionNames();

    for i:=0 to F.Count-1 do begin
      Item:=TMenuItem.Create(Functions);
      Item.OnClick:=FunctionItemClick;
      Item.Caption:=AnsiLowerCase(F[i]);
      Functions.Items.Add(Item);
    end;
    F.Free;
    FunctionsMenuCreated:=true;
  end;
  GetCursorPos(P);
  Functions.Popup(P.X, P.Y);
end;

procedure TCalcMain.AdvToolBar3OptionClick(Sender: TObject; ClientPoint,
  ScreenPoint: TPoint);
begin
  actShowAllFunctions.Execute();
end;

procedure TCalcMain.actPasteFromClipboardExecute(Sender: TObject);
var S: String;
begin
  with MathEdit do begin
    S:=GetClipText;
    if Pos(#13, S) = 0 then AddLexeme(S, -1)
    else begin
      ShowError('Буфер содержит не выражение');
      GetFocusByEditor;
    end;
  end;
end;

procedure TCalcMain.actAutoCopyExecute(Sender: TObject);
begin
  AutoCopy := not Autocopy;
end;

procedure TCalcMain.btnGradClick(Sender: TObject);
begin
  MeasureChecked := btnGrad.Down;
end;

procedure TCalcMain.splitterMainMoved(Sender: TObject);
begin
  MainWindowParams.PagerHeight := atbPager.Height;
end;

procedure TCalcMain.UpdateHistoryList;
var i: Integer;
begin
  with listHistory do begin
    Clear();
    RowCount := HistoryList.Count;
    for i:=0 to HistoryList.Count-1 do
      Cols[0].Add(Shorten(HistoryList.Items[i], Canvas, listHistory.Width-5));

    if i>0 then begin
      Row := i-1;
      Select();
      HistoryList.Selected := Row;
    end;
  end;
end;

procedure TCalcMain.listHistorySelectionChanged(Sender: TObject; ALeft,
  ATop, ARight, ABottom: Integer);
begin
  HistoryList.Selected := ATop;
end;

procedure TCalcMain.listHistoryDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
var lex: TLexeme;
    expr: String;
begin
  lex := MathEdit.GetPrevLexeme(CalcField.Text, CalcField.SelStart);
  if not (lex.LexemeType in [ltOperation, ltCloseBracket, ltLongOperation]) then begin
    expr := HistoryList.GetExpression;
    CalcExpression();
    CalcField.Text := '';
    MathEdit.AddLexeme(expr, -1);
  end
  else actAddHistoryResult.Execute();
end;

procedure TCalcMain.actAddHistoryResultExecute(Sender: TObject);
begin
  with MathEdit do begin
    AddLexeme(HistoryList.GetResult, -1);
    GetFocusByEditor();
  end;
end;

procedure TCalcMain.actAddHistoryExpressionExecute(Sender: TObject);
begin
  with MathEdit do begin
    AddLexeme(HistoryList.GetExpression, -1);
    GetFocusByEditor;
  end;
end;

procedure TCalcMain.actDecExecute(Sender: TObject);
begin
  case NumberTypeSelectMode of
    ntsIn: with (Sender as TAction) do inNumberType := Tag;
    ntsOut: with (Sender as TAction) do outNumberType := Tag;
  end;
  NumberTypeSelectMode := ntsNone;
  UpdateNumberTypes;
end;

procedure TCalcMain.UpdateNumberTypes;
begin
  with btnInNumberType do begin
    case inNumberType of
      10: Caption := 'Dec';
      16: Caption := 'Hex';
      8: Caption := 'Oct';
      2: Caption := 'Bin';
    end;
  end;
  with btnOutNumberType do begin
    case outNumberType of
      10: Caption := 'Dec';
      16: Caption := 'Hex';
      8: Caption := 'Oct';
      2: Caption := 'Bin';
    end;
  end;
end;

procedure TCalcMain.btnInNumberTypeDropDown(Sender: TObject);
begin
  NumberTypeSelectMode := ntsIn;
end;

procedure TCalcMain.btnOutNumberTypeDropDown(Sender: TObject);
begin
  NumberTypeSelectMode := ntsOut;
end;

procedure TCalcMain.atbPagerChange(Sender: TObject);
begin
  MainWindowParams.PageIndex := atbPager.ActivePageIndex;
end;

procedure TCalcMain.actOptionsMainExecute(Sender: TObject);
begin
  ReadOrWriteParameters(True); //сохранить все параметры

  Options:=TOptions.Create(Application); //создать окно
  if Options.ShowModal = mrOK then //если ОК
    LoadAllParameters;
  Options.Destroy; //удалить окно
  if not Visible then Visible:=true; //показать главное окно
  SetForegroundWindow(CalcMain.Handle);
end;

procedure TCalcMain.actAboutExecute(Sender: TObject);
begin
  MessageBox(Handle,
    'Продвинутый калькулятор'#13#10'Разработал Курбангалиев Ильдус'#13#10'Версия 2.3.1'
    , 'О программе...', MB_OK or MB_ICONINFORMATION);
end;

procedure TCalcMain.actRestoreWindowExecute(Sender: TObject);
begin
  Visible:=not Visible;
  SetForegroundWindow(Handle);
end;

procedure TCalcMain.actVariablesExecute(Sender: TObject);
begin
  with VariableW do begin
    Visible:= not Visible;
    VisibleVariableWindow:=Visible;
  end;
end;

procedure TCalcMain.actCalcFieldFontExecute(Sender: TObject);
begin
  FontDialog.Font.Assign(CalcField.Font);
  with FontDialog do
    if Execute then CalcField.Font.Assign(Font);
end;

procedure TCalcMain.actHistoryFontExecute(Sender: TObject);
begin
  with FontDialog do begin
    Font.Assign(listHistory.Font);
    if Execute then listHistory.Font.Assign(Font);
  end;
end;

procedure TCalcMain.actExitExecute(Sender: TObject);
begin
  TerminateApplication;
end;

procedure TCalcMain.listHistoryResize(Sender: TObject);
begin
  UpdateHistoryList();
end;

end.
