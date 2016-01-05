json.array!(@statistic_agents) do |statistic_agent|
  json.extract! statistic_agent, :id
  json.url statistic_agent_url(statistic_agent, format: :json)
end
