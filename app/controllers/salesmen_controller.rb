class SalesmenController < ResourceController
  def set_client
    load_object
    @object.client_id = params[:client]
    @object.save
  end

  def index
    @q = Salesman.ransack( {
              'name_cont'=> params[:search_t],
              'clients_shop_tel_cont'=> params[:search_t],
              'clients_shop_name_cont'=> params[:search_t],
              'm'=> 'or'} )
    pages = $redis.get(:list_per_page) || 100
    @collection = @q.result(distinct: true).includes(:clients).page(params[:page]).per( pages )

  end

end
