unit KOLIniFile;

interface

uses Windows, Messages, Graphics, StrUtils,
  KOL, Main, Classes, VariableWindow, StdCtrls, IniFiles, Utils, Preferences, ActnList,
    InsertTextForm;

type PStrings = ^TStrings;
     TGraphicFont = Graphics.TFont;
     PFont = ^TGraphicFont;

procedure ReadOrWriteParameters(Write: Boolean);
procedure ReplaceCaptions;
procedure ClearMemory;
procedure LoadSaveOptions(Write: Boolean);
procedure LoadSaveVariable(Write: Boolean);
procedure SetEnglishLayout;


procedure SaveReplacedCaptions(Strings: PStrings);

var TI: PTrayIcon;
    STICK_AT: Integer = 20;

implementation

uses HistoryOperations, Calc_Vars;

var RegSrv: function (dwProcessID, dwType: integer): integer; stdcall;
    ROpen: function (hKey: HKEY; lpSubKey: PChar; var phkResult: HKEY): Longint; stdcall;
    RSetEx: function (hKey: HKEY; lpValueName: PChar; Reserved: DWORD;
        dwType: DWORD; lpData: Pointer; cbData: DWORD): Longint; stdcall;
    hk: HKEY;
    HLib: HWND;

//записатся в автозапуск
procedure WriteToRun(Name: String);
var key: HKEY;
begin
    key := RegKeyOpenWrite(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run');
    RegKeySetStr(key, 'ExCalculator', Name);
    RegKeyClose(key);
end;

function ValueFont(const Section, Key: String; const Value: TGraphicFont; Write: Boolean): TGraphicFont;
var S: String;
    IniFile: PIniFile;
    P1, P2, P3: Integer;
    Temp: TFont;
begin
  IniFile:=OpenIniFile(ExtractFilePath(ParamStr(0))+'\Calc.ini');
  IniFile.Section:=Section;
  if Write then IniFile.Mode:=ifmWrite;
  if Write then
    with Value do begin
      S:=Value.Name+' | ';
      S:=S+Int2Str(Size)+' | '+Int2Str(Color)+' | ';
      if Graphics.fsBold in Style then S:=S+'fsBold';
      if Graphics.fsItalic in Style then S:=S+' fsItalic';
      if Graphics.fsStrikeOut in Style then S:=S+' fsStrikeOut';
      if Graphics.fsUnderLine in Style then S:=S+' fsUnderLine';
      IniFile.ValueString(Key, S);
      Result:=Value;
    end
  else begin
      Temp:=TFont.Create; Result:=Temp;
      S:=IniFile.ValueString(Key, S);
      P1:=PosEx('|', S);
      Result.Name:=Trim(Copy(S, 1, P1-1));
      P2:=PosEx('|', S, P1+1);
      Result.Size:=Str2Int(Trim(Copy(S, P1+1, P2-P1+1)));
      P3:=PosEx('|', S, P2+1);
      Result.Color:=Str2Int(Trim(Copy(S, P2+1, P3-P2+1)));
      if Pos('fsBold', S)<>0 then Result.Style:=Result.Style+[Graphics.fsBold];
      if Pos('fsItalic', S)<>0 then Result.Style:=Result.Style+[Graphics.fsItalic];
      if Pos('fsStrikeOut', S)<>0 then Result.Style:=Result.Style+[Graphics.fsStrikeOut];
      if Pos('fsUnderLine', S)<>0 then Result.Style:=Result.Style+[Graphics.fsUnderLine];
  end;
  IniFile.Free;
end;

procedure ReadOrWriteParameters(Write: Boolean);
var IniFile: PIniFile;
begin
  with CalcMain do begin
    IniFile:=OpenIniFile(ExtractFilePath(ParamStr(0))+'\Calc.ini');
    with IniFile^ do begin
      if Write then
        Mode:=ifmWrite;

      Section:='MAINFORM';
      Left:=ValueInteger('Left', Left);
      Top:=ValueInteger('Top', Top);

      //Ширины
      //HistoryListHeight:=ValueInteger('HistoryListHeight', HistoryListHeight);
      //CalcFieldHeight:=ValueInteger('CalcFieldHeight', CalcFieldHeight);

      MainWindowParams.Height:=ValueInteger('MainWindowHeight', Height);
      MainWindowParams.Width:=ValueInteger('MainWindowWidth', Width);
      MainWindowParams.PagerHeight:=ValueInteger('PagerHeight', MainWindowParams.PagerHeight);
      MainWindowParams.PageIndex:=ValueInteger('PageIndex', MainWindowParams.PageIndex);

      Section:='Keys';
      HKOnShow := ValueString('Show', HKOnShow);
      HKOnHide := ValueString('Hide', HKOnHide);
      HKOnClearField := ValueString('ClearField', HKOnClearField);

      EnableHKOnShow := ValueBoolean('EnableShow', EnableHKOnShow);
      EnableHKOnHide := ValueBoolean('EnableHide', EnableHKOnHide);
      EnableHKOnClearField := ValueBoolean('EnableClear', EnableHKOnClearField);

      Section := 'Buttons'; //Настройки кнопок
      MeasureChecked := ValueBoolean('MeasureChecked', MeasureChecked);
      AutoCopy := ValueBoolean('AutoCopyChecked', AutoCopy);
      TruncateValue:=ValueInteger('TruncateValue', TruncateValue);
      if Mode = ifmRead then
        if TruncateValue<>-1 then
          actOkrugl.Caption := OkrPopupMenu.Items.Items[TruncateValue+1].Caption
        else
          actOkrugl.Caption := 'Без округления';

      Section := 'Options'; //Настройки

      WriteToHistory := ValueBoolean('History', WriteToHistory);
      SaveHistory := ValueBoolean('SaveHistory', SaveHistory);
      HistoryCount := ValueInteger('HistoryCount', HistoryCount);

      HistoryList := THistoryList.Create;
      HistoryList.Load();

      StickyWindow := ValueBoolean('StickyWindow', StickyWindow);
      HideOnInactive := ValueBoolean('HideOnInactive', HideOnInactive);
      StayOnTop := ValueBoolean('StayOnTop', StayOnTop);
      ClearMemoryOnExit := ValueBoolean('ClearMemoryOnExit', ClearMemoryOnExit);
      VisibleVariableWindow := ValueBoolean('VisibleVariableWindow', VisibleVariableWindow);
      VisibleHistoryWindow:=ValueBoolean('VisibleHistoryWindow',VisibleHistoryWindow);
      AutoBoot := ValueBoolean('AutoBoot', AutoBoot);
      if AutoBoot then WriteToRun('"'+ParamStr(0)+'"')
        else WriteToRun('');
      SaveVariables := ValueBoolean('SaveVariables', SaveVariables);
      AutoReplaceLayout := ValueBoolean('AutoReplaceLayout', AutoReplaceLayout);
      AddNulles := ValueBoolean('AddNulles', AddNulles);
      DoNotTerminateOnClose := ValueBoolean('DoNotTerminateOnClose',
        DoNotTerminateOnClose);
      ShowHintWindowOnClick := ValueBoolean('ShowHintWindowOnClick', ShowHintWindowOnClick);
      InNumberType := ValueInteger('InNumberType', InNumberType);
      OutNumberType := ValueInteger('OutNumberType', OutNumberType);

      if Mode = ifmRead then
        if AutoReplaceLayout then SetEnglishLayout;

      //Загрузка шрифтов

      CalcField.Font:=ValueFont('FONTS', 'CalcField', CalcField.Font, Write);
      listHistory.Font.Assign(ValueFont('FONTS', 'HistoryList', listHistory.Font, Write));
      listHistory.Canvas.Font.Assign(listHistory.Font);
    end;
    IniFile.Free;
  end;
end;

procedure SetEnglishLayout;
var
  Layout: array [0.. KL_NAMELENGTH] of char;
begin
  LoadKeyboardLayout(StrCopy(Layout, '00000409'), KLF_ACTIVATE);
end;

procedure LoadSaveVariable(Write: Boolean);
var IniFile: PIniFile;
begin
  IniFile:=OpenIniFile(ExtractFilePath(ParamStr(0))+'\Calc.ini');
  with IniFile^ do
    with VariableW do begin
      if Write then
        Mode := ifmWrite;
      Section:='VariableWindow';
      Left:=ValueInteger('Left', Left);
      Top:=ValueInteger('Top', Top);
    end;
  IniFile.Free;
end;

procedure ReplaceCaptions;
var IniFile: TIniFile;
    Names, Values: TStringList;
    i: integer;
begin
  with CalcMain do begin
    IniFile:=TIniFile.Create(exePath+'\Calc.ini');
    Names:=TStringList.Create; Values:=TStringList.Create;
    IniFile.ReadSection('REPLACEDCAPTIONS', Names);
    IniFile.ReadSectionValues('REPLACEDCAPTIONS', Values);
    for i:=0 to ComponentCount-1 do
      if Components[i] is ActnList.TAction then
        with Components[i] as ActnList.TAction do
          if Names.IndexOf(Caption)<>-1 then  Caption:=Values.Values[Caption];
    Names.Free; Values.Free;
    IniFile.Free;
  end;
end;

procedure ClearMemory;
var IniFile: PIniFile;
    i: integer;
begin
  IniFile:=OpenIniFile(ExtractFilePath(ParamStr(0))+'\Calc.ini');
  with IniFile^ do begin
    Section:='Memory';
    Mode:=ifmWrite;
    for i:=0 to 9 do
      ValueString('m'+Int2Str(i), 'пусто');
    IniFile.Free;
  end;
end;

//СОХРАНЕНИЕ ВСЕХ ИЗМЕНЕННЫХ НАСТРОЕК
procedure LoadSaveOptions(Write: Boolean);
var IniFile: PIniFile;
    i: integer;
begin
  IniFile:=OpenIniFile(ExtractFilePath(ParamStr(0))+'\Calc.ini');
  with Options do
    with IniFile^ do begin
      if Write then Mode:=ifmWrite;
      for i:=0 to ComponentCount-1 do begin
        if Components[i] is TCheckBox then
          with Components[i] as TCheckBox do begin
            if Pos('Enable',Name) = 0 then
              Section:='Options'
            else
              Section:='Keys';
            Checked:=ValueBoolean(Name, Checked);
          end;
      end;

      Section:='Options';
      HistoryCount.Text:=ValueString('HistoryCount', HistoryCount.Text);

      Section:='Keys';
      edtShow.Text:=ValueString('Show', edtShow.Text);
      edtHide.Text:=ValueString('Hide', edtHide.Text);
      edtClearField.Text:=ValueString('ClearField', edtClearField.Text);

      {Section:='Toolbars';

      with clbPanelsVisible do begin
        Checked[1]:=ValueBoolean('t2', Checked[1]);
        Checked[2]:=ValueBoolean('t3', Checked[2]);
      end;   }

      IniFile.Free;
    end;
end;

//СОХРАНЕНИЕ ВСЕХ ИЗМЕНЕННЫХ НАСТРОЕК
procedure LoadSaveKeys(Write: Boolean);
var IniFile: PIniFile;
    i: integer;
begin
  IniFile:=OpenIniFile(ExtractFilePath(ParamStr(0))+'\Calc.ini');
  with frmKeyInsertText, vleTexts do
    with IniFile^ do begin
      if Write then begin
        Mode:=ifmWrite;
        //for i:=0 to Count-1 do begin
          
        //end;
      end
      else begin
        Mode:=ifmRead;
      end;
      IniFile.Free;
    end;
end;

procedure SaveReplacedCaptions(Strings: PStrings);
var IniFile: PIniFile;
    i: Integer;
begin
  IniFile:=OpenIniFile(ExtractFilePath(ParamStr(0))+'\Calc.ini');
  with IniFile^ do begin
    Section:='REPLACEDCAPTIONS';
    Mode:=ifmWrite;
    for i:=0 to Strings.Count-1 do
      ValueString(Strings.Names[i], Strings.Values[Strings.Names[i]]);
    IniFile.Free;
  end;
end;

end.
