json.title '交易数据'

json.data @imp_qf_trades do |data|
  json.ssid data.ssid
  json.zzh data.zzh
  json.jyrq data.jyrq
  json.jylx data.jylx
  json.jyjg data.jyjg
  json.jye data.jye
  json.zdcm data.zdcm
  json.zt data.zt
end
