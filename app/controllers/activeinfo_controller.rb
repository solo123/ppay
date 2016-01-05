class ActiveinfoController < ApplicationController
  layout false

  def client
    @active_clients = Biz::AdminTotal.active_clients(params[:year].to_i || 2016, params[:month].to_i || 1, params[:field])
  end
  def agent
    @active_agents = Biz::AdminTotal.active_agents(params[:year].to_i || 2016, params[:month].to_i || 1, params[:field])
  end
  def month_sum
    # 交易汇总
    @month_sum = Biz::TradeSum.month_sum_by(params[:year].to_i || 2016, params[:month].to_i || 1)

  end
  def new_client
    @new_clients = Biz::AdminTotal.new_clients
  end

end
