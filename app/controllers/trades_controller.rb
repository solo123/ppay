class TradesController < ResourcesController
  def load_collection
    params[:s] ||= {}
    @q = Trade
      .show_order
      .joins(:client, :trade_type, :trade_result)
    if params[:s]
      if params[:s][:s]
        @q = @q.where("clients.shid like :s or clients.shop_name like :s or code_tables.name like :s or trade_results_trades.name like :s", {s: "%#{params[:s][:s]}%"})
      end
      if params[:s][:d]
				dy = Time.zone.parse(params[:s][:d])
			@q = @q.where(trade_date: [dy.beginning_of_day..dy.end_of_day])
  		end
    end
    pages = $redis.get(:list_per_page) || 100
		@all_data = @q
		@collection = @q
      .select("*, clients.shid as shid, clients.shop_name as shop_name, code_tables.name as trade_type_name, trade_results_trades.name as trade_result_name")
      .page(params[:page]).per(pages)
  end

  def client_trades
    @collection = Trade.where(client_id: params[:client_id]).limit(10)
  end
end
