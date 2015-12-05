json.array!(@imp_logs) do |imp_log|
  json.extract! imp_log, :id, :email_uid, :email_title, :created_at, :updated_at

  json.url imp_log_url(imp_log, format: :json)
end
