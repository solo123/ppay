class ContactsController < NestedResourcesController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '联系人资料'
    @field_titles = ['姓名', '电话', 'QQ', '微信号', '身份证号', '身份证校验日期', '角色']
  end

  def index
    s = params[:s]
    @q = Contact.ransack({'name_cont': s,'tel_cont': s,'qq_cont': s,'roles_cont': s,'name_cont': s, 'm': 'or'})
    @collection = @q.result.page( params[:page]).per(100)
  end

end
