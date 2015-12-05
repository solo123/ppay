json.title '清算数据'

json.data @imp_qf_clearings do |data|
  json.yhid data.yhid
  json.qsrq data.qsrq
  json.jybs data.jybs
  json.jybj data.jybj
  json.sxf data.sxf
  json.jsje data.jsje
  json.sjqsje data.sjqsje
  json.qszt data.qszt
  json.zt data.zt

end
