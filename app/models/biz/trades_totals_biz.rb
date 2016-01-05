module Biz
  class TradesTotalsBiz

    def statistics_all
      Trade.all.each do |t|

        total = TradesTotal.find_or_create_by(client_id: t.client_id, trade_date: t.trade_date.to_date )
        #
        total.total_amount += t.trade_amount
        total.total_count += 1
        #
        type_code = trade_type(t)
        total["#{type_code}_amount"] += t.trade_amount
        total["#{type_code}_count"] += 1
        #save
        t.status = 1
        t.save
        total.save
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


  end
end
