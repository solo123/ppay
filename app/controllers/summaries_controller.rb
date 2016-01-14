class SummariesController < ApplicationController
  def home_sum
    d = Date.current.all_month
    @month_total_amount = ClientDayTradetotal.where("trade_date"=> d).sum("total_amount")
    @month_total_count = ClientDayTradetotal.where("trade_date"=> d).sum("total_count")

    @month_wechart_amount = ClientDayTradetotal.where("trade_date"=> d).sum("wechat_amount")
    @month_wechart_count = ClientDayTradetotal.where("trade_date"=> d).sum("wechat_count")
    @month_wechart_count10 = Trade.where("trade_date"=>d).where("trade_amount > ?", 10.0).count

    @month_t0_amount = ClientDayTradetotal.where("trade_date"=> d).sum("t0_amount")
    @month_t0_count = ClientDayTradetotal.where("trade_date"=> d).sum("t0_count")

    @month_clients_count = Client.where("join_date"=> d).count
    @total_clients_count = Client.count
  end
end
