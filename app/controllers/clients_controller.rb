class ClientsController < ResourceController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '商户资料'
    @field_titles = [ '商户ID', '店铺名称', '店铺联系电话', '行业分类', '业务员', '费率', '借记卡单笔限额', '借记卡单月限额', '信用卡单笔限额', '信用卡单月限额' ]
  end

  def load_collection
    params[:q] ||= {}
    @q = Client.ransack( params[:q] )
    pages = $redis.get(:list_per_page) || 100
    @collection = @q.result(distinct: true).includes(:contacts).page(params[:page]).per( pages )
  end

  def show
    super
    @trades = Trade.where("client_id": params[:id])
    @trades_for_pages = @trades.page( params[:page] ).per(20)
  end

  def tags
    c = Client.find(params[:id])
    c.tag_list = params[:tags]
    c.save
    redirect_to c
  end

end
