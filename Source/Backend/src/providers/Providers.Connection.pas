unit Providers.Connection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait;

type
  TProviderConnection = class(TDataModule)
    Connection: TFDConnection;
  private
    { Private declarations }
  public
    constructor Create; reintroduce;
  end;

implementation

{$R *.dfm}

{ TProviderConnection }

constructor TProviderConnection.Create;
begin
  inherited Create(nil);
end;

end.
