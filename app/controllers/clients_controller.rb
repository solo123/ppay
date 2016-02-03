class ClientsController < ResourcesController

  def load_collection
    @q = Client
      .select("*, clients.id as client_id, code_tables.name as category_name, contacts.name as contact_name, addresses.street as street, salesmen.name as salesman_name, provinces_addresses.name as province_name, cities_addresses.name as city_name")
      .show_order
      .joins(:category, :salesman, :main_contact, address: [:province, :city])
    @q.take(1).each do |r|
      puts @q.values
    end
    if params[:search_t]
      @q = @q.where("salesman.name like :s or shid like :s or shop_name like :s or shop_tel like :s or contacts.name like :s or code_tables.name like :s", {s: "%#{params[:search_t]}%"})
    end

    pages = $redis.get(:list_per_page) || 100
		@all_data = @q
		@collection = @all_data.page(params[:page]).per(pages)
  end


  def filter_clients(clients)
    if params[:search_t]=='' || params[:search_t]==nil
      return clients
    end

    q_hash = {
      'shop_name_cont'=> params[:search_t],
      'shop_tel_cont'=> params[:search_t],
      'contacts_name_cont'=> params[:search_t],
      'contacts_tel_cont'=> params[:search_t],
      # 'address_city_cont'=> params[:search_t],
      'm'=>'or'
    }
    # 特殊处理查询rate和shid,放在一起查询做eq的时候会越界
    if params[:search_t].include?("0.00")
      q_hash = {'rate_eq'=> params[:search_t]}
    end

    q = clients.ransack(  q_hash )
    tmp = q.result(distinct: true).includes(:contacts)


    return tmp
  end


  # tag管理
  def tags
    load_object
    if request.get?
      @tags = @object.tag_list
    elsif request.post?
      params[:tags].each do |tag|
        @object.tag_list << tag
      end
      @object.save
      redirect_to @object
    else
    end
  end

  # 备注管理
  def note
    load_object
    if request.get?
      @notes = @object.client_notes.page( params[:note_page]).per(5)
    elsif request.post?
      @object.client_notes.create('note'=>params[:note], 'tip'=>params[:tip], 'user'=>current_user)
      redirect_to @object
    else
    end

  end

end
