unit OTAHistoryProjects.Notifier;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  System.DateUtils,
  Vcl.Dialogs,
  ToolsAPI;

type
  TOTAHPNotifier = class(TNotifierObject, IOTANotifier, IOTAIDENotifier)
  protected
    { This procedure is called for many various file operations within the
      IDE }
    procedure FileNotification(ANotifyCode: TOTAFileNotification; const AFileName: string;
      var ACancel: Boolean);
    { This function is called immediately before the compiler is invoked.
      Set Cancel to True to cancel the compile }
    procedure BeforeCompile(const AProject: IOTAProject; var ACancel: Boolean); overload;
    { This procedure is called immediately following a compile.  Succeeded
      will be true if the compile was successful }
    procedure AfterCompile(ASucceeded: Boolean); overload;
  public
    class function New: IOTAIDENotifier;
  end;

var
  Index: Integer = -1;

procedure RegisterHistoryProjectsNotifier; overload;
procedure RegisterHistoryProjectsNotifier(ABorlandIDE: IBorlandIDEServices); overload;

implementation

{ TFSDHistoryProjectsNotifier }

procedure TOTAHPNotifier.AfterCompile(ASucceeded: Boolean);
begin
end;

procedure TOTAHPNotifier.BeforeCompile(const AProject: IOTAProject; var ACancel: Boolean);
begin
  ACancel := False;
end;

procedure TOTAHPNotifier.FileNotification(ANotifyCode: TOTAFileNotification;
  const AFileName: string; var ACancel: Boolean);
var
  LIniFile: TIniFile;
  LIniFileName: string;
  LFileExt: string;
begin
  ACancel := False;
  LFileExt := ExtractFileExt(AFileName);

  if (not LFileExt.Equals('.dproj')) and
    (not LFileExt.Equals('.groupproj')) or
    (ANotifyCode <> ofnFileOpened) then
    Exit;

  LIniFileName := ExtractFilePath(GetModuleName(HInstance)) +
    '\OTAHistoryProjects\HistoryProjects.ini';

  ForceDirectories(ExtractFilePath(LIniFileName));

  LIniFile := TIniFile.Create(LIniFileName);
  try
    LIniFile.WriteString(AFileName, 'ProjectName',
    ExtractFileName(AFileName).Replace(LFileExt, ''));
  finally
    LIniFile.Free;
  end;
end;

class function TOTAHPNotifier.New: IOTAIDENotifier;
begin
  Result := Self.Create;
end;

procedure RegisterHistoryProjectsNotifier;
begin
  Index := (BorlandIDEServices as IOTAServices).AddNotifier(TOTAHPNotifier.New);
end;

procedure RegisterHistoryProjectsNotifier(ABorlandIDE: IBorlandIDEServices);
begin
  Index := (ABorlandIDE as IOTAServices).AddNotifier(TOTAHPNotifier.New);
end;

initialization

finalization
  if Index >= 0 then
    (BorlandIDEServices as IOTAServices).RemoveNotifier(Index);
end.
