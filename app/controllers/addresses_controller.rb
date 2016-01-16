class AddressesController < ResourceController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '地址列表'
    @field_titles = ['省', '市', '地址', '邮编', '状态']
  end

  def update
    load_object
    params.permit!
    @object.attributes = params[:address]
    @object.province = CodeTable.find_prov(params[:txt_data][:province]) unless @object.province && @object.province.name == params[:txt_data][:province]
    @object.city = CodeTable.find_city(@object.province_id, params[:txt_data][:city]) unless @object.city && @object.city.name == params[:txt_data][:city]
    @object.save
    respond_to do |format|
      format.html { redirect_to :action => :show }
      format.json { respond_with_bip(@object) }
      format.js
    end
  end


end
