class TradesController < ResourcesController
  def client_trades
    @collection = Trade.where(client_id: params[:client_id]).limit(10)
  end
end
