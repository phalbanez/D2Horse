inherited ServiceStock: TServiceStock
  inherited Connection: TFDConnection
    Connected = True
  end
  inherited qryPesquisa: TFDQuery
    SQL.Strings = (
      'select id, product_id, business_id, user_id, operation_date,'
      '  quantity, operation  '
      'from stock'
      'where id > 0')
    object qryPesquisaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaPRODUCT_ID: TIntegerField
      FieldName = 'PRODUCT_ID'
      Origin = 'PRODUCT_ID'
      Required = True
    end
    object qryPesquisaBUSINESS_ID: TIntegerField
      FieldName = 'BUSINESS_ID'
      Origin = 'BUSINESS_ID'
      Required = True
    end
    object qryPesquisaUSER_ID: TIntegerField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      Required = True
    end
    object qryPesquisaOPERATION_DATE: TSQLTimeStampField
      FieldName = 'OPERATION_DATE'
      Origin = 'OPERATION_DATE'
    end
    object qryPesquisaQUANTITY: TSingleField
      FieldName = 'QUANTITY'
      Origin = 'QUANTITY'
    end
    object qryPesquisaOPERATION: TWideStringField
      FieldName = 'OPERATION'
      Origin = 'OPERATION'
    end
  end
  inherited qryCadastro: TFDQuery
    BeforePost = qryCadastroBeforePost
    SQL.Strings = (
      'select id, product_id, business_id, user_id, operation_date,'
      '  quantity, operation  '
      'from stock')
    object qryCadastroID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCadastroPRODUCT_ID: TIntegerField
      FieldName = 'PRODUCT_ID'
      Origin = 'PRODUCT_ID'
      Required = True
    end
    object qryCadastroBUSINESS_ID: TIntegerField
      FieldName = 'BUSINESS_ID'
      Origin = 'BUSINESS_ID'
      Required = True
    end
    object qryCadastroUSER_ID: TIntegerField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      Required = True
    end
    object qryCadastroOPERATION_DATE: TSQLTimeStampField
      FieldName = 'OPERATION_DATE'
      Origin = 'OPERATION_DATE'
    end
    object qryCadastroQUANTITY: TSingleField
      FieldName = 'QUANTITY'
      Origin = 'QUANTITY'
    end
    object qryCadastroOPERATION: TWideStringField
      FieldName = 'OPERATION'
      Origin = 'OPERATION'
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(*) from stock'
      'where id > 0')
  end
end
