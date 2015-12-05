json.title '商户数据'

json.data @imp_qf_customers do |c|
  json.ssid c.ssid
  json.hylx c.hylx
  json.dm c.dm
  json.lxr c.lxr
  json.sj c.sj
  json.rwsj c.rwsj
  json.sf c.sf
  json.cs c.cs
  json.dz c.dz
  json.ywy c.ywy
  json.fl c.fl
  json.zdcm c.zdcm
  json.jjkdbxe c.jjkdbxe
  json.jjkdyxe c.jjkdyxe
  json.xykdbxe c.xykdbxe
  json.xykdyxe c.xykdyxe
  json.zt c.zt
end
