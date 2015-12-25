class ClientsController < ResourceController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '商户信息'
    @field_titles = [ '商户ID', '店铺名称', '店铺联系电话', '行业分类', '业务员', '费率', '借记卡单笔限额', '借记卡单月限额', '信用卡单笔限额', '信用卡单月限额' ]
  end

end
