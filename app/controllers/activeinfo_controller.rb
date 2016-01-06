class ActiveinfoController < ApplicationController
  layout false

  @@sum_field = ['total_amount', 'total_count',
              'weichat_amount', 'weichat_count', 'alipay_amount', 'alipay_count',
              't0_amount', 't0_count', 't1_amount', 't1_count']
  #
  def client
    d = Date.new(params[:year].to_i, params[:month].to_i)
    #
    info = TradesTotalMon
                .where("trade_date_year=#{d.year} and trade_date_month=#{d.month}" )
                .order("#{params[:order] || "total_amount"} " + " DESC")
    #
    @active_clients = info.take(10)
    logger.info '排序类型参数错误 需要传入参数 order。默认为: total_amount.'

  end
  def agent
    d = Date.new(params[:year].to_i, params[:month].to_i)
    @active_agents = AgentMonthTradetotal.where("year=#{d.year} and month=#{d.month} and agent_id>0").order("#{params[:order] || "total_amount" }" + " DESC")
  end

  def month_sum
    d = Date.new(params[:year].to_i, params[:month].to_i)
    @month_sum = []
    d.all_month.each do |t|
      @month_sum << PlatformDayTradetotal.where("trade_date": t).last || PlatformDayTradetotal.new
    end
  end

  def new_client
    @new_clients = Biz::AdminTotal.new_clients
  end

end
