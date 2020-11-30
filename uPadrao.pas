unit uPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ToolWin, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls;

type
  TfrmPadraoSimples = class(TForm)
    ToolBar1: TToolBar;
    spbRefresh: TSpeedButton;
    spbCancelar: TSpeedButton;
    spbSalvar: TSpeedButton;
    spbExcluir: TSpeedButton;
    spbEditar: TSpeedButton;
    spbIncluir: TSpeedButton;
    dtsPadrao: TDataSource;
    dbgPadrao: TDBGrid;
    spbPesquisar: TSpeedButton;
    dbnPadrao: TDBNavigator;
    Panel1: TPanel;
    edtPesquisar: TEdit;
    procedure spbIncluirClick(Sender: TObject);
    procedure spbEditarClick(Sender: TObject);
    procedure spbExcluirClick(Sender: TObject);
    procedure spbSalvarClick(Sender: TObject);
    procedure spbCancelarClick(Sender: TObject);
    procedure dtsPadraoStateChange(Sender: TObject);
    procedure spbPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    procedure habilitaControles;
  public
    { Public declarations }
  end;

var
  frmPadraoSimples: TfrmPadraoSimples;

implementation

{$R *.dfm}

procedure TfrmPadraoSimples.dtsPadraoStateChange(Sender: TObject);
begin
  habilitaControles;
end;

procedure TfrmPadraoSimples.habilitaControles;
var
  boVazio: boolean;
begin
  boVazio := dtsPadrao.DataSet.IsEmpty;
  spbIncluir.Enabled  := not(dtsPadrao.DataSet.State in [dsInsert, dsEdit]);
  spbSalvar.Enabled   := (dtsPadrao.DataSet.State in [dsInsert, dsEdit]);
  spbEditar.Enabled   := (dtsPadrao.DataSet.State in [dsBrowse]) and not (boVazio);
  spbExcluir.Enabled  := not (dtsPadrao.DataSet.State in [dsInsert, dsEdit]) and not (boVazio);
  spbCancelar.Enabled := (dtsPadrao.DataSet.State in [dsInsert, dsEdit]);
  spbPesquisar.Enabled := not (dtsPadrao.DataSet.State in [dsInsert, dsEdit]) and not (boVazio);
end;

procedure TfrmPadraoSimples.spbCancelarClick(Sender: TObject);
begin
  if MessageDlg('Deseja cancelar as alterações?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    dtsPadrao.DataSet.Cancel;
end;

procedure TfrmPadraoSimples.spbEditarClick(Sender: TObject);
begin
  if dtsPadrao.DataSet <> nil then
    dtsPadrao.DataSet.Edit;
end;

procedure TfrmPadraoSimples.spbExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    dtsPadrao.DataSet.Delete;
end;

procedure TfrmPadraoSimples.spbIncluirClick(Sender: TObject);
begin
  if dtsPadrao.DataSet <> nil then
    dtsPadrao.DataSet.Insert;
end;

procedure TfrmPadraoSimples.spbPesquisarClick(Sender: TObject);
begin
  edtPesquisar.Visible := not edtPesquisar.Visible;
end;

procedure TfrmPadraoSimples.spbSalvarClick(Sender: TObject);
begin
  dtsPadrao.DataSet.Post;
end;

end.
