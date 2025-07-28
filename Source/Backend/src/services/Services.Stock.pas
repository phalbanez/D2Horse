unit Services.Stock;

interface

uses
  System.SysUtils, System.Classes, Providers.CRUD, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, System.Generics.Collections;

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
  public
    function ListAll(const AQueryParams: TDictionary<string, string>): TDataSet; override;
  end;

implementation

{$R *.dfm}

function TServiceStock.ListAll(const AQueryParams: TDictionary<string, string>): TDataSet;
begin
  for var LQuery in GetQuerysFilters do
  begin
    if AQueryParams.ContainsKey('product_id') then
    begin
      LQuery.SQL.Add(' and product_id = :product_id');
      LQuery.ParamByName('product_id').AsInteger := AQueryParams.Items['product_id'].ToInteger;
    end;

    if AQueryParams.ContainsKey('business_id') then
    begin
      LQuery.SQL.Add(' and business_id = :business_id');
      LQuery.ParamByName('business_id').AsInteger := AQueryParams.Items['business_id'].ToInteger;
    end;
  end;

  Result := inherited ListAll(AQueryParams);
end;

procedure TServiceStock.qryCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (qryCadastro.State = dsInsert) then
    qryCadastroOPERATION_DATE.AsDateTime := Now
  else
    qryCadastroOPERATION_DATE.AsDateTime := qryCadastroOPERATION_DATE.OldValue;
end;

end.
