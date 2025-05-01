unit OTAHistoryProjects.Forms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  ToolsAPI, Vcl.AppEvnts, Vcl.Imaging.pngimage,
  System.Generics.Collections,
  OTAHistoryProjects.Classes, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Datasnap.DBClient;

type
  TFrmOTAHistoryProjects = class(TForm)
    PnlTop: TPanel;
    EdtSearch: TEdit;
    PnlTitle: TPanel;
    PnlBack: TPanel;
    Label7: TLabel;
    EdtProjectType: TRadioGroup;
    PnlBottom: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    GridProjects: TDBGrid;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    CdsProjects: TClientDataSet;
    DataSourceProjects: TDataSource;
    ImgRefresh: TImage;
    procedure FormShow(Sender: TObject);
    procedure EdtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LstProjectsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LstProjectsDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CdsProjectsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure EdtProjectTypeClick(Sender: TObject);
    procedure EdtSearchChange(Sender: TObject);
    procedure GridProjectsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ImgRefreshClick(Sender: TObject);
  private
    FProjects: TObjectList<TOTAHPProject>;

    procedure CreateDataSet;
    procedure Filter;

    procedure OpenProject;
    procedure ListProjects;
  public
    destructor Destroy; override;
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
  LProjectPath: string;
begin
  LProjectPath := CdsProjects.FieldByName('FullName').AsString;
  (BorlandIDEServices as IOTAModuleServices)
    .OpenModule(LProjectPath);
  ModalResult := mrOk;
end;

procedure TFrmOTAHistoryProjects.CdsProjectsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  LProjectType: string;
  LSearch: string;
begin
  Accept := True;
  LProjectType := EmptyStr;
  case EdtProjectType.ItemIndex of
    1: LProjectType := '.dproj';
    2: LProjectType := '.groupproj';
  end;

  if LProjectType <> EmptyStr then
    Accept := DataSet.FieldByName('Type').AsString.ToLower.Equals(LProjectType);

  if not Accept then
    Exit;

  LSearch := LowerCase(EdtSearch.Text).Trim;
  Accept := (LSearch.IsEmpty) or
    (DataSet.FieldByName('FullName').AsString.ToLower.Contains(LSearch));
end;

procedure TFrmOTAHistoryProjects.CreateDataSet;
begin
  if CdsProjects.FieldCount = 0 then
  begin
    CdsProjects.FieldDefs.Add('Name', ftString, 200);
    CdsProjects.FieldDefs.Add('FullName', ftString, 5000);
    CdsProjects.FieldDefs.Add('Type', ftString, 20);
    CdsProjects.FieldDefs.Add('Path', ftString, 5000);
    CdsProjects.FieldDefs.Add('ProjectName', ftString, 200);
    CdsProjects.CreateDataSet;
    CdsProjects.Active := True;
  end;
end;

destructor TFrmOTAHistoryProjects.Destroy;
begin
  FProjects.Free;
  inherited;
end;

procedure TFrmOTAHistoryProjects.EdtProjectTypeClick(Sender: TObject);
begin
  Filter;
end;

procedure TFrmOTAHistoryProjects.EdtSearchChange(Sender: TObject);
begin
  Filter;
end;

procedure TFrmOTAHistoryProjects.EdtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    OpenProject
  else
  if Key = VK_ESCAPE then
    Close
  else
    Filter;
end;

procedure TFrmOTAHistoryProjects.Filter;
begin
  CdsProjects.Filtered := False;
  CdsProjects.Filtered := True;
end;

procedure TFrmOTAHistoryProjects.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TFrmOTAHistoryProjects.FormShow(Sender: TObject);
begin
  CreateDataSet;
  ListProjects;
  EdtSearch.SetFocus;
end;

procedure TFrmOTAHistoryProjects.GridProjectsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    OpenProject;
end;

procedure TFrmOTAHistoryProjects.ImgRefreshClick(Sender: TObject);
begin
  FreeAndNil(FProjects);
  ListProjects;
end;

procedure TFrmOTAHistoryProjects.ListProjects;
var
  LProject: TOTAHPProject;
begin
  if not Assigned(FProjects) then
    FProjects := TOTAHPProjectLoad.New.ListAll;

  CdsProjects.First;
  while not CdsProjects.Eof do
    CdsProjects.Delete;

  for LProject in FProjects do
  begin
    CdsProjects.Append;
    CdsProjects.FieldByName('Name').AsString := LProject.Name;
    CdsProjects.FieldByName('FullName').AsString := LProject.FullName;
    CdsProjects.FieldByName('Type').AsString := LProject.&Type;
    CdsProjects.FieldByName('Path').AsString := LProject.Path;
    CdsProjects.FieldByName('ProjectName').AsString := LProject.ProjectName;
    CdsProjects.Post;
  end;
  CdsProjects.IndexFieldNames := 'Name';
  CdsProjects.First;
end;

procedure TFrmOTAHistoryProjects.LstProjectsDblClick(Sender: TObject);
begin
  OpenProject;
end;

procedure TFrmOTAHistoryProjects.LstProjectsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    OpenProject;

  if Key = VK_ESCAPE then
    Close;
end;

initialization

finalization
  FrmOTAHistoryProjects.Free;

end.
