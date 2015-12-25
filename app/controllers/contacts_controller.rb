class ContactsController < ResourceController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '导入数据结果'
    @field_titles = ['姓名', '电话', 'QQ', '微信号', '身份证号', '身份证校验日期', '角色']
  end

end
