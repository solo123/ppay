class Company < ActiveRecord::Base
  has_one :address, as: :addr_obj
end
