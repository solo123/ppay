json.array!(@trades_totals) do |total|
  json.extract! total, :id
end
