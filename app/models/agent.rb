class Agent < ActiveRecord::Base
  has_many :salesmen
  has_many :bank_cards, as: :bankcard_obj
  has_one :company, as: :company_obj
  has_many :agent_day_tradetotals

  accepts_nested_attributes_for :bank_cards # 编辑关联对象
  # accepts_nested_attributes_for :company # 公司机构

  after_initialize do |agent|

  end

  # agent额外辅助信息计算
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

  def current_month_clients
    self.clients.where("join_date": Date.current.all_month)
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
