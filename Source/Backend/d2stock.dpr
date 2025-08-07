program d2stock;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.JSON,
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  Horse.JWT,
  Providers.Connection in 'src\providers\Providers.Connection.pas' {ProviderConnection: TDataModule},
  Controllers.Ping in 'src\controllers\Controllers.Ping.pas',
  Providers.CRUD in 'src\providers\Providers.CRUD.pas' {ProviderCrud: TDataModule},
  Services.Business in 'src\services\Services.Business.pas' {ServiceBusiness: TDataModule},
  Controllers.Business in 'src\controllers\Controllers.Business.pas',
  Services.Users in 'src\services\Services.Users.pas' {ServiceUser: TDataModule},
  Controllers.Users in 'src\controllers\Controllers.Users.pas',
  Services.Categories in 'src\services\Services.Categories.pas' {ServiceCategory: TDataModule},
  Controllers.Categories in 'src\controllers\Controllers.Categories.pas',
  Services.Products in 'src\services\Services.Products.pas' {ServiceProduct: TDataModule},
  Controllers.Products in 'src\controllers\Controllers.Products.pas',
  Services.Stock in 'src\services\Services.Stock.pas' {ServiceStock: TDataModule},
  Controllers.Stock in 'src\controllers\Controllers.Stock.pas',
  Services.Dashboard in 'src\services\Services.Dashboard.pas' {ServiceDashboard: TDataModule},
  Controllers.Dashboard in 'src\controllers\Controllers.Dashboard.pas',
  Controllers.Auth in 'src\controllers\Controllers.Auth.pas',
  Providers.Consts in 'src\providers\Providers.Consts.pas';

begin
  THorse.Use(Jhonson('UTF-8'));
  THorse.Use(HandleException);
  THorse.Use(HorseJWT(SECRET_KEY_JWT, THorseJWTConfig.New.SkipRoutes(['/ping', '/login'])));

  Controllers.Ping.Registry;
  Controllers.Business.Registry;
  Controllers.Users.Registry;
  Controllers.Categories.Registry;
  Controllers.Products.Registry;
  Controllers.Stock.Registry;
  Controllers.Dashboard.Register;
  Controllers.Auth.Register;

  THorse.Listen(9000,
    procedure
    begin
      Writeln('Server is running on port ' + THorse.Port.ToString);
    end);

end.
