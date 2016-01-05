class ActiveinfoController < ApplicationController
  layout false

  def client
    d = Date.new(params[:year].to_i || 2015, params[:month].to_i || 12)
    # 当月交易数据
    all_trades = TradesTotal.where("trade_date > #{d.all_month.first}" ).group("client_id")



    @active_clients = Biz::AdminTotal.active_clients(params[:year].to_i || 2016, params[:month].to_i || 1, params[:field])

  end
  def agent
    @active_agents = Biz::AdminTotal.active_agents(params[:year].to_i || 2016, params[:month].to_i || 1, params[:field])
  end


  def month_sum
    @month_sum = []
    TradesTotalMon.where(trade_date_year: params[:year], trade_date_month: params[:month]).each do |t|
      @month_sum << t
    end
  end

  def new_client
    @new_clients = Biz::AdminTotal.new_clients
  end

end
