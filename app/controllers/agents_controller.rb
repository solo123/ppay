class AgentsController < ResourcesController
  def create_login
    # 创建代理商登录帐号
    c = Contact.find(params[:contact_id].to_i)

    u = User.find_or_create_by("mobile"=>c.tel, "name"=>c.name)
    if u
      u.password = c.tel
      u.save
    end
  end
  def del_salesman
    load_object
    s = Salesman.find(params[:salesman_id])
    s.agent = nil
    s.save
  end
  def add_salesman
    load_object
    s = Salesman.find(params[:salesman_id])
    @object.salesmen << s
    s.save
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    # def agent_params
    #   params.require(:agent).permit(
    #     :id,
    #     :cooperation_date, :cooperation_type_id,
    #     :t0_enabled, :bank_biz_types,
    #     :cooperation_location, :deposit,
    #     :amounts_payable,
    #     company_attributes: [:name, :short_name],
    #   )
    # end



end
