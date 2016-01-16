# coding: utf-8
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

  def show123
    load_object

    # 交易汇总
    @cur_trade_total = AgentDayTradetotal
            .select("sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count")
            .where("trade_date"=>Date.current.all_month, "agent_id"=> params[:id] )
            .group("id")
            .last
  end

  private


  def pri_salesmaninfo
    puts 'old'
  end


end
