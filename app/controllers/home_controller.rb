class HomeController < ApplicationController
  def index
    @trade_sum = Biz::AdminTotal.trade_sum
    @client_sum = Biz::AdminTotal.client_sum
    @trade_detail_sum = Biz::AdminTotal.trade_detail_sum
  end
  
  def profile

  end
end
