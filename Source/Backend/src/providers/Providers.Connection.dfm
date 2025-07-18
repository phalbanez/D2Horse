object ProviderConnection: TProviderConnection
  Height = 480
  Width = 640
  object Connection: TFDConnection
    Params.Strings = (
      'ConnectionDef=D2Stock')
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 55
    Top = 29
  end
end
