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
    # 交易汇总
    @month_sum = []
    sum_field = ['total_amount', 'total_count',
                'weichat_amount', 'weichat_count', 'alipay_amount', 'alipay_count',
                't0_amount', 't0_count', 't1_amount', 't1_count']
    #
    d = Date.new(params[:year].to_i || 2015, params[:month].to_i || 12)
    d.all_month.each do |day|
      all_trades = TradesTotal.where("trade_date"=>day)
      h = {}
      sum_field.each do |f|
        h[f] = all_trades.sum(f)
      end
      @month_sum << h
    end

  end

  def new_client
    @new_clients = Biz::AdminTotal.new_clients
  end

end
