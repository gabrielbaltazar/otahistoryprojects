unit OTAHistoryProjects.ContextMenu;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI;

type
  TOTAHPContextMenu = class(TNotifierObject, IOTAProjectMenuItemCreatorNotifier)
  protected
    procedure AddMenu(const AProject: IOTAProject; const AIdentList: TStrings;
      const AProjectManagerMenuList: IInterfaceList; AIsMultiSelect: Boolean);
  public
    class function New: IOTAProjectMenuItemCreatorNotifier;
  end;

  TOTAHPItemMenu = class(TNotifierObject, IOTALocalMenu, IOTAProjectManagerMenu)
  protected
    function GetCaption: string;
    function GetChecked: Boolean;
    function GetEnabled: Boolean;
    function GetHelpContext: Integer;
    function GetName: string;
    function GetParent: string;
    function GetPosition: Integer;
    function GetVerb: string;
    procedure SetCaption(const AValue: string);
    procedure SetChecked(AValue: Boolean);
    procedure SetEnabled(AValue: Boolean);
    procedure SetHelpContext(AValue: Integer);
    procedure SetName(const AValue: string);
    procedure SetParent(const AValue: string);
    procedure SetPosition(AValue: Integer);
    procedure SetVerb(const AValue: string);
    function GetIsMultiSelectable: Boolean;
    procedure SetIsMultiSelectable(AValue: Boolean);
    procedure Execute(const AMenuContextList: IInterfaceList); overload;
    function PreExecute(const AMenuContextList: IInterfaceList): Boolean;
    function PostExecute(const AMenuContextList: IInterfaceList): Boolean;
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

procedure TOTAHPContextMenu.AddMenu(const AProject: IOTAProject; const AIdentList: TStrings;
  const AProjectManagerMenuList: IInterfaceList; AIsMultiSelect: Boolean);
begin
  if (AIdentList.IndexOf(sProjectGroupContainer) < 0) then
    Exit;

  AProjectManagerMenuList.Add(TOTAHPItemMenu.New);
end;

class function TOTAHPContextMenu.New: IOTAProjectMenuItemCreatorNotifier;
begin
  Result := Self.Create;
end;

{ TOTAHPItemMenu }

procedure TOTAHPItemMenu.Execute(const AMenuContextList: IInterfaceList);
begin
  ShowHistoryProjects;
end;

function TOTAHPItemMenu.GetCaption: string;
begin
  Result := 'History Projects';
end;

function TOTAHPItemMenu.GetChecked: Boolean;
begin
  Result := False;
end;

function TOTAHPItemMenu.GetEnabled: Boolean;
begin
  Result := True;
end;

function TOTAHPItemMenu.GetHelpContext: Integer;
begin
  Result := 0;
end;

function TOTAHPItemMenu.GetIsMultiSelectable: Boolean;
begin
  Result := False;
end;

function TOTAHPItemMenu.GetName: string;
begin
  Result := 'imHistoryProjects';
end;

function TOTAHPItemMenu.GetParent: string;
begin
  Result := '';
end;

function TOTAHPItemMenu.GetPosition: Integer;
begin
  Result := pmmpAddExistingTarget + 100;;
end;

function TOTAHPItemMenu.GetVerb: string;
begin
  Result := 'HistoryProjects';
end;

class function TOTAHPItemMenu.New: IOTAProjectManagerMenu;
begin
  Result := Self.Create;
end;

function TOTAHPItemMenu.PostExecute(const AMenuContextList: IInterfaceList): Boolean;
begin
  Result := True;
end;

function TOTAHPItemMenu.PreExecute(const AMenuContextList: IInterfaceList): Boolean;
begin
  Result := True;
end;

procedure TOTAHPItemMenu.SetCaption(const AValue: string);
begin
end;

procedure TOTAHPItemMenu.SetChecked(AValue: Boolean);
begin
end;

procedure TOTAHPItemMenu.SetEnabled(AValue: Boolean);
begin
end;

procedure TOTAHPItemMenu.SetHelpContext(AValue: Integer);
begin
end;

procedure TOTAHPItemMenu.SetIsMultiSelectable(AValue: Boolean);
begin
end;

procedure TOTAHPItemMenu.SetName(const AValue: string);
begin
end;

procedure TOTAHPItemMenu.SetParent(const AValue: string);
begin
end;

procedure TOTAHPItemMenu.SetPosition(AValue: Integer);
begin
end;

procedure TOTAHPItemMenu.SetVerb(const AValue: string);
begin
end;

initialization

finalization
  (BorlandIDEServices as IOTAProjectManager)
    .RemoveMenuItemCreatorNotifier(IndexContextMenu);

end.
