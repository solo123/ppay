module Biz
  class AgentTotal

    # 计算代理商的一些统计信息

    def self.client_sum
      # Client.all.each do |c|
      #   imp = ImpQfCustomer.where('shid'=>c.shid).last
      #   c.join_date = imp.rwsj
      #   c.save
      # end
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



    end



  end
end
