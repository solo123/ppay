module Biz
  # 计算代理商的一些统计信息
  class AdminTotal
    def self.client_sum
      Client.count
    end

    def self.trade_sum
      Trade.sum("trade_amount").to_s
    end

    def self.trade_detail_sum
      # 微信 刷卡 信用卡 trade_result trade_type
      trade_type_id = 0 #CodeTable.where('name'=> "trade_type").last.id.to_i
      trade_result_id = 0 #CodeTable.where('name'=> "trade_result").last.id.to_i

      # 交易类型 交易结果
      trade_types = CodeTable.where("parent_id=#{trade_type_id}")
      trade_results = CodeTable.where("parent_id=#{trade_result_id}")

      trade_detail = []
      trade_types.each do |tt|
        sum = Trade.where("trade_type_id=#{tt.id}").sum("trade_amount")
        tt.name
        trade_detail << {'type'=>tt.name, 'sum'=>sum}
      end
      trade_detail

    end

    def self.new_clients
      Client.order('join_date'=>'desc').take(10)
    end

    def self.clients_trade
      tmp = []
      Client.all.each do |c|
        sum = Trade.where('client_id'=>c.id).sum('trade_amount').to_f
        tmp << {"client"=> c, "sum"=> sum}
      end
      tmp
    end

    def self.active_clients(y, m, field)
      # 总金额、总笔数、微金额、微笔数、支金额、支笔数、T0金额、T0笔数
      cur = Date.today
      last_info = Trade.where("trade_date > #{Date.new(cur.year, cur.month-2, cur.day)}").group("client_id").take(10)
      clients = []
      last_info.each do |last|
        clients << last.client
      end
      clients
    end

    def self.active_agents(y, m, field, sort_factor)
      # 总金额、总笔数、微金额、微笔数、支金额、支笔数、T0金额、T0笔数
      # 活跃代理商
      cur = Date.today
      field = 'count'
      sort_by( sort_factor || [0, 0, 0])

      Agent.all.each do |a|
        all_trades = a.trades.where("trade_date > #{Date.new(cur.year, cur.month-2, cur.day)}")
        # all_trades.where("trade_type_id"=>75).sum("trade_amount").count
      end

      Agent.order("sort DESC").take(10)

    end

    def sort_by(sort_factor)
      [""]
    end

  end

end
