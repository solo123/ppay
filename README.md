# 最近更新
* 2016-03-16
  - 修改导入数据后未设置implog的状态导致会重复导入；
  - 增加临时工具Biz::DataClearBiz
    -<code>
  biz.clear_data_after('2016-02-23')
  biz.clear_import_after(101)
  </code>
    -
* 2016-03-15
  - color_admin加入assets目录(alei)
  - 修改读取email识别附件是xls还是xlsx，增加simple_xlsx_reader读取扩展
  - 日志列表正确显示两种格式文件并提供下载
  -  增加xlsx的数据导入功能(roo,dullard,rubyxl等并不能正确解析钱方xlsx文件，里面有特殊符号，sisimple_xlsx_reader能够直接读取xlsx中的数据不去尝试解析，能够获取到字符串类型的数据)
  - 修改assets里面遗漏login需要的背景图片，目前color_admin的assets并不正确
  - 读取email时默认读取第一个附件，修改为读取第一个excel附件，仍不能处理同一邮件中附带多个excel附件的情况
  - 处理文件扩展名中带空格和\u0000的特殊情况
  - 商户创建时关联业务员，之后不再更新业务员
* 2016-02-28
  - 修改页面中统计数据
  - 增加分润计算公式
  - 新增阶梯分润显示和录入
  - 重新设计交易统计，重算日汇总和月汇总
  - 增加修改商户业务员和重算当前对账月份数据功能
* 2016-01-25
  - 修改数据导入bug
  - 启用action mailer来支持发送邮件（暂时没用）
  - 修改首页交易汇总显示格式
* 2016-01-22
  - 商户列表增加入网时间
  - 商户列表入网时间倒序
