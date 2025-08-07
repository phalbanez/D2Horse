unit Controllers.Dashboard;

interface

procedure Register;

implementation

uses
  System.JSON, Horse, Services.Dashboard;

procedure Dashboard(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceDashboard;
begin
  LService := TServiceDashboard.Create(nil);
  try
    Res.Send<TJSONObject>(LService.GetDashbordData);
  finally
    LService.Free;
  end;
end;

procedure Register;
begin
  THorse.Get('/dashboard', Dashboard)
end;

end.
