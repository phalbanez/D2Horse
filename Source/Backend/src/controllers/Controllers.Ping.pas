unit Controllers.Ping;

interface

procedure Registry;

implementation

uses Horse;

procedure Ping(Req: THorseRequest; Res: THorseResponse);
begin
  Res.Send('pong');
end;

procedure Registry;
begin
  THorse.Get('/ping', Ping);
end;

end.
