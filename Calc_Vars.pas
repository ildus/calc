unit Calc_Vars;

interface

uses SysUtils;

var

  exePath: String = '';

  //��������� ���������, �������������� ����������� �� INI-�����

  HKOnShow: String = 'CTRL+LEFT';  //������� �� ������� � �����������
  HKOnHide: String = 'ESC';  //������� �� �������
  HKOnClearField: String = 'DELETE'; //������� �� ������� ����

  EnableHKOnShow: boolean = true;
  EnableHKOnHide: boolean = true;
  EnableHKOnClearField: boolean = true;

  //HistoryListHeight: Integer = 40; //������ ������ �������
  //CalcFieldHeight: Integer = 40; //������ ����������

  MainWindowParams: record
    Height, Width: Integer;
    PagerHeight: Integer;
    PageIndex: Integer;
  end;

  WriteToHistory: Boolean = true; //������������ �������
  HistoryCount: Word = 20; //���������� ������� �������
  SaveHistory: Boolean = true; //��������� �������?

  StickyWindow: Boolean = true; //������ ���� �����������
  HideOnInactive: Boolean = true; //������� ��� �����������
  StayOnTop: Boolean = false; //������ �������
  AutoBoot: Boolean = false;  //������������
  SaveVariables: Boolean = false; //��������� ����������
  AutoReplaceLayout: Boolean = false; //������������� �����
  ClearMemoryOnExit: Boolean = false; //������� ������ ��� ������
  AddNulles: Boolean = true;
  MeasureChecked: Boolean = true; //������� ��� �������

  VisibleVariableWindow: Boolean = false;
  VisibleHistoryWindow: Boolean = false;
  AutoCopy: Boolean = true; //��������������� ����������
  DoNotTerminateOnClose: Boolean = True;
  ShowHintWindowOnClick: Boolean = True;
  InNumberType: Byte = 10; //������� ���������
  OutNumberType: Byte = 10; //������� ���������

  update_exe: String = '';
  update_version: String = 'version.txt';

implementation

initialization

exePath := ExtractFilePath(ParamStr(0));

end.
