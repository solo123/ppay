# coding: utf-8
class AgentsController < ResourcesController
  def create_login
    load_object
    contact = Contact.find(params[:contact_id].to_i)
    if contact
      # 如果这个电话号码已经存在就不能再次绑定到新的代理商
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
    load_object
    agent_total_biz = Biz::AgentTotalBiz.new(@object.id)
    @month_total = ClientDayTradetotal.where(:client_id=> agent_total_biz.clients_all.ids,
          :trade_date=> DateTime.now.all_month)

    @all_total  = {:client_count=> agent_total_biz.clients_all.count,
      :new_client_count=> agent_total_biz.clients_all.where(:join_date=>  DateTime.now.all_month).count}
    @last_amount = ClientDayTradetotal.where(:client_id=> agent_total_biz.clients_all.ids,
          :trade_date=> DateTime.now.last_month.all_month).sum("total_amount")

  end

  def pri_salesmaninfo
    puts 'old'
  end

  def active_clients
    load_object
    total = Biz::AgentTotalBiz.new(@object.id)
    @collection_clients = total.active_clients
  end
  def active_salesmen
    load_object
    total = Biz::AgentTotalBiz.new(@object.id)
    @collection_salesmen = total.active_salesmen
  end


end
