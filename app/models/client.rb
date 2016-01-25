class Client < ActiveRecord::Base
  belongs_to :salesman
  has_and_belongs_to_many :contacts
  has_many :pos_machines
  belongs_to :category, class_name: 'CodeTable'
  belongs_to :address
  has_many :client_notes
  has_many :client_day_tradetotals

  # tag
  acts_as_taggable
  acts_as_taggable_on :skills, :interests

  default_scope {order('join_date desc')}

  def contact_info
    if self.contacts.count > 0
      c = self.contacts.first
      "#{c.name}"
    else
      ''
    end
  end
  def addr_info
    if self.address
      "#{self.address.province.name} #{self.address.city.name} #{self.address.street}"
    else
      ''
    end
  end
  def area_info
    if self.address
      "#{self.address.province.name} #{self.address.city.name}"
    else
      ''
    end
  end

  def note_info
    # 获取所有的备注
    {'type'=>'info', 'msg'=>'提醒info'}
  end

  def join_days
    (DateTime.current - self.join_date.to_datetime).to_i.to_s + '天'
  end

  def salesman_info
    Salesman.find(self.salesman_id.to_i)

  end
  def shop_category
    CodeTable.find(self.category_id)
  end

end
