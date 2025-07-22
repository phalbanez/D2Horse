unit Services.Stock;

interface

uses
  System.SysUtils, System.Classes, Providers.CRUD, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait;

type
  TServiceStock = class(TProviderCrud)
    qryPesquisaID: TIntegerField;
    qryPesquisaPRODUCT_ID: TIntegerField;
    qryPesquisaBUSINESS_ID: TIntegerField;
    qryPesquisaUSER_ID: TIntegerField;
    qryPesquisaOPERATION_DATE: TSQLTimeStampField;
    qryPesquisaQUANTITY: TSingleField;
    qryPesquisaOPERATION: TWideStringField;
    qryCadastroID: TIntegerField;
    qryCadastroPRODUCT_ID: TIntegerField;
    qryCadastroBUSINESS_ID: TIntegerField;
    qryCadastroUSER_ID: TIntegerField;
    qryCadastroOPERATION_DATE: TSQLTimeStampField;
    qryCadastroQUANTITY: TSingleField;
    qryCadastroOPERATION: TWideStringField;
    procedure qryCadastroBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TServiceStock.qryCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (qryCadastro.State = dsInsert) then
    qryCadastroOPERATION_DATE.AsDateTime := Now
  else
    qryCadastroOPERATION_DATE.AsDateTime := qryCadastroOPERATION_DATE.OldValue;
end;

end.
