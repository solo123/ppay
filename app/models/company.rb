class Company < ActiveRecord::Base
  has_one :address, as: :addr_obj
  belongs_to :company_obj, polymorphic: true

end
