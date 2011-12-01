{-----------------------------------------------------------------------------
 Unit Name: RbStyleManagerReg
 Purpose: Component Editor for RbStyleManager

 Author/Copyright: Nathanaël VERON - r.b.a.g@free.fr - http://r.b.a.g.free.fr


        Feel free to modify and improve source code, mail me (r.b.a.g@free.fr)
        if you make any big fix or improvement that can be included in the next
        versions. If you use the RbControls in your project please
        mention it or make a link to my website.

       ===============================================

       /*   14/10/2003    */
       Creation
-----------------------------------------------------------------------------}
unit RbStyleManagerReg;

interface

uses
  {$IFDEF VER130}
  DsgnIntf,
  {$ELSE}
  DesignEditors, DesignIntf,
  {$ENDIF}
  Menus, RbDrawCore, Forms, Controls, Dialogs, windows;

type
  TRbStyleManagerEditor = class(TComponentEditor)
  public
    { Public declarations }
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


procedure Register;

implementation

uses RbStyleEditor;

procedure Register;
begin
  RegisterComponentEditor( TRbStyleManager, TRbStyleManagerEditor);
end;


{---------------------------------------------
              TRbStyleManagerEditor
---------------------------------------------}

procedure TRbStyleManagerEditor.Edit;
begin
  inherited;

end;

procedure TRbStyleManagerEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: begin
         with TFStyleEditor.Create(Application) do try
           Loading := true;
           TRbStyleManager(Component).AssignTo(Smgr);
           UpdateComps;
           Loading := false;
           if ShowModal <> mrOk then Exit;
           SMgr.AssignTo(TRbStyleManager(Component));
           TRbStyleManager(Component).UpdateStyle;
           if Designer <> nil then
             Designer.Modified;
         finally
           Free;
         end;
       end;
     1: TRbStyleManager(Component).UpdateStyle;
  end;
end;

function TRbStyleManagerEditor.GetVerb(Index: Integer): string;
begin

  case Index of
    0: Result := 'Style Manager...';
    1: Result := 'Apply Style';
  end;
end;

function TRbStyleManagerEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

end.
