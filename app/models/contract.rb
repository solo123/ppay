class Contract < ActiveRecord::Base
  has_and_belongs_to_many :agents
  has_and_belongs_to_many :salesmen
  has_many :profit_ladders

  def caculate_profit(amount, count = 0, caculate_date = Date.current)
    if self.profit_mode == 'ladder_amount'
      pl = self.profit_ladders.where('amount_start <= ?', amount).order('amount_start desc').first
      if pl
        pl.amount_percent * amount
      else
        0.0
      end
    elsif self.profit_mode == 'ladder_count'
      2.0
    else
      0.0
    end
  end
end
