class Client < ActiveRecord::Base
  belongs_to :salesman
  has_and_belongs_to_many :contacts
  has_many :pos_machines
  has_many :addrs, as: :addr_obj
  belongs_to :category, class_name: 'CodeTable'
  has_many :addresses, as: :addr_obj
end
