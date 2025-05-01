object FrmOTAHistoryProjects: TFrmOTAHistoryProjects
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'History'
  ClientHeight = 466
  ClientWidth = 840
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Consolas'
  Font.Style = []
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 19
  object PnlTitle: TPanel
    Left = 0
    Top = 0
    Width = 840
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'History Projects'
    Color = 1862369
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -21
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object PnlBack: TPanel
    Left = 0
    Top = 41
    Width = 840
    Height = 425
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object Label7: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 102
      Width = 837
      Height = 19
      Margins.Left = 0
      Margins.Top = 5
      Align = alTop
      Caption = 'History'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 63
    end
    object PnlTop: TPanel
      Left = 0
      Top = 0
      Width = 840
      Height = 48
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        840
        48)
      object EdtSearch: TEdit
        Left = 6
        Top = 10
        Width = 831
        Height = 27
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = EdtSearchChange
        OnKeyDown = EdtSearchKeyDown
      end
    end
    object EdtProjectType: TRadioGroup
      Left = 0
      Top = 48
      Width = 840
      Height = 49
      Align = alTop
      Caption = 'Project Type'
      Columns = 4
      ItemIndex = 0
      Items.Strings = (
        'All'
        'Dproj'
        'Dpk'
        'Group')
      TabOrder = 1
      OnClick = EdtProjectTypeClick
    end
    object PnlBottom: TPanel
      Left = 0
      Top = 320
      Width = 840
      Height = 105
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Label1: TLabel
        Left = 6
        Top = 11
        Width = 92
        Height = 21
        Caption = 'Project Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 1862369
        Font.Height = -16
        Font.Name = 'Segoe UI Semilight'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 6
        Top = 56
        Width = 30
        Height = 21
        Caption = 'Path'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 1862369
        Font.Height = -16
        Font.Name = 'Segoe UI Semilight'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 472
        Top = 11
        Width = 82
        Height = 21
        Caption = 'Project Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 1862369
        Font.Height = -16
        Font.Name = 'Segoe UI Semilight'
        Font.Style = []
        ParentFont = False
      end
      object DBText1: TDBText
        Left = 6
        Top = 33
        Width = 63
        Height = 19
        AutoSize = True
        DataField = 'ProjectName'
        DataSource = DataSourceProjects
      end
      object DBText2: TDBText
        Left = 6
        Top = 76
        Width = 63
        Height = 19
        AutoSize = True
        DataField = 'Path'
        DataSource = DataSourceProjects
      end
      object DBText3: TDBText
        Left = 472
        Top = 33
        Width = 63
        Height = 19
        AutoSize = True
        DataField = 'Type'
        DataSource = DataSourceProjects
      end
    end
    object GridProjects: TDBGrid
      Left = 0
      Top = 124
      Width = 840
      Height = 196
      Align = alClient
      DataSource = DataSourceProjects
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Consolas'
      TitleFont.Style = []
      OnKeyDown = GridProjectsKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'ProjectName'
          Title.Caption = 'Name'
          Width = 350
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Type'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FullName'
          Title.Caption = 'Full Name'
          Width = 500
          Visible = True
        end>
    end
  end
  object CdsProjects: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = CdsProjectsFilterRecord
    Left = 656
    Top = 8
  end
  object DataSourceProjects: TDataSource
    DataSet = CdsProjects
    Left = 712
    Top = 8
  end
end
