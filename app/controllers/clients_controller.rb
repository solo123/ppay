class ClientsController < ResourcesController

  def load_collection
    @q = Client
      .select("*, clients.id as client_id, code_tables.name as category_name, contacts.name as contact_name, addresses.street as street, salesmen.name as salesman_name, provinces_addresses.name as province_name, cities_addresses.name as city_name")
      .show_order
      .joins(:category, :salesman, :main_contact, address: [:province, :city])
    if params[:s]
      @q = @q.where("shid like :s or shop_name like :s or shop_tel like :s or contacts.name like :s or code_tables.name like :s", {s: "%#{params[:s]}%"})
    end
    pages = $redis.get(:list_per_page) || 100
		@all_data = @q
		@collection = @all_data.page(params[:page]).per(pages)
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
