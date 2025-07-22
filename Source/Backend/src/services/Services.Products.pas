unit Services.Products;

interface

uses
  System.SysUtils, System.Classes, Providers.CRUD, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait;

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
    function GetById(const AId: Integer): TDataSet; override;
  end;

implementation

{$R *.dfm}

function TServiceProduct.GetById(const AId: Integer): TDataSet;
begin
  Result := inherited GetById(AId);

  if (Result.IsEmpty) then Exit;

  qryImages.ParamByName('product_id').AsInteger := AId;
  qryImages.Open;
end;

end.
