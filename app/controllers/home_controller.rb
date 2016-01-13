class HomeController < ApplicationController
  def index

    d = Date.current.all_month
    #
    @new_clienter_count = Client.where("join_date"=> d).count
    @clienter_count = Client.count
    @wechat_than_ten_count = Trade.where("trade_date"=>d).where("trade_amount > ?", 10.0).count

    # @t0_amount = ClientDayTradetotal.where("trade_date"=> d).sum("t0_amount")
    # @t0_count = ClientDayTradetotal.where("trade_date"=> d).sum("t0_count")
    #
    # @wechat_amount = ClientDayTradetotal.where("trade_date"=> d).sum("wechat_amount")
    # @wechat_count = ClientDayTradetotal.where("trade_date"=> d).sum("wechat_count")

    @cur_month_total = ClientDayTradetotal.select("trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count").where("trade_date"=>d).last

  end

  def profile

  end
end
