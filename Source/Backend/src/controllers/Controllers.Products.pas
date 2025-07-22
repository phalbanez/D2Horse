unit Controllers.Products;

interface

procedure Registry;

implementation

uses
  System.SysUtils, System.JSON, Data.DB, Horse, Services.Products, DataSet.Serialize;

procedure ListAll(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceProduct;
begin
  LService := TServiceProduct.Create();
  try
    var
    LData := TJSONObject.Create.AddPair('data', LService.ListAll(Req.Query.Dictionary).ToJSONArray()
      ).AddPair('records', LService.GetRecordCount);

    Res.Send<TJSONObject>(LData);
  finally
    LService.Free;
  end;
end;

procedure GetById(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceProduct;
begin
  LService := TServiceProduct.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Product not found!');

    Res.Send<TJSONObject>(LService.qryCadastro.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure Append(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceProduct;
begin
  LService := TServiceProduct.Create();
  try
    if LService.Append(Req.Body<TJSONObject>) then
      Res.Status(THTTPStatus.Created).Send<TJSONObject>(LService.qryCadastro.ToJSONObject())
  finally
    LService.Free;
  end;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceProduct;
begin
  LService := TServiceProduct.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Product not found!');

    if LService.Update(Req.Body<TJSONObject>) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceProduct;
begin
  LService := TServiceProduct.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Product not found!');

    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/products', ListAll);
  THorse.Get('/products/:id', GetById);
  THorse.Post('/products', Append);
  THorse.Put('/products/:id', Update);
  THorse.Delete('/products/:id', Delete);
end;

end.

