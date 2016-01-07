class BankCard < ActiveRecord::Base
  belongs_to :bank_card_obj, polymorphic: true
  # accepts_nested_attributes_for :agent # 编辑关联对象

end
