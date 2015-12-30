class Client < ActiveRecord::Base
  belongs_to :salesman
  has_and_belongs_to_many :contacts
  has_many :pos_machines
  has_many :addrs, as: :addr_obj
  belongs_to :category, class_name: 'CodeTable'
  has_many :addresses, as: :addr_obj
  has_many :client_notes

  # tag
  acts_as_taggable
  acts_as_taggable_on :skills, :interests

  def contact_info
    if self.contacts.count > 0
      c = self.contacts.first
      "#{c.name}"
    else
      ''
    end
  end
  def addr_info
    if self.addresses.count > 0
      addr = self.addresses.first
      CodeTable.find(addr.province_id).name.to_s + ' ' + CodeTable.find(addr.city_id).name.to_s
    else
      ''
    end
  end

  def note
    # 获取所有的备注
    {'type'=>'info', 'msg'=>'提醒info'}
  end
end
