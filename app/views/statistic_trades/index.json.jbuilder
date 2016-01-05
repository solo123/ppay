json.array!(@statistic_trades) do |statistic_trade|
  json.extract! statistic_trade, :id
  json.url statistic_trade_url(statistic_trade, format: :json)
end
