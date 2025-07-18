inherited ServiceUser: TServiceUser
  inherited Connection: TFDConnection
    Connected = True
  end
  inherited qryPesquisa: TFDQuery
    SQL.Strings = (
      'select id, name, email, active, administrator '
      'from users ')
    object qryPesquisaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaNAME: TWideStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 150
    end
    object qryPesquisaEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 200
    end
    object qryPesquisaACTIVE: TBooleanField
      FieldName = 'ACTIVE'
      Origin = '"ACTIVE"'
    end
    object qryPesquisaADMINISTRATOR: TBooleanField
      FieldName = 'ADMINISTRATOR'
      Origin = 'ADMINISTRATOR'
    end
  end
  inherited qryCadastro: TFDQuery
    SQL.Strings = (
      'select id, name, email, password, active, business_id, '
      '  image_path, administrator'
      'from users')
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
      Size = 150
    end
    object qryCadastroEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 200
    end
    object qryCadastroPASSWORD: TWideStringField
      FieldName = 'PASSWORD'
      Origin = '"PASSWORD"'
      Size = 128
    end
    object qryCadastroACTIVE: TBooleanField
      FieldName = 'ACTIVE'
      Origin = '"ACTIVE"'
    end
    object qryCadastroBUSINESS_ID: TIntegerField
      FieldName = 'BUSINESS_ID'
      Origin = 'BUSINESS_ID'
      Required = True
    end
    object qryCadastroIMAGE_PATH: TWideStringField
      FieldName = 'IMAGE_PATH'
      Origin = 'IMAGE_PATH'
      Size = 500
    end
    object qryCadastroADMINISTRATOR: TBooleanField
      FieldName = 'ADMINISTRATOR'
      Origin = 'ADMINISTRATOR'
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(*) from users ')
  end
end
