class ReportsController < ApplicationController
  def clients_days
    year = params[:q][0..3].to_i
    month = params[:q][4..6].to_i
    dt = Date.new(year, month, 1)
    @collection = ClientDayTradetotal.select(%Q(
    trade_date,
    sum(total_amount) as total_amount,
    sum(total_count) as total_count,
    sum(wechat_amount) as wechat_amount,
    sum(wechat_count) as wechat_count,
    sum(alipay_amount) as alipay_amount,
    sum(alipay_count) as alipay_count,
    sum(t0_amount) as t0_amount,
    sum(t0_count) as t0_count,
    sum(t1_amount) as t1_amount,
    sum(t1_count) as t1_count
    )).where(trade_date: (dt..dt.end_of_month)).group(:trade_date)
    
  end
end
