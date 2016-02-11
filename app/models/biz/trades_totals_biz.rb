module Biz
  class TradesTotalsBiz < AdminBiz
    def main_job
      return if $redis.get(@@flag_name) == 'running'
      $redis.set(@@flag_name, 'running')
      total_clients_and_salesmen
      $redis.set(@@flag_name, '')
    end

    def total_clients_and_salesmen
      success_trade_code = CodeTable.find_code('trade_result', '交易成功').id
      Trade.where(status: 0).each do |t|
        if t.trade_result_id == success_trade_code
          c = ClientDayTradetotal.find_or_create_by(client_id: t.client_id, trade_date: t.trade_date.to_date )
          c.total_amount += t.trade_amount
          c.total_count += 1
          type_code = trade_type(t)
          c["#{type_code}_amount"] += t.trade_amount
          c["#{type_code}_count"] += 1
          c.save

          s = SalesmanDayTradetotal.find_or_create_by(salesman_id: t.client.salesman_id, trade_date: t.trade_date.to_date )
          s.total_amount += t.trade_amount
          s.total_count += 1
          s["#{type_code}_amount"] += t.trade_amount
          s["#{type_code}_count"] += 1
          s.save
        end
        t.status = 1
        t.save
      end
    end

    def clear_totals
      ClientDayTradetotal.delete_all
      SalesmanDayTradetotal.delete_all
      Trade.update_all(status: 0)
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
