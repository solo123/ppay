class HomeController < ApplicationController
  def index

    d = Date.current.all_month

    @total_amount = ClientDayTradetotal.where("trade_date"=> d).sum("total_amount")
    @total_count = ClientDayTradetotal.where("trade_date"=> d).sum("total_count")

    @new_clienter_count = Client.where("join_date"=> d).count
    @clienter_count = Client.count
    @wechat_than_ten_count = Trade.where("trade_date"=>d).where("trade_amount > ?", 10.0).count

    @t0_amount = ClientDayTradetotal.where("trade_date"=> d).sum("t0_amount")
    @t0_count = ClientDayTradetotal.where("trade_date"=> d).sum("t0_count")

    @wechat_amount = ClientDayTradetotal.where("trade_date"=> d).sum("wechat_amount")
    @wechat_count = ClientDayTradetotal.where("trade_date"=> d).sum("wechat_count")

  end

  def profile

  end
end
