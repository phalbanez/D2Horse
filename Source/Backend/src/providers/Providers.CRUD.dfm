inherited ProviderCrud: TProviderCrud
  inherited Connection: TFDConnection
    Left = 56
    Top = 32
  end
  object qryPesquisa: TFDQuery
    ActiveStoredUsage = []
    Connection = Connection
    Left = 178
    Top = 32
  end
  object qryCadastro: TFDQuery
    ActiveStoredUsage = []
    Connection = Connection
    Left = 280
    Top = 32
  end
  object qryRecordCount: TFDQuery
    ActiveStoredUsage = []
    Connection = Connection
    Left = 178
    Top = 104
    object qryRecordCountCOUNT: TLargeintField
      FieldName = 'COUNT'
    end
  end
end
