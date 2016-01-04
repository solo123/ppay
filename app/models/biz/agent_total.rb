# agent额外辅助信息计算
class Agent
  def clients
    @clients = Client.where('salesman_id': self.salesman_ids).order('join_date ASC')
    @clients
  end
  def trades
    #商户的所有交易记录
    @trades = Trade.where('client_id': self.clients.ids)
    @trades
  end

  def new_clients
    self.clients.take(10)
  end

  def trade_groupby_client
    tmp = []
    alltrades = self.trades
    self.clients.all.each do |c|
      sum = alltrades.where('client_id'=>c.id).sum('trade_amount').to_f
      tmp << {"client"=> c, "sum"=> sum}
    end
    tmp
  end

  def active_clients
    # 规则: 最近两个月，交易数量>交易额 依次排序
    cur = Date.today
    last_info = self.trades.where("trade_date > #{Date.new(cur.year, cur.month-2, cur.day)}").group("client_id").take(10)
    clients = []
    last_info.each do |last|
      clients << last.client
    end
    clients
  end

end
