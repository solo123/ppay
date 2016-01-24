class SalesmenController < ResourceController
  def set_client
    load_object
    @object.client_id = params[:client]
    @object.save
  end

end
