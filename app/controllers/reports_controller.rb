class ReportsController < ApplicationController

  def home_summary
    d = Date.current.all_month
    @month_total_amount = ClientDayTradetotal.where(trade_date: d).sum("total_amount")
    @month_total_count = ClientDayTradetotal.where(trade_date: d).sum("total_count")

    @month_wechart_amount = ClientDayTradetotal.where("trade_date"=> d).sum("wechat_amount")
    @month_wechart_count = ClientDayTradetotal.where("trade_date"=> d).sum("wechat_count")
    @month_wechart_count10 = Trade.where("trade_date"=>d).where("trade_amount > ?", 10.0).count

    @month_t0_amount = ClientDayTradetotal.where("trade_date"=> d).sum("t0_amount")
    @month_t0_count = ClientDayTradetotal.where("trade_date"=> d).sum("t0_count")

    @month_clients_count = Client.where("join_date"=> d).count
    @total_clients_count = Client.count
  end

  def clients_days
    year = params[:q][0..3].to_i
    month = params[:q][5..7].to_i
    dt = Date.new(year, month, 1)
    @prev_month = dt - 1.month
    @next_month = dt + 1.month
    @collection = ClientDayTradetotal.select(%Q(
    trade_date,
    sum(total_amount) as total_amount,
    sum(total_count) as total_count,
    sum(wechat_amount) as wechat_amount,
    sum(wechat_count) as wechat_count,
    sum(alipay_amount) as alipay_amount,
    sum(alipay_count) as alipay_count,
    sum(t0_amount) as t0_amount,
    sum(t0_count) as t0_count,
    sum(t1_amount) as t1_amount,
    sum(t1_count) as t1_count
    )).where(trade_date: dt.all_month).group(:trade_date)

  end

  def new_clients
    @collection = Client.order("join_date DESC").take(10)
  end

  def active_clients
    year = params[:q][0..3].to_i
    month = params[:q][5..7].to_i
    dt = Date.new(year, month, 1)
    order = params[:order] || "wechat_count"
    day_trade_total = ClientDayTradetotal.select(%Q(
      client_id, trade_date,
      sum(total_amount) as total_amount,
      sum(total_count) as total_count,
      sum(wechat_amount) as wechat_amount,
      sum(wechat_count) as wechat_count,
      sum(alipay_amount) as alipay_amount,
      sum(alipay_count) as alipay_count,
      sum(t0_amount) as t0_amount,
      sum(t0_count) as t0_count))
      .where(trade_date: (dt..dt.end_of_month))
      .group(:trade_date).order("#{order} DESC")
    #
    @collection = []
    idx = 0
    day_trade_total.take(10).each do |t|
      idx += 1
      c = Client.find(t.client_id)

      if c.contacts.count==0
        c.contacts << Contact.new
        c.save
      end
      h = {}
      h["idx"] = idx
      h['shop_name'] = c.shop_name
      h["contact_name"] = c.contacts.last.name
      h["contact_tel"] = c.contacts.last.tel
      h["location"] = ''
      h['salesman.name'] = c.salesman.name
      h['salesman.url'] = salesman_path(c.salesman)
      h["qudao"] = ''
      h['join_date'] = c.join_date
      h["rate"] = c.rate
      h["total_amount"] = t.total_amount
      h["wechat_amount"] = t.wechat_amount
      h["wechat_count"] = t.wechat_count
      h["alipay_amount"] = t.alipay_amount
      h["alipay_count"] = t.alipay_count
      h["t0_amount"] = t.alipay_count
      h["t0_count"] = t.t0_count

      @collection << h
    end

  end
  def active_agents

        year = params[:q][0..3].to_i
        month = params[:q][5..7].to_i
        dt = Date.new(year, month, 1)

        order = params[:order] || "wechat_count"
        day_trade_total = AgentDayTradetotal.select(%Q(
          agent_id, trade_date,
          sum(total_amount) as total_amount,
          sum(total_count) as total_count,
          sum(wechat_amount) as wechat_amount,
          sum(wechat_count) as wechat_count,
          sum(alipay_amount) as alipay_amount,
          sum(alipay_count) as alipay_count,
          sum(t0_amount) as t0_amount,
          sum(t0_count) as t0_count))
          .where(trade_date: (Date.current.all_month))
          .group(:agent_id).order("#{order} DESC")
        #
        @collection = []
        idx = 0
        day_trade_total.each do |t|
          next if t.agent_id==nil || t.agent_id==0
          idx += 1
          agent = Agent.find(t.agent_id)
          user = agent.user || User.new
          h = {}
          h["idx"] = idx
          # h['shop_name'] = c.shop_name
          h["contact_name"] = user.name
          h["contact_tel"] = user.mobile
          h['cooperation_type'] = agent.cooperation_type_id
          h['cooperation_date'] = agent.cooperation_date
          h["salesman_count"] = agent.salesman_all.count
          h["client_count"] = agent.clients_all.count
          h["client_new_count"] = agent.new_clients.count

          # h["location"] = ''
          # h['salesman.name'] = c.salesman.name
          # h['salesman.url'] = salesman_path(c.salesman)
          h['trade_date'] = t.trade_date
          # 渠道名称	联系人	手机	合作时间	业务数	累计户	当月户

          h["total_amount"] = t.total_amount
          h["wechat_amount"] = t.wechat_amount
          h["wechat_count"] = t.wechat_count
          h["alipay_amount"] = t.alipay_amount
          h["alipay_count"] = t.alipay_count
          h["t0_amount"] = t.alipay_count
          h["t0_count"] = t.t0_count

          @collection << h
        end

  end
end
