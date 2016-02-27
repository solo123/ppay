module Biz
  class TradesTotalsBiz < AdminBiz
    def main_job
      operation_job('计算新增的日月汇总数据') do
        total_clients_salesmen_agents
      end
    end

    def total_clients_salesmen_agents
      success_trade_code = CodeTable.find_code('trade_result', '交易成功').id
      qry = Trade.where('status < 2 and trade_result_id = ?', success_trade_code)
      operation_each(qry) do |t|
        total_trade(t)
        t.status = 2
        t.save
      end
    end

    def add_sum(amount, sum_obj, trade_type, trade_date)
      trade_month = trade_date[0..6]
      add_sum1(amount, sum_obj, trade_type, trade_date, 'day')
      add_sum1(amount, sum_obj, 'all', trade_date, 'day')
      add_sum1(amount, sum_obj, trade_type, trade_month, 'month')
      add_sum1(amount, sum_obj, 'all', trade_month, 'month')
    end
    def add_sum1(amount, sum_obj, trade_type, trade_date, sum_type)
      s = nil
      if sum_obj
        s = TradeSum.find_or_create_by(sum_obj: sum_obj, trade_type: trade_type, sum_type: sum_type, trade_date: trade_date)
      else
        s = TradeSum.find_or_create_by(sum_obj_type: 'ALL', trade_type: trade_type, sum_type: sum_type, trade_date: trade_date)
      end
      s.amount += amount
      s.count += 1
      s.save
    end
    def clear_totals
      TradeSum.delete_all
      Trade.update_all(status: 0)
    end

    def re_total_job
      operation_job('重算当月汇总') do
        server_log('清除当月业务员和代理商汇总数据')
        ct = CodeTable.find_code('config', '当前对账月份')
        unless ct.val
          ct.val = Date.current.beginning_of_month.to_s[0..6]
          ct.save
        end
        TradeSum
          .where('trade_date>=?', ct.val)
          .where(sum_obj_type: ['Salesman', 'Agent'])
          .update_all(amount: 0, count: 0)

        server_log('正在汇总当月数据...')
        dt = Time.zone.parse(ct.val + '-01').to_datetime
        success_trade_code = CodeTable.find_code('trade_result', '交易成功').id
        qry = Trade.where('trade_date>=?', dt)
                .where(status: 2)
                .where(trade_result_id: success_trade_code)
        operation_each(qry) do |t|
          td = t.trade_date.to_date.to_s
          tt = trade_type(t)
          am = t.trade_amount
          total_trade_sm(t.client.salesman, td, tt, am) if t.client.salesman
        end
        ct.status = 0
        ct.save
      end
    end

    def total_trade(trade)
      td = trade.trade_date.to_date.to_s
      tt = trade_type(trade)
      am = trade.trade_amount
      add_sum(am, nil, tt, td)
      add_sum(am, trade.client, tt, td)
      total_trade_sm(trade.client.salesman, td, tt, am) if trade.client.salesman
    end
    def total_trade_sm(sm, td, tt, am)
      if sm
        add_sum(am, sm, tt, td)
        if sm.agent
          ag = sm.agent
          add_sum(am, ag, tt, td)
        end
      end
    end

    def trade_type(trade)
      re_type_code = nil
      if trade.trade_type.name.include?('微信')
        re_type_code = 'wechat'
      elsif trade.trade_type.name.include?("支")
         re_type_code = 'alipay'
      else
        # 根据client确定t0/t1
        re_type_code =  trade.client.rate == 0.007 ? 't0' : 't1'
      end
      return re_type_code
    end
  end
end
