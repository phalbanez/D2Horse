inherited ServiceProduct: TServiceProduct
  inherited Connection: TFDConnection
    Connected = True
  end
  inherited qryPesquisa: TFDQuery
    SQL.Strings = (
      'select id, category_id, name, barcode, active, price '
      'from product')
    object qryPesquisaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaCATEGORY_ID: TIntegerField
      FieldName = 'CATEGORY_ID'
      Origin = 'CATEGORY_ID'
      Required = True
    end
    object qryPesquisaNAME: TWideStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 150
    end
    object qryPesquisaBARCODE: TWideStringField
      FieldName = 'BARCODE'
      Origin = 'BARCODE'
    end
    object qryPesquisaACTIVE: TBooleanField
      FieldName = 'ACTIVE'
      Origin = '"ACTIVE"'
    end
    object qryPesquisaPRICE: TSingleField
      FieldName = 'PRICE'
      Origin = 'PRICE'
    end
  end
  inherited qryCadastro: TFDQuery
    SQL.Strings = (
      'select id, category_id, name, barcode, active, description,'
      '  price '
      'from product')
    object qryCadastroID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCadastroCATEGORY_ID: TIntegerField
      FieldName = 'CATEGORY_ID'
      Origin = 'CATEGORY_ID'
      Required = True
    end
    object qryCadastroNAME: TWideStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 150
    end
    object qryCadastroBARCODE: TWideStringField
      FieldName = 'BARCODE'
      Origin = 'BARCODE'
    end
    object qryCadastroACTIVE: TBooleanField
      FieldName = 'ACTIVE'
      Origin = '"ACTIVE"'
    end
    object qryCadastroDESCRIPTION: TWideStringField
      FieldName = 'DESCRIPTION'
      Origin = 'DESCRIPTION'
      Size = 500
    end
    object qryCadastroPRICE: TSingleField
      FieldName = 'PRICE'
      Origin = 'PRICE'
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(*) from product')
  end
end
