# 新建默认用户
if User.count < 3
  puts "开始创建默认用户..."
  User.create('name'=>'ivy', 'mobile'=>'13826554535', 'email'=>'ivy@pooul.cn', 'password'=>'ivy@pooul.cn')
  User.create('name'=>'jimmy', 'mobile'=>'18682320151', 'email'=>'jimmy@pooul.cn', 'password'=>'jimmy@pooul.cn')
  User.create('name'=>'alei', 'mobile'=>'15817329272', 'email'=>'alei@pooul.cn', 'password'=>'alei@pooul.cn')
  User.create('name'=>'zk', 'mobile'=>'18665319889', 'email'=>'zk@pooul.cn', 'password'=>'zk@pooul.cn')
  User.create('name'=>'angel', 'mobile'=>'18670358555', 'email'=>'angel@pooul.cn', 'password'=>'angel@pooul.cn')
  User.create('name'=>'qpos', 'mobile'=>'18699992568', 'email'=>'qpos@pooul.cn', 'password'=>'qpos@pooul.cn')
  User.create('name'=>'helapu', 'mobile'=>'18684048270', 'email'=>'helapu@pooul.cn', 'password'=>'helapu@pooul.cn')
  User.create('name'=>'wxl', 'mobile'=>'18346827602', 'email'=>'wxl@pooul.cn', 'password'=>'wxl@pooul.cn')
  User.create('name'=>'ljn', 'mobile'=>'15914039837', 'email'=>'ljn@pooul.cn', 'password'=>'ljn@pooul.cn')
  puts "已创建完毕公司员工默认用户."
else
  puts "用户User不为空，不再创建默认用户"
end

def add_menu(parent, name, dt1, dt2, status)
  CodeTable.create(name: name, val: dt1, tag: dt2, status: status, parent_id: parent).id
end

p = CodeTable.find_by(name: 'main_menu')
if p
  puts "菜单已创建，不再重复创建"
else
  puts '正在创建菜单'
  p = CodeTable.create(name: 'main_menu')
  add_menu(p, "首页", '', "fa-laptop", 10)
  pp = add_menu(p, "商户数据", '', "fa-credit-card", 10)
  add_menu(pp, "商户资料", "clients_path", '/clients', 11)
  add_menu(pp, "业务员", "salesmen_path", '/salesmen', 11)
  add_menu(pp, "联系人", "contacts_path", '/contacts', 11)

  pp = add_menu(p, "交易清算", '', 'fa-database', 10)
  add_menu(pp, "交易数据", 'trades_path', '/trades', 11)
  add_menu(pp, "清算数据", 'clearings_path', '/clearings', 11)

  pp = add_menu(p, "数据导入", '', "fa-area-chart", 10)
  add_menu(pp, "导入日志", "imp_logs_path", '/imp_logs', 11)
  add_menu(pp, "商户信息", "imp_qf_customers_path", '/imp_qf_customers', 11)
  add_menu(pp, "交易", "imp_qf_trades_path", '/imp_qf_trades', 11)
  add_menu(pp, '清算', "imp_qf_clearings_path", '/imp_qf_clearings', 11)

  pp = add_menu(p, "管理工具", '', 'fa-sitemap', 10)
  add_menu(pp, "用户管理", 'users_path', '/users', 11)
  add_menu(pp, "代码表管理", 'code_tables_path', '/code_tables', 11)
  add_menu(pp, "地址管理", 'addresses_path', '/addresses', 11)
  add_menu(pp, 'POS管理', 'pos_machines_path', '/pos_machines', 11)
  add_menu(pp, "BBS", 'notices_path', '/notices', 11)
  add_menu(pp, "Logs", 'logs_path', '/logs', 11)

  pp = add_menu(p, "代理商", '', 'fa-user', 10)
  add_menu(pp, "代理商管理", 'agents_path', '/agents', 11)

  pp = add_menu(p, "个人设置", '', 'fa-gear (alias)', 10)
  add_menu(pp, '资料', 'home_profile_path', '/profile' , 11)
end
