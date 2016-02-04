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

  def index

    @all_data = search_trade( search_keyword() )
    @collection = @all_data.page( params[:page]).per(100)
  end

  def search_keyword()
    if params[:search_t].nil? || params[:search_t].empty?
      return Trade.order("trade_date DESC")
    end

    h = {
      'client_shid_eq'=> params[:search_t].to_i,
      'sub_account_cont'=> params[:search_t],
      'client_name_cont'=> params[:search_t],
      'client_shop_name_cont'=> params[:search_t],
      'm'=> 'or'
    }
    Trade.ransack( h ).result.includes(:client).order("trade_date DESC")
  end


  def search_trade(trades)
    ret = trades

    # 过滤 交易类型
    if params[:trade_type]!='' && params[:trade_type]!=nil
      ids = []
      params[:trade_type].each do |r|
        ids << CodeTable.ransack({'name_cont'=>r}).result.ids
      end
      puts ids
      ret = ret.where("trade_type_id"=>ids)
    end

    # 浏览器上传日期 '12/28/2015' 但是ruby可以解析的字符串格式为 'day/month/year' 例如 '28/12/2015'

    # 日期下限
    if params[:date_gt]!='' && params[:date_gt]!=nil
      d_gt_a = params[:date_gt].split('/')
      puts d_gt_a
      d_gt = Date.new(d_gt_a[2].to_i, d_gt_a[0].to_i,d_gt_a[1].to_i)
      ret = ret.where("trade_date > ?", d_gt)
    end
    # 日期上限
    if params[:date_lt]!='' && params[:date_lt]!=nil
      d_lt_a = params[:date_lt].split('/')
      puts d_lt_a
      d_lt = Date.new(d_lt_a[2].to_i, d_lt_a[0].to_i,d_lt_a[1].to_i)
      ret = ret.where("trade_date < ?", d_lt)
    end

    return ret
  end


end
