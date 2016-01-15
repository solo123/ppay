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

  def show
    load_object
    agent_total = Biz::AgentTotalBiz.new params[:id]
    puts '-' * 42
    @cur_trade_total  = agent_total.trades_sum(Date.current)
    puts @cur_trade_total

    @cur_trade_total["clients_count"] = agent_total.clients_all.count
    @cur_trade_total["new_clients_count"] = agent_total.new_clients.count
    @cur_trade_total["company"] = Company.new
    puts '-' * 42
    puts @cur_trade_total
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
