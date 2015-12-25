class ClientsController < ResourceController
  def initialize
    super
    @table_head = '商户资料'
  end

  def load_collection
    params[:q] ||= {}
    @q = Client.ransack( params[:q] )
    pages = $redis.get(:list_per_page) || 100
    @collection = @q.result(distinct: true).includes(:contacts).page(params[:page]).per( pages )
  end


end
