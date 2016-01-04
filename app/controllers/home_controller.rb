class HomeController < ApplicationController
  def index
    @trade_sum = Biz::AdminTotal.trade_sum
    @client_sum = Biz::AdminTotal.client_sum
    @trade_detail_sum = Biz::AdminTotal.trade_detail_sum
    @new_clients = Biz::AdminTotal.new_clients
    @active_clients = Biz::AdminTotal.active_clients
    @active_agents = []

    # 交易汇总
    @all_trade_sum = Biz::TradeSum.sum_by(2015, 11)


  end
  def profile

  end
end
