class Salesman < ActiveRecord::Base
  has_many :clients
  belongs_to :salesman
end
