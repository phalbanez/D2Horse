unit Controllers.Business;

interface

procedure Registry;

implementation

uses
  System.SysUtils, System.JSON, Data.DB, Horse, Services.Business, DataSet.Serialize;

procedure ListAll(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceBusiness;
  LData: TJSONObject;
begin
  LService := TServiceBusiness.Create();
  try
    LData := TJSONObject.Create;
    LData.AddPair('data', LService.ListAll(Req.Query.Dictionary).ToJSONArray());
    LData.AddPair('records', LService.GetRecordCount);

    Res.Send<TJSONObject>(LData);
  finally
    LService.Free;
  end;
end;

procedure GetById(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceBusiness;
begin
  LService := TServiceBusiness.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Business not found!');

    Res.Send<TJSONObject>(LService.qryCadastro.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure Append(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceBusiness;
begin
  LService := TServiceBusiness.Create();
  try
    if LService.Append(Req.Body<TJSONObject>) then
      Res.Status(THTTPStatus.Created).Send<TJSONObject>(LService.qryCadastro.ToJSONObject())
  finally
    LService.Free;
  end;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceBusiness;
begin
  LService := TServiceBusiness.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Business not found!');

    if LService.Update(Req.Body<TJSONObject>) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceBusiness;
begin
  LService := TServiceBusiness.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Business not found!');

    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/business', ListAll);
  THorse.Get('/business/:id', GetById);
  THorse.Post('/business', Append);
  THorse.Put('/business/:id', Update);
  THorse.Delete('/business/:id', Delete);
end;

end.
