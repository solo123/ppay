class ImpQfClearingsController < ResourceController
  def initialize
    super
    @table_head = '清算数据'
    @table_fields = [ '商户id', '清算日期', '交易笔数', '交易本金', '手续费', '结算金额', '实际清算金额', '状态' ]
  end
end
