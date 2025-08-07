unit Services.Products;

interface

uses
  System.SysUtils, System.Classes, Providers.CRUD, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, System.JSON, System.Generics.Collections;

type
  TServiceProduct = class(TProviderCrud)
    qryCadastroID: TIntegerField;
    qryCadastroCATEGORY_ID: TIntegerField;
    qryCadastroNAME: TWideStringField;
    qryCadastroBARCODE: TWideStringField;
    qryCadastroACTIVE: TBooleanField;
    qryCadastroDESCRIPTION: TWideStringField;
    qryCadastroPRICE: TSingleField;
    qryPesquisaID: TIntegerField;
    qryPesquisaCATEGORY_ID: TIntegerField;
    qryPesquisaNAME: TWideStringField;
    qryPesquisaBARCODE: TWideStringField;
    qryPesquisaACTIVE: TBooleanField;
    qryPesquisaPRICE: TSingleField;
    qryPesquisaIMAGE_PATH: TWideStringField;
    qryPesquisaQUANTITY: TFloatField;
    dsCadastro: TDataSource;
    qryImages: TFDQuery;
    qryImagesID: TIntegerField;
    qryImagesPRODUCT_ID: TIntegerField;
    qryImagesIMAGE_PATH: TWideStringField;
  private
    { Private declarations }
  public
    function Append(const AValue: TJSONObject): Boolean; override;
    function GetById(const AId: Integer): TDataSet; override;
    function ListAll(const AQueryParams: TDictionary<string, string>): TDataSet; override;
  end;

implementation

{$R *.dfm}

function TServiceProduct.Append(const AValue: TJSONObject): Boolean;
begin
  qryImages.ParamByName('product_id').AsInteger := -1;
  qryImages.Open;

  Result := inherited Append(AValue);
end;

function TServiceProduct.GetById(const AId: Integer): TDataSet;
begin
  Result := inherited GetById(AId);

  if (Result.IsEmpty) then Exit;

  qryImages.ParamByName('product_id').AsInteger := AId;
  qryImages.Open;
end;

function TServiceProduct.ListAll(const AQueryParams: TDictionary<string, string>): TDataSet;
begin
  for var LQuery in GetQuerysFilters do begin
    if AQueryParams.ContainsKey('id') then
    begin
      LQuery.SQL.Add(' and id = :id');
      LQuery.ParamByName('id').AsInteger := AQueryParams.Items['id'].ToInteger;
    end;

    if AQueryParams.ContainsKey('category_id') then
    begin
      LQuery.SQL.Add(' and category_id = :category_id');
      LQuery.ParamByName('category_id').AsInteger := AQueryParams.Items['category_id'].ToInteger;
    end;

    if AQueryParams.ContainsKey('active') then
    begin
      LQuery.SQL.Add(' and active = :active');
      LQuery.ParamByName('active').AsBoolean := AQueryParams.Items['active'].ToBoolean;
    end;

    if AQueryParams.ContainsKey('name') then
    begin
      LQuery.SQL.Add(' and name containing(:name)');
      LQuery.ParamByName('name').AsString := AQueryParams.Items['name'];
    end;

    if AQueryParams.ContainsKey('barcode') then
    begin
      LQuery.SQL.Add(' and barcode = :barcode');
      LQuery.ParamByName('barcode').AsString := AQueryParams.Items['barcode'];
    end;
  end;

  Result := inherited ListAll(AQueryParams);
end;

end.
