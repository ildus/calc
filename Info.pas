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

//���������� - ��� ������� ������ � ������������

{
-------------------------------------------------------------------
��-������ �������� ���� ������ � uses

������������ �������

1 * G E T V E R S I O N *

  ��������
  procedure GetVersion(PlugInfo: PPluginInformation);
  ��� ������� ��������� ��� ������ ������� - ����� ��� ������
  ������������ ������������� ��� ������ ���������� �� ���� �������

2 * E X E C U T E P L U G I N *

  ��������
  procedure ExecutePlugin(MainForm: THandle);

  � ���� ������� �� �������� ���� ���� � ���������� �� � �������
  ����� ���������

-------------------------------------------------------------------
}

end.
