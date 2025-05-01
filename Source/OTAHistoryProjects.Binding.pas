unit OTAHistoryProjects.Binding;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI,
  Vcl.Menus,
  OTAHistoryProjects.Forms;

type
  TOTAHPBinding = class(TNotifierObject, IOTAKeyboardBinding)
  private
    procedure Execute(const AContext: IOTAKeyContext; AKeyCode: TShortcut;
      var ABindingResult: TKeyBindingResult);
  protected
    function GetBindingType: TBindingType;
    function GetDisplayName: string;
    function GetName: string;
    procedure BindKeyboard(const ABindingServices: IOTAKeyBindingServices);
  public
    class function New: IOTAKeyboardBinding;
  end;

var
  Index: Integer = -1;

procedure RegisterHistoryProjectBinding;

implementation

procedure RegisterHistoryProjectBinding;
begin
  Index := (BorlandIDEServices as IOTAKeyboardServices)
    .AddKeyboardBinding(TOTAHPBinding.New);
end;

{ TOTAHPBinding }

procedure TOTAHPBinding.BindKeyboard(const ABindingServices: IOTAKeyBindingServices);
begin
  ABindingServices.AddKeyBinding([TextToShortCut('Ctrl+Shift+P')], Execute,
    nil, 0, '', 'imOTAHistoryProjects');
end;

procedure TOTAHPBinding.Execute(const AContext: IOTAKeyContext; AKeyCode: TShortcut;
  var ABindingResult: TKeyBindingResult);
begin
  ABindingResult := krHandled;
  ShowHistoryProjects;
end;

function TOTAHPBinding.GetBindingType: TBindingType;
begin
  Result := btPartial;
end;

function TOTAHPBinding.GetDisplayName: string;
begin
  Result := Self.ClassName;
end;

function TOTAHPBinding.GetName: string;
begin
  Result := Self.ClassName;
end;

class function TOTAHPBinding.New: IOTAKeyboardBinding;
begin
  Result := Self.Create;
end;

initialization

finalization
  (BorlandIDEServices as IOTAKeyboardServices)
    .RemoveKeyboardBinding(Index);

end.
