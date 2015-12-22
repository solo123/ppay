class Client < ActiveRecord::Base
  belongs_to :salesmen
  has_many :contacts
  has_many :pos_machines
  has_one :addresses
end
