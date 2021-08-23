unit OTAHistoryProjects.ContextMenu;

interface

uses
  ToolsAPI,
  System.SysUtils,
  System.Classes;

type
  TOTAHPContextMenu = class(TNotifierObject, IOTAProjectMenuItemCreatorNotifier)
  protected
    procedure AddMenu(const Project: IOTAProject;
                      const IdentList: TStrings;
                      const ProjectManagerMenuList: IInterfaceList;
                            IsMultiSelect: Boolean);
  public
    class function New: IOTAProjectMenuItemCreatorNotifier;
  end;

  TOTAHPItemMenu = class(TNotifierObject, IOTALocalMenu, IOTAProjectManagerMenu)
  private

  protected
    function GetCaption: string;
    function GetChecked: Boolean;
    function GetEnabled: Boolean;
    function GetHelpContext: Integer;
    function GetName: string;
    function GetParent: string;
    function GetPosition: Integer;
    function GetVerb: string;
    procedure SetCaption(const Value: string);
    procedure SetChecked(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetHelpContext(Value: Integer);
    procedure SetName(const Value: string);
    procedure SetParent(const Value: string);
    procedure SetPosition(Value: Integer);
    procedure SetVerb(const Value: string);
    function GetIsMultiSelectable: Boolean;
    procedure SetIsMultiSelectable(Value: Boolean);
    procedure Execute(const MenuContextList: IInterfaceList); overload;
    function PreExecute(const MenuContextList: IInterfaceList): Boolean;
    function PostExecute(const MenuContextList: IInterfaceList): Boolean;

  public
    class function New: IOTAProjectManagerMenu;
  end;

var
  IndexContextMenu: Integer = -1;

procedure RegisterHistoryProjectsContextMenu;

implementation

uses
  OTAHistoryProjects.Forms;

procedure RegisterHistoryProjectsContextMenu;
begin
  IndexContextMenu := (BorlandIDEServices as IOTAProjectManager)
    .AddMenuItemCreatorNotifier(TOTAHPContextMenu.New);
end;

{ TOTAHPContextMenu }

procedure TOTAHPContextMenu.AddMenu(const Project: IOTAProject;
                                    const IdentList: TStrings;
                                    const ProjectManagerMenuList: IInterfaceList;
                                          IsMultiSelect: Boolean);
begin
  if (IdentList.IndexOf(sProjectGroupContainer) < 0) then
    Exit;

  ProjectManagerMenuList.Add(TOTAHPItemMenu.New);
end;

class function TOTAHPContextMenu.New: IOTAProjectMenuItemCreatorNotifier;
begin
  result := Self.Create;
end;

{ TOTAHPItemMenu }

procedure TOTAHPItemMenu.Execute(const MenuContextList: IInterfaceList);
begin
  ShowHistoryProjects;
end;

function TOTAHPItemMenu.GetCaption: string;
begin
  result := 'History Projects';
end;

function TOTAHPItemMenu.GetChecked: Boolean;
begin
  result := False;
end;

function TOTAHPItemMenu.GetEnabled: Boolean;
begin
  Result := True;
end;

function TOTAHPItemMenu.GetHelpContext: Integer;
begin
  result := 0;
end;

function TOTAHPItemMenu.GetIsMultiSelectable: Boolean;
begin
  result := False;
end;

function TOTAHPItemMenu.GetName: string;
begin
  result := 'imHistoryProjects';
end;

function TOTAHPItemMenu.GetParent: string;
begin
  result := '';
end;

function TOTAHPItemMenu.GetPosition: Integer;
begin
  result := pmmpAddExistingTarget + 100;;
end;

function TOTAHPItemMenu.GetVerb: string;
begin
  Result := 'HistoryProjects';
end;

class function TOTAHPItemMenu.New: IOTAProjectManagerMenu;
begin
  result := Self.create;
end;

function TOTAHPItemMenu.PostExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  result := True;
end;

function TOTAHPItemMenu.PreExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  result := True;
end;

procedure TOTAHPItemMenu.SetCaption(const Value: string);
begin

end;

procedure TOTAHPItemMenu.SetChecked(Value: Boolean);
begin

end;

procedure TOTAHPItemMenu.SetEnabled(Value: Boolean);
begin

end;

procedure TOTAHPItemMenu.SetHelpContext(Value: Integer);
begin

end;

procedure TOTAHPItemMenu.SetIsMultiSelectable(Value: Boolean);
begin

end;

procedure TOTAHPItemMenu.SetName(const Value: string);
begin

end;

procedure TOTAHPItemMenu.SetParent(const Value: string);
begin

end;

procedure TOTAHPItemMenu.SetPosition(Value: Integer);
begin

end;

procedure TOTAHPItemMenu.SetVerb(const Value: string);
begin

end;

initialization

finalization
  (BorlandIDEServices as IOTAProjectManager)
    .RemoveMenuItemCreatorNotifier(IndexContextMenu);

end.
