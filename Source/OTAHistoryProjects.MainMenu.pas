unit OTAHistoryProjects.MainMenu;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.Graphics,
  Vcl.ComCtrls,
  ToolsAPI,
  OTAHistoryProjects.Forms;

type
  TOTAHPMainMenuWizard = class(TNotifierObject, IOTAWizard)
  private
    procedure OnClickMenuHitoryProjects(ASender: TObject);
  protected
    procedure CreateMenu;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
  public
    class function New: IOTAWizard;
    constructor Create;
  end;

procedure RegisterMainMenuWizard;

implementation

procedure RegisterMainMenuWizard;
begin
  RegisterPackageWizard(TOTAHPMainMenuWizard.New);
end;

{ TOTAHPMainMenuWizard }

constructor TOTAHPMainMenuWizard.Create;
begin
  CreateMenu;
end;

procedure TOTAHPMainMenuWizard.CreateMenu;
var
  LMenuItem: TMenuItem;
begin
  LMenuItem := TMenuItem.Create(nil);
  LMenuItem.Name := 'imOTAHistoryProjects';
  LMenuItem.Caption := 'History Projects';
  LMenuItem.OnClick := Self.OnClickMenuHitoryProjects;

  (BorlandIDEServices as INTAServices)
    .AddActionMenu('ToolsMenu', nil, LMenuItem, False, True);
end;

procedure TOTAHPMainMenuWizard.Execute;
begin
end;

function TOTAHPMainMenuWizard.GetIDString: string;
begin
  Result := Self.ClassName;
end;

function TOTAHPMainMenuWizard.GetName: string;
begin
  Result := Self.ClassName;
end;

function TOTAHPMainMenuWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

class function TOTAHPMainMenuWizard.New: IOTAWizard;
begin
  Result := Self.Create;
end;

procedure TOTAHPMainMenuWizard.OnClickMenuHitoryProjects(ASender: TObject);
begin
  ShowHistoryProjects;
end;

end.
