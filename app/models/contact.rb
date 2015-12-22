class Contact < ActiveRecord::Base
  has_many :addresses
  belongs_to :client
  belongs_to :salesman

end
