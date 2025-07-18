inherited ServiceBusiness: TServiceBusiness
  inherited Connection: TFDConnection
    Connected = True
  end
  inherited qryPesquisa: TFDQuery
    SQL.Strings = (
      'select id, name, active'
      'from business')
    object qryPesquisaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaNAME: TWideStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 100
    end
    object qryPesquisaACTIVE: TBooleanField
      FieldName = 'ACTIVE'
      Origin = '"ACTIVE"'
    end
  end
  inherited qryCadastro: TFDQuery
    SQL.Strings = (
      'select id, name, active'
      'from business')
    object qryCadastroID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCadastroNAME: TWideStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 100
    end
    object qryCadastroACTIVE: TBooleanField
      FieldName = 'ACTIVE'
      Origin = '"ACTIVE"'
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(*) from business ')
  end
end
