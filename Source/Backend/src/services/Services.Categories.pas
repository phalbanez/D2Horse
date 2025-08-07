unit Services.Categories;

interface

uses
  System.SysUtils, System.Classes, Providers.CRUD, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, System.Generics.Collections;

type
  TServiceCategory = class(TProviderCrud)
    qryPesquisaID: TIntegerField;
    qryPesquisaNAME: TWideStringField;
    qryPesquisaACTIVE: TBooleanField;
    qryCadastroID: TIntegerField;
    qryCadastroNAME: TWideStringField;
    qryCadastroACTIVE: TBooleanField;
  private
  public
    function ListAll(const AQueryParams: TDictionary<string, string>): TDataSet; override;
  end;

implementation

{$R *.dfm}

function TServiceCategory.ListAll(const AQueryParams: TDictionary<string, string>): TDataSet;
begin
  for var LQuery in GetQuerysFilters do begin
    if AQueryParams.ContainsKey('id') then
    begin
      LQuery.SQL.Add(' and id = :id');
      LQuery.ParamByName('id').AsInteger := AQueryParams.Items['id'].ToInteger;
    end;

    if AQueryParams.ContainsKey('active') then
    begin
      LQuery.SQL.Add(' and active = :active');
      LQuery.ParamByName('active').AsBoolean := AQueryParams.Items['active'].ToBoolean;
    end;

    if AQueryParams.ContainsKey('name') then
    begin
      LQuery.SQL.Add(' and name containing(:name)');
      LQuery.ParamByName('name').AsString := AQueryParams.Items['name'];
    end;
  end;

  Result := inherited ListAll(AQueryParams);
end;

end.
