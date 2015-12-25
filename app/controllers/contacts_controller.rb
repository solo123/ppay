class ContactsController < ResourceController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '联系人资料'
    @field_titles = [ '姓名', '电话' ]
  end

end
