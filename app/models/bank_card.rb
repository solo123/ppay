class BankCard < ActiveRecord::Base
  belongs_to :bank_card_obj, polymorphic: true

end
