module Biz
  class TradesTotalBiz

    @@sum_field = ['total_amount', 'total_count',
                'weichat_amount', 'weichat_count', 'alipay_amount', 'alipay_count',
                't0_amount', 't0_count', 't1_amount', 't1_count']
    #

    def total_all
      total_clients
      total_salesmen
      total_agents
    end

    def total_clients
      Trade.all.each do |t|

        c_total = ClientDayTradetotal.find_or_create_by(client_id: t.client_id, trade_date: t.trade_date.to_date )
        c_total.total_amount += t.trade_amount
        c_total.total_count += 1
        type_code = trade_type(t)
        c_total["#{type_code}_amount"] += t.trade_amount
        c_total["#{type_code}_count"] += 1

        # TradesTotalMon 改为 ClientMonthTradetotal 
        cm = ClientMonthTradetotal.find_or_create_by(client: t.client, year: t.trade_date.year, month: t.trade_date.month)
        cm.total_amount += t.trade_amount
        cm.total_count += 1
        type_code = trade_type(t)
        cm["#{type_code}_amount"] += t.trade_amount
        cm["#{type_code}_count"] += 1

        #
        tm = TradesTotalMon.find_or_create_by(client: t.client, trade_date_year: t.trade_date.year, trade_date_month: t.trade_date.month)
        tm.total_amount += t.trade_amount
        tm.total_count += 1
        type_code = trade_type(t)
        tm["#{type_code}_amount"] += t.trade_amount
        tm["#{type_code}_count"] += 1
        tm.save

        p_total = PlatformDayTradetotal.find_or_create_by(trade_date: t.trade_date)
        @@sum_field.each do |field|
          p_total[field] += tm[field]
        end

        tm.save
        cm.save
        p_total.save
        t.status = 1
        t.save
        c_total.save

      end
    end


    def platom_total
      ClientDayTradetotal.all.each do |c_t|
        p_total = PlatformDayTradetotal.find_or_create_by(trade_date: c_t.trade_date)
        @@sum_field.each do |field|
          p_total[field] += c_t[field]
        end
        p_total.save
      end

    end

    def trade_type(trade)
      re_type_code = nil
      if trade.trade_type.name.include?('微信')
        re_type_code = 'weichat'
      elsif trade.trade_type.name.include?("支")
         re_type_code = 'alipay'
      else
        # 根据client确定t0/t1
        re_type_code =  trade.client.rate == 0.007 ? 't0' : 't1'

      end
      return re_type_code

    end

    def total_salesmen
      ClientDayTradetotal.all.each do |t|
        s_day = SalesmanDayTradetotal.find_or_create_by(salesman_id: t.client.salesman_id, trade_date: t.trade_date )
        s_month = SalesmanMonthTradetotal.find_or_create_by(salesman_id: t.client.salesman_id, year: t.trade_date.year, month: t.trade_date.month)

        @@sum_field.each do |field|
          s_day[field] += t[field]
          s_month[field] += t[field]
        end
        s_day.save
        s_month.save
      end
    end


    def total_agents
      SalesmanDayTradetotal.all.each do |t|
        a_day = AgentDayTradetotal.find_or_create_by(agent_id: t.salesman.agent_id, trade_date: t.trade_date )
        a_month = AgentMonthTradetotal.find_or_create_by(agent_id: t.salesman.agent_id, year: t.trade_date.year, month: t.trade_date.month)

        @@sum_field.each do |field|
          a_day[field] += t[field]
          a_month[field] += t[field]
        end
        a_day.save
        a_month.save
      end
    end

  end
end
