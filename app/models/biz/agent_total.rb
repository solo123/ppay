module Biz
  # 计算代理商的一些统计信息
  class AgentTotal
    def self.client_sum
      sids = @agent.salesman_ids # 获取所有的业务员
      c_objs = Client.where('salesman_id': sids).order('join_date ASC') # 业务员下的所有商户
      trade_objs = Trade.where('client_id': c_objs.ids) #商户的所有交易记录

      Client.count
    end

    def self.trade_sum
      Trade.sum("trade_amount").to_s
    end

    def self.trade_detail_sum
      # 微信 刷卡 信用卡 trade_result trade_type
      trade_type_id = CodeTable.where('name'=> "trade_type").last.id.to_i
      trade_result_id = CodeTable.where('name'=> "trade_result").last.id.to_i

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

    def self.active_clients
      # 规则: 最近两个月，交易数量>交易额 依次排序
      last_info = Trade.where("trade_date>2015-12-16").group("client_id").take(10)

      clients = []
      last_info.each do |last|
        clients << last.client
      end
      clients
    end

  end
end
