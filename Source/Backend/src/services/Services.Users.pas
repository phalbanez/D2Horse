unit Services.Users;

interface

uses
  System.SysUtils, System.Classes, Providers.CRUD, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, System.JSON;

type
  TServiceUser = class(TProviderCrud)
    qryPesquisaID: TIntegerField;
    qryPesquisaNAME: TWideStringField;
    qryPesquisaEMAIL: TWideStringField;
    qryPesquisaACTIVE: TBooleanField;
    qryPesquisaADMINISTRATOR: TBooleanField;
    qryCadastroID: TIntegerField;
    qryCadastroNAME: TWideStringField;
    qryCadastroEMAIL: TWideStringField;
    qryCadastroPASSWORD: TWideStringField;
    qryCadastroACTIVE: TBooleanField;
    qryCadastroBUSINESS_ID: TIntegerField;
    qryCadastroIMAGE_PATH: TWideStringField;
    qryCadastroADMINISTRATOR: TBooleanField;
  private
    { Private declarations }
  public
    { Public declarations }
    function Append(const AValue: TJSONObject): Boolean; override;
    function Update(const AValue: TJSONObject): Boolean; override;
    function GetById(const AId: Integer): TDataSet; override;
  end;

implementation

{$R *.dfm}

{ TServiceUser }

function TServiceUser.Append(const AValue: TJSONObject): Boolean;
begin
  qryCadastroPASSWORD.Visible := True;
  Result := inherited Append(AValue);
  qryCadastroPASSWORD.Visible := False;
end;

function TServiceUser.GetById(const AId: Integer): TDataSet;
begin
  qryCadastroPASSWORD.Visible := False;
  Result := inherited GetById(AId);
end;

function TServiceUser.Update(const AValue: TJSONObject): Boolean;
begin
  qryCadastroPASSWORD.Visible := True;
  Result := inherited Update(AValue);
  qryCadastroPASSWORD.Visible := False;
end;

end.
