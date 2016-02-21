class Client < ActiveRecord::Base
  belongs_to :salesman
  has_and_belongs_to_many :contacts
  has_many :pos_machines
  belongs_to :category, class_name: 'CodeTable'
  belongs_to :address
  has_many :client_notes
  has_many :trades
  scope :show_order, -> {order('join_date desc')}

  # tag
  acts_as_taggable
  acts_as_taggable_on :skills, :interests
end
