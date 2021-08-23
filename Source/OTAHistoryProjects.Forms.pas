unit OTAHistoryProjects.Forms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.IniFiles, ToolsAPI, Vcl.AppEvnts;

type
  TFrmOTAHistoryProjects = class(TForm)
    pnlTop: TPanel;
    edtSearch: TEdit;
    lstProjects: TListBox;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lstProjectsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lstProjectsDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FIniFile: TIniFile;
    { Private declarations }

    procedure OpenProject;

    procedure loadIniFile;
    procedure listProjects;
  public
    { Public declarations }
  end;

var
  FrmOTAHistoryProjects: TFrmOTAHistoryProjects;

procedure ShowHistoryProjects;

implementation

procedure ShowHistoryProjects;
begin
  if not Assigned(FrmOTAHistoryProjects) then
    FrmOTAHistoryProjects := TFrmOTAHistoryProjects.Create(nil);

  FrmOTAHistoryProjects.ShowModal;
end;

{$R *.dfm}

{ TFrmOTAHistoryProjects }

procedure TFrmOTAHistoryProjects.OpenProject;
var
  projectPath: String;
  selected: string;
  index: Integer;
begin
  index := 0;
  if (lstProjects.ItemIndex >= 0) then
    index := lstProjects.ItemIndex;

  selected := lstProjects.Items[index];
  projectPath := (Copy(selected, Pos('|', selected) + 1, 5000)).Trim;

  (BorlandIDEServices as IOTAModuleServices)
    .OpenModule(projectPath);

  ModalResult := mrOk;
end;

procedure TFrmOTAHistoryProjects.edtSearchChange(Sender: TObject);
begin
  listProjects;
end;

procedure TFrmOTAHistoryProjects.edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    OpenProject;

  if Key = VK_ESCAPE then
    Close;
end;

procedure TFrmOTAHistoryProjects.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FIniFile);
end;

procedure TFrmOTAHistoryProjects.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TFrmOTAHistoryProjects.FormShow(Sender: TObject);
begin
  listProjects;
  edtSearch.SetFocus;
end;

procedure TFrmOTAHistoryProjects.listProjects;
var
  sections: TStrings;
  search : string;
  projectName: String;
  fileName: string;
  i: Integer;
begin
  loadIniFile;
  lstProjects.Clear;
  search := LowerCase( edtSearch.Text );
  sections := TStringList.Create;
  try
    FIniFile.ReadSections(sections);

    for i := 0 to Pred(sections.Count) do
    begin
      projectName := FIniFile.ReadString(sections[i], 'ProjectName', '');
      fileName := sections[i];

      if not FileExists(fileName) then
        Continue;

      if (search.Trim.IsEmpty) or
         (fileName.ToLower.Contains(search)) or
         (projectName.ToLower.Contains(search)) then
        lstProjects.Items.Add(projectName + ' | ' + fileName);
    end;
  finally
    sections.Free;
  end;
end;

procedure TFrmOTAHistoryProjects.loadIniFile;
var
  iniFileName: string;
begin
  FreeAndNil(FIniFile);
  iniFileName := ExtractFilePath(GetModuleName(HInstance)) +
      '\OTAHistoryProjects\HistoryProjects.ini';

  FIniFile := TIniFile.Create(iniFileName);
end;

procedure TFrmOTAHistoryProjects.lstProjectsDblClick(Sender: TObject);
begin
  OpenProject;
end;

procedure TFrmOTAHistoryProjects.lstProjectsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    OpenProject;

  if Key = VK_ESCAPE then
    Close;
end;

initialization
  {$IF CompilerVersion >= 32.0}
  (BorlandIDEServices as IOTAIDEThemingServices250)
    .RegisterFormClass(TFrmOTAHistoryProjects);
  {$ENDIF}

finalization
  FrmOTAHistoryProjects.Free;

end.
