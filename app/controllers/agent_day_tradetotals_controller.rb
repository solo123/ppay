class AgentDayTradetotalsController < ApplicationController

  # 针对平台统计出的活跃代理商
  def index

  end

  # 代理下的活跃商户和业务员
  def active_clients
    agent = Agent.find(params[:agent_id] || 1)
    d = params[:date] || Date.current
    order = params[:order] || "total_amount"

    @collection = agent.active_clients(d: Date.current, order: 'total_amount')
  end

  def active_salesmen
    agent = Agent.find(params[:agent_id] || 1)
    d = params[:date] || Date.current
    order = params[:order] || "total_amount"
    @collection = agent.active_salesmen(d: Date.current, order: 'total_amount')
  end
end
