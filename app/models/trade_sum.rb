class TradeSum < ActiveRecord::Base
  belongs_to :sum_obj, polymorphic: true
end
