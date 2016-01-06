class TradesTotalMonsController < ResourceController
  def show
    year = params[:id][0..3].to_i
    month = params[:id][4..6].to_i
    @collection = TradesTotalMon.where(trade_date_year: year, trade_date_month: month)
  end
end
