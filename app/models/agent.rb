class Agent < ActiveRecord::Base
  has_many :salesmen
  has_many :bank_cards, as: :bankcard_obj
  has_one :company, as: :company_obj

  after_initialize do |agent|
    @salesmen_obj = self.salesmen # 获取所有的业务员
    @clients_obj = Client.where('salesman_id': @salesmen_obj.ids).order('join_date ASC') # 业务员下的所有商户
    @trades_obj = Trade.where('client_id': @clients_obj.ids) #商户的所有交易记录
  end

end
