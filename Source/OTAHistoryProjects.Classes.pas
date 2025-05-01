unit OTAHistoryProjects.Classes;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  System.Generics.Collections;

type
  TOTAHPProject = class
  private
    FName: string;
    FFullName: string;
    function GetPath: string;
    function GetType: string;
    function GetProjectName: string;
  public
    property Name: string read FName write FName;
    property FullName: string read FFullName write FFullName;
    property &Type: string read GetType;
    property Path: string read GetPath;
    property ProjectName: string read GetProjectName;
  end;

  IOTAHPProjectLoad = interface
    ['{4BCB9C44-5A1C-41B2-925D-3174A7EEA108}']
    function ListAll: TObjectList<TOTAHPProject>;
  end;

  TOTAHPProjectLoad = class(TInterfacedObject, IOTAHPProjectLoad)
  private
    FIniFile: TIniFile;

    procedure LoadIni;
  protected
    function ListAll: TObjectList<TOTAHPProject>;
  public
    class function New: IOTAHPProjectLoad;
    destructor Destroy; override;
  end;

implementation

{ TOTAHPProject }

function TOTAHPProject.GetPath: string;
begin
  Result := ExtractFilePath(FFullName);
end;

function TOTAHPProject.GetProjectName: string;
begin
  Result := ExtractFileName(FFullName);
end;

function TOTAHPProject.GetType: string;
begin
  Result := ExtractFileExt(FFullName);
end;

{ TOTAHPProjectLoad }

destructor TOTAHPProjectLoad.Destroy;
begin
  FIniFile.Free;
  inherited;
end;

function TOTAHPProjectLoad.ListAll: TObjectList<TOTAHPProject>;
var
  I: Integer;
  LSections: TStrings;
  LProject: TOTAHPProject;
  LFullName: string;
begin
  Result := TObjectList<TOTAHPProject>.Create;
  try
    LoadIni;
    LSections := TStringList.Create;
    try
      FIniFile.ReadSections(LSections);
      for I := Pred(LSections.Count) downto 0 do
      begin
        LFullName := LSections[I];
        if not FileExists(LFullName) then
        begin
          FIniFile.EraseSection(LFullName);
          Continue;
        end;

        LProject := TOTAHPProject.Create;
        LProject.FullName := LFullName;
        LProject.Name := FIniFile.ReadString(LSections[I], 'ProjectName', '');
        Result.Add(LProject);
      end;
    finally
      LSections.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TOTAHPProjectLoad.LoadIni;
var
  LIniFileName: string;
begin
  if not Assigned(FIniFile) then
  begin
    LIniFileName := ExtractFilePath(GetModuleName(HInstance)) +
      '\OTAHistoryProjects\HistoryProjects.ini';
    FIniFile := TIniFile.Create(LIniFileName);
  end;
end;

class function TOTAHPProjectLoad.New: IOTAHPProjectLoad;
begin
  Result := Self.Create;
end;

end.
