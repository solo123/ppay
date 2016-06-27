class TradesController < ResourcesController
  def load_collection
		params[:q] ||= {}
    @q = Trade.show_order.ransack(params[:q])
		pages = $redis.get(:list_per_page) || 100
		@all_data = @q.result
		@collection = @q.result
      .page(params[:page])
      .per(pages)
      .includes(:client)
	end

  def client_trades
    suc_code = CodeTable.find_by(name: 'trade_result').childs.where('name like ?', '交易成功').last
    @collection = Trade.where(client_id: params[:client_id], :trade_result=> suc_code).limit(100)
  end
end
