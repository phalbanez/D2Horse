unit Controllers.Auth;

interface

procedure Register;

implementation

uses
  System.JSON, Horse, Services.Users;

procedure Login(Req: THorseRequest; Res: THorseResponse);
var
  LEmail, LPassword: string;
  LService: TServiceUser;
  LToken: TJSONObject;
begin
  if (not Req.Body<TJSONObject>.TryGetValue<string>('email', LEmail)) or
     (not Req.Body<TJSONObject>.TryGetValue<string>('password', LPassword)) then
    raise EHorseException.New.Status(THTTPStatus.BadRequest).Error('Informe usuário e senha');

  LService := TServiceUser.Create;
  try
    if (not LService.IsValidUser(LEmail, LPassword)) then
      raise EHorseException.New.Status(THTTPStatus.Unauthorized).Error('Usuário ou senha inválido');

      LToken := TJSONObject.Create;
      try
        LToken.AddPair('accessToken', LService.GetAccessToken);
        LToken.AddPair('refreshToken', LService.GetRefreshToken);
      except
        LToken.Free;
        raise;
      end;

      Res.Send<TJSONObject>(LToken);

  finally
    LService.Free;
  end;
end;


procedure Register;
begin
  THorse.Post('/login', Login)
end;

end.
