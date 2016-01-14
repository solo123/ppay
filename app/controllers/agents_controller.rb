class AgentsController < ResourcesController
  def create_login
    load_object
    contact = Contact.find(params[:contact_id].to_i)
    if contact
      user = User.find_or_create_by(mobile: contact.tel)
      user.agent = @object
      user.name = contact.name
      #user.email = contact.email
      if user.new_record?
        user.password = user.mobile
      end
      user.save!
    end
  end

  def del_login
    load_object
    contact = Contact.find(params[:contact_id].to_i)
    if contact
      user = User.find_by(mobile: contact.tel)
      if user
        user.agent = nil
        user.save!
      end
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

  def show
    # 交易汇总
    # @cur_trade_total = {}
    # tmp = AgentDayTradetotal.where("trade_date"=>Date.new(2015,12,1).all_month, "agent_id"=> params[:id] )
    #
    # ["total_amount", "total_count", "wechat_amount", "wechat_count", "t0_amount", "t0_count"].each do |key|
    #   @cur_trade_total[key] = tmp.sum(key)
    # end
    # super

    load_object
    if @object.company==nil
      c = Company.create
      @object.company = c
      @object.save
    end

    # 交易汇总
    @cur_trade_total = AgentDayTradetotal
            .select("sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count")
            .where("trade_date"=>Date.new(2015,12,1).all_month, "agent_id"=> params[:id] )
            .group("id")
            .last
    #
    # 后调用super 暂时不知道原因
    super
  end

  private

end
