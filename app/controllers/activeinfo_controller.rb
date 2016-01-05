class ActiveinfoController < ApplicationController
  layout false

  def client
    sum_field = ['total_amount', 'total_count',
                'weichat_amount', 'weichat_count', 'alipay_amount', 'alipay_count',
                't0_amount', 't0_count', 't1_amount', 't1_count']
    #
    d = Date.new(params[:year].to_i || 2015, params[:month].to_i || 12)
    # 当月交易数据
    all_trades = TradesTotal.where("trade_date > #{d.all_month.first}" ).group("client_id")

    sql = "SELECT client_id"
    sum_field.each do |f|
      sql << ", SUM(#{f}) as #{f} "
    end
    sql <<  "   FROM trades_totals
		        WHERE (trade_date > #{d.all_month.first})
		        GROUP BY  client_id
		        ORDER BY #{"weichat_amount"} DESC"

    #
    all_clients = []
    TradesTotal.find_by_sql(sql).each do |h|
      # @active_clients << Array.new(Client.find(c[1])) + c[2..-1]
      client  = Client.find(h["client_id"])
      all_clients << {"client"=> client, "salesman"=>client.salesman, "total_info"=> h}
    end

    @active_clients = all_clients.take(1)


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
