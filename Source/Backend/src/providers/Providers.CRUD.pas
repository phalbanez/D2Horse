unit Providers.CRUD;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.JSON,
  Providers.Connection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.VCLUI.Wait;

type
  TProviderCrud = class(TProviderConnection)
    qryPesquisa: TFDQuery;
    qryCadastro: TFDQuery;
    qryRecordCount: TFDQuery;
    qryRecordCountCOUNT: TLargeintField;
  private
    { Private declarations }
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
  qryPesquisa.Open();
  Result := qryPesquisa;
end;

function TProviderCrud.Update(const AValue: TJSONObject): Boolean;
begin
  qryCadastro.MergeFromJSONObject(AValue, False);
  Result := True;
end;

end.
