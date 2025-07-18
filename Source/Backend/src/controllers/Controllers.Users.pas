unit Controllers.Users;

interface

procedure Registry;

implementation

uses
  System.SysUtils, System.JSON, Data.DB, Horse, Services.Users, DataSet.Serialize;

procedure ListAll(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceUser;
begin
  LService := TServiceUser.Create();
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
  LService: TServiceUser;
  LResult: TJSONObject;
begin
  LService := TServiceUser.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('User not found!');

    LResult := LService.qryCadastro.ToJSONObject();
    // LResult.RemovePair('password').Free;
    Res.Send<TJSONObject>(LResult);
  finally
    LService.Free;
  end;
end;

procedure Append(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceUser;
begin
  LService := TServiceUser.Create();
  try
    if LService.Append(Req.Body<TJSONObject>) then
      Res.Status(THTTPStatus.Created).Send<TJSONObject>(LService.qryCadastro.ToJSONObject())
  finally
    LService.Free;
  end;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceUser;
begin
  LService := TServiceUser.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('User not found!');

    if LService.Update(Req.Body<TJSONObject>) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceUser;
begin
  LService := TServiceUser.Create();
  try
    if LService.GetById(Req.Params['id'].ToInteger).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('User not found!');

    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/users', ListAll);
  THorse.Get('/users/:id', GetById);
  THorse.Post('/users', Append);
  THorse.Put('/users/:id', Update);
  THorse.Delete('/users/:id', Delete);
end;

end.
