class AgentsController < ResourceController

  def edit
    super
    check_empty
  end
  def new
    super
    check_empty
  end

  def check_empty
    @object.build_company unless @object.company
    @object.company.build_address unless @object.company.address

    if @object.bank_cards.count==0
      @object.bank_cards << BankCard.new
    end
    if @object.sales_commissions.count==0
      @object.sales_commissions << SalesCommission.new
    end
    if @object.contacts.count==0
      @object.contacts << Contact.new
    end

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
