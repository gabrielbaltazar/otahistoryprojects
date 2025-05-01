unit OTAHistoryProjects.Registry;

interface

uses
  System.SysUtils,
  ToolsAPI,
  OTAHistoryProjects.MainMenu,
  OTAHistoryProjects.Notifier,
  OTAHistoryProjects.Forms,
  OTAHistoryProjects.ContextMenu,
  OTAHistoryProjects.Binding;

procedure Register;

implementation

procedure Register;
begin
  RegisterMainMenuWizard;
  RegisterHistoryProjectsNotifier;
  RegisterHistoryProjectsContextMenu;
  RegisterHistoryProjectBinding;
end;

end.
