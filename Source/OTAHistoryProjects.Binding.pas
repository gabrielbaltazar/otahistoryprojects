unit OTAHistoryProjects.Binding;

interface

uses
  ToolsAPI,
  System.SysUtils,
  System.Classes,
  OTAHistoryProjects.Forms,
  Vcl.Menus;

type TOTAHPBinding = class(TNotifierObject, IOTAKeyboardBinding)

  private
    procedure Execute(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);

  protected
    function GetBindingType : TBindingType;
    function GetDisplayName : string;
    function GetName        : string;
    procedure BindKeyboard(const BindingServices: IOTAKeyBindingServices);

  public
    class function New: IOTAKeyboardBinding;
end;

var
  Index : Integer = -1;

procedure RegisterHistoryProjectBinding;

implementation

procedure RegisterHistoryProjectBinding;
begin
  Index := (BorlandIDEServices as IOTAKeyboardServices)
    .AddKeyboardBinding(TOTAHPBinding.New);
end;

{ TOTAHPBinding }

procedure TOTAHPBinding.BindKeyboard(const BindingServices: IOTAKeyBindingServices);
begin
  BindingServices.AddKeyBinding([TextToShortCut('Ctrl+Shift+P')], Execute,
    nil, 0, '', 'imOTAHistoryProjects');
end;

procedure TOTAHPBinding.Execute(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  BindingResult := krHandled;
  ShowHistoryProjects;
end;

function TOTAHPBinding.GetBindingType: TBindingType;
begin
  result := btPartial;
end;

function TOTAHPBinding.GetDisplayName: string;
begin
  result := Self.ClassName;
end;

function TOTAHPBinding.GetName: string;
begin
  result := Self.ClassName;
end;

class function TOTAHPBinding.New: IOTAKeyboardBinding;
begin
  result := Self.Create;
end;

initialization

finalization
  (BorlandIDEServices as IOTAKeyboardServices)
    .RemoveKeyboardBinding(Index);

end.
