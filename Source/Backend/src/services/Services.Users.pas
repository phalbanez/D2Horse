unit Services.Users;

interface

uses
  System.SysUtils, System.Classes, Providers.CRUD, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, System.JSON, System.Generics.Collections;

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
    function ListAll(const AQueryParams: TDictionary<string, string>): TDataSet; override;
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

function TServiceUser.ListAll(const AQueryParams: TDictionary<string, string>): TDataSet;
begin
  for var LQuery in GetQuerysFilters do
  begin
    if AQueryParams.ContainsKey('id') then
    begin
      LQuery.SQL.Add(' and id = :id');
      LQuery.ParamByName('id').AsInteger := AQueryParams.Items['id'].ToInteger;
    end;

    if AQueryParams.ContainsKey('name') then
    begin
      LQuery.SQL.Add(' and name containing(:name)');
      LQuery.ParamByName('name').AsString := AQueryParams.Items['name'];
    end;
  end;

  Result := inherited ListAll(AQueryParams);
end;

function TServiceUser.Update(const AValue: TJSONObject): Boolean;
begin
  qryCadastroPASSWORD.Visible := True;
  Result := inherited Update(AValue);
  qryCadastroPASSWORD.Visible := False;
end;

end.
