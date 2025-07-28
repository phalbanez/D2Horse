unit Providers.CRUD;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.JSON, Providers.Connection,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.VCLUI.Wait;

type
  TProviderCrud = class(TProviderConnection)
    qryPesquisa: TFDQuery;
    qryCadastro: TFDQuery;
    qryRecordCount: TFDQuery;
    qryRecordCountCOUNT: TLargeintField;
  private
    procedure SetOrdenation(const AQuery: TFDQuery; const AQueryParam: TDictionary<string, string>);
    procedure SetPagination(const AQuery: TFDQuery; const AQueryParam: TDictionary<string, string>);
  public
    function Append(const AValue: TJSONObject): Boolean; virtual;
    function Update(const AValue: TJSONObject): Boolean; virtual;
    function GetById(const AId: Integer): TDataSet; virtual;
    function ListAll(const AQueryParams: TDictionary<string, string>): TDataSet; virtual;
    function Delete: Boolean; virtual;
    function GetRecordCount: Int64; virtual;
  end;

implementation

{$R *.dfm}

uses
  DataSet.Serialize;

function TProviderCrud.Append(const AValue: TJSONObject): Boolean;
begin
  qryCadastro.SQL.Add(' where id is null');
  qryCadastro.Open();
  qryCadastro.LoadFromJSON(AValue, False);
  Result := True;
end;

function TProviderCrud.Delete: Boolean;
begin
  qryCadastro.Delete;
  Result := True;
end;

function TProviderCrud.GetById(const AId: Integer): TDataSet;
begin
  qryCadastro.SQL.Add(' where id = :id');
  qryCadastro.ParamByName('id').AsInteger := AId;
  qryCadastro.Open();
  Result := qryCadastro;
end;

function TProviderCrud.GetRecordCount: Int64;
begin
  qryRecordCount.Open();
  Result := qryRecordCountCOUNT.AsLargeInt;
end;

function TProviderCrud.ListAll(const AQueryParams: TDictionary<string, string>): TDataSet;
begin
  SetPagination(qryPesquisa, AQueryParams);
  SetOrdenation(qryPesquisa, AQueryParams);
  qryPesquisa.Open();
  Result := qryPesquisa;
end;

procedure TProviderCrud.SetOrdenation(const AQuery: TFDQuery;
  const AQueryParam: TDictionary<string, string>);
var
  LSort: TArray<string>;
  LValues: TArray<string>;
  LOrdenation: string;
  LFieldName: string;
  LOrderAscDesc: string;
begin
  if (not AQueryParam.ContainsKey('sort')) then
    Exit;

  LSort := AQueryParam.Items['sort'].Split([';']);

  LOrdenation := EmptyStr;
  for var LSortItem in LSort do
  begin
    LValues := LSortItem.Split([',']);
    if Length(LValues) = 0 then
      Continue;

    LFieldName := LValues[0].Trim;
    if AQuery.Fields.FindField(LFieldName) = nil then
      Continue;

    if not LOrdenation.IsEmpty then
      LOrdenation := LOrdenation + ', ';

    LOrdenation := LOrdenation + LFieldName;

    if Length(LValues) >= 2 then
    begin
      LOrderAscDesc := LValues[1].ToLower;
      if LOrderAscDesc.Equals('asc') or LOrderAscDesc.Equals('desc') then
        LOrdenation := LOrdenation + ' ' + LOrderAscDesc;
    end;
  end;

  if not LOrdenation.Trim.IsEmpty then
    AQuery.SQL.Add('order by ' + LOrdenation);
end;

procedure TProviderCrud.SetPagination(const AQuery: TFDQuery;
  const AQueryParam: TDictionary<string, string>);
begin
  if AQueryParam.ContainsKey('limit') then
  begin
    AQuery.FetchOptions.RecsMax := StrToIntDef(AQueryParam.Items['limit'], 50);
    AQuery.FetchOptions.RowsetSize := AQuery.FetchOptions.RecsMax;
  end;

  if AQueryParam.ContainsKey('offset') then
  begin
    AQuery.FetchOptions.RecsSkip := StrToIntDef(AQueryParam.Items['offset'], 0);
  end;
end;

function TProviderCrud.Update(const AValue: TJSONObject): Boolean;
begin
  qryCadastro.MergeFromJSONObject(AValue, False);
  Result := True;
end;

end.
