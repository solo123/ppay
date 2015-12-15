class ImpQfTradesController < ResourceController
  def initialize
    super
    @table_head = '交易数据'
    @table_fields = [ '商户id', '子帐号', '交易日期', '交易类型', '交易结果', '交易额', '终端串码', '状态'  ]
  end
end
