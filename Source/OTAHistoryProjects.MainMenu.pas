unit OTAHistoryProjects.MainMenu;

interface

uses
  ToolsAPI,
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.Graphics,
  Vcl.ComCtrls,
  OTAHistoryProjects.Forms,
  System.Generics.Collections;

type TOTAHPMainMenuWizard = class(TNotifierObject, IOTAWizard)

  private
    procedure OnClickMenuHitoryProjects(Sender: TObject);

  protected
    procedure CreateMenu;

    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;

    procedure Execute;

  public
    class function New: IOTAWizard;
    constructor create;
    destructor Destroy; override;
end;

procedure RegisterMainMenuWizard;

implementation

procedure RegisterMainMenuWizard;
begin
  RegisterPackageWizard(TOTAHPMainMenuWizard.New);
end;

{ TOTAHPMainMenuWizard }

constructor TOTAHPMainMenuWizard.create;
begin
  CreateMenu;
end;

procedure TOTAHPMainMenuWizard.CreateMenu;
var
  menuItem: TMenuItem;
begin
  menuItem := TMenuItem.Create(nil);
  menuItem.Name := 'imOTAHistoryProjects';
  menuItem.Caption := 'History Projects';
  menuItem.OnClick := Self.OnClickMenuHitoryProjects;

  (BorlandIDEServices as INTAServices)
    .AddActionMenu('ToolsMenu', nil, menuItem, False, True);
end;

destructor TOTAHPMainMenuWizard.Destroy;
begin

  inherited;
end;

procedure TOTAHPMainMenuWizard.Execute;
begin

end;

function TOTAHPMainMenuWizard.GetIDString: string;
begin
  result := Self.ClassName;
end;

function TOTAHPMainMenuWizard.GetName: string;
begin
  result := Self.ClassName;
end;

function TOTAHPMainMenuWizard.GetState: TWizardState;
begin
  result := [wsEnabled];
end;

class function TOTAHPMainMenuWizard.New: IOTAWizard;
begin
  result := Self.create;
end;

procedure TOTAHPMainMenuWizard.OnClickMenuHitoryProjects(Sender: TObject);
begin
  ShowHistoryProjects;
end;

end.
