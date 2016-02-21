class ReportsController < ApplicationController

  def home_summary
    @trade_month = Date.current.to_s[0..6]

    tt = CodeTable.find_by(name: 'trade_type').id
    ts = CodeTable.where('name like ?', '%微信%').where(parent_id: tt)
    d = Date.current.all_month
    @month_wechart_count10 = Trade.where(trade_date: d, trade_type_id: ts.ids).where("trade_amount >= ?", 10.0).count
    @month_clients_count = Client.where(join_date: d).count
    @total_clients_count = Client.count
  end

  def clients_days
    year = params[:q][0..3].to_i
    month = params[:q][5..7].to_i
    dt = Date.new(year, month, 1)
    @prev_month = dt - 1.month
    @next_month = dt + 1.month
    ts = TradeSum.where(
      sum_obj_type: 'ALL',
      sum_type: :day,
      trade_date: dt.all_month)
      .order("trade_date ASC")
    @collection = ts.group_by{|t| t.trade_date}
  end

  def new_clients
    @collection = Client.order("join_date DESC").take(10)
  end

  def active_clients
    year = params[:q][0..3].to_i
    month = params[:q][5..7].to_i
    dt = Date.new(year, month, 1)
    @collection_clients = []
    idx = 0
    all = Biz::SysTotalBiz.active_clients(dt, 'total_amount')
    all.each do |t|
      idx += 1
      client = Client.find(t["client_id"])
      c = client.contacts.first
      # total = Biz::AgentTotalBiz.new(client.id)
      t["idx"] = idx
      if c
        t["contact_name"] = c.name || ''
        t["contact_tel"] = c.tel || ''
      end
      # # t['cooperation_type'] = agent.cooperation_type_id
      # t['cooperation_date'] = agent.cooperation_date
      # t["salesman_count"] = total.salesman_all.count
      # t["client_count"] = total.clients_all.count
      # t["client_new_count"] = total.new_clients.count

      t["location"] = ''
      @collection_clients << t
    end
  end

  def active_agents
    year = params[:q][0..3].to_i
    month = params[:q][5..7].to_i
    dt = Date.new(year, month, 1)
    @collection_agents = []
    idx = 0
    all = Biz::SysTotalBiz.active_agents(dt, 'total_amount')
    all.each do |t|
      idx += 1
      agent = Agent.find(t["agent_id"])
      c = agent.contacts.first
      total = Biz::AgentTotalBiz.new(agent.id)
      t["idx"] = idx
      if c
        t["contact_name"] = c.name || ''
        t["contact_tel"] = c.tel || ''
      end
      t['cooperation_type'] = agent.cooperation_type_id
      t['cooperation_date'] = agent.cooperation_date
      t["salesman_count"] = total.salesman_all.count
      t["client_count"] = total.clients_all.count
      t["client_new_count"] = total.new_clients.count

      t["location"] = ''
      @collection_agents << t
    end
  end
end
