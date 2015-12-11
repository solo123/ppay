json.array!(@imp_ops) do |imp_op|
  json.extract! imp_op, :id
  json.url imp_op_url(imp_op, format: :json)
end
