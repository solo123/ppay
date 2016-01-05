json.array!(@statistic_clients) do |statistic_client|
  json.extract! statistic_client, :id
  json.url statistic_client_url(statistic_client, format: :json)
end
