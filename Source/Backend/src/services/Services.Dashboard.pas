unit Services.Dashboard;

interface

uses
  System.SysUtils, System.Classes, System.JSON;

type
  TServiceDashboard = class(TDataModule)
  private
    function GetRecordCountBusiness: Int64;
    function GetRecordCountProducts: Int64;
    function GetRecordCountCategories: Int64;
  public
    function GetDashbordData: TJSONObject;
  end;

implementation

{$R *.dfm}

uses
  Services.Business, Services.Products, Services.Categories;

{ TServiceDashboard }

function TServiceDashboard.GetDashbordData: TJSONObject;
begin
   Result := TJSONObject.Create;
   Result.AddPair('business', GetRecordCountBusiness);
   Result.AddPair('products', GetRecordCountProducts);
   Result.AddPair('categories', GetRecordCountCategories);
end;

function TServiceDashboard.GetRecordCountBusiness: Int64;
var
  LService: TServiceBusiness;
begin
  LService := TServiceBusiness.Create;
  try
    Result := LService.GetRecordCount;
  finally
    LService.Free;
  end;
end;

function TServiceDashboard.GetRecordCountCategories: Int64;
var
  LService: TServiceCategory;
begin
  LService := TServiceCategory.Create;
  try
    Result := LService.GetRecordCount;
  finally
    LService.Free;
  end;
end;

function TServiceDashboard.GetRecordCountProducts: Int64;
var
  LService: TServiceProduct;
begin
  LService := TServiceProduct.Create;
  try
    Result := LService.GetRecordCount;
  finally
    LService.Free;
  end;
end;

end.
