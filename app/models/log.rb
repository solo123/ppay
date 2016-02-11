class Log < ActiveRecord::Base
  belongs_to :user
  belongs_to :ref_data, :polymorphic => true
  belongs_to :parent, class_name: 'Log'
  scope :show_order, -> {order('id desc')}

  def self.last_operations(user)
    self.where(user_id: user.id).order('created_at desc').limit(5)
  end
end
