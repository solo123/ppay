class Salesman < ActiveRecord::Base
  has_many :clients
  belongs_to :agent
  belongs_to :client
  has_and_belongs_to_many :contracts

  scope :free_salesmen, -> { where(agent_id: nil) }
	scope :free_client_salesmen, -> { where(client_id: nil) }

  def new_clients
    self.clients_all.where(join_date: Date.current.all_month)
  end
end
