unit Controllers.Categories;

interface

procedure Registry;

implementation

uses
  System.SysUtils, System.JSON, Data.DB, Horse, Services.Categories, DataSet.Serialize;

procedure ListAll(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceCategory;
begin
  LService := TServiceCategory.Create();
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
  LService: TServiceCategory;
begin
  LService := TServiceCategory.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Category not found!');

    Res.Send<TJSONObject>(LService.qryCadastro.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure Append(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceCategory;
begin
  LService := TServiceCategory.Create();
  try
    if LService.Append(Req.Body<TJSONObject>) then
      Res.Status(THTTPStatus.Created).Send<TJSONObject>(LService.qryCadastro.ToJSONObject())
  finally
    LService.Free;
  end;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceCategory;
begin
  LService := TServiceCategory.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Category not found!');

    if LService.Update(Req.Body<TJSONObject>) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceCategory;
begin
  LService := TServiceCategory.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Category not found!');

    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/categories', ListAll);
  THorse.Get('/categories/:id', GetById);
  THorse.Post('/categories', Append);
  THorse.Put('/categories/:id', Update);
  THorse.Delete('/categories/:id', Delete);
end;

end.
