class Salesman < ActiveRecord::Base
  has_many :clients
  has_many :contacts
end
