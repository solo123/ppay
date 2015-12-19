# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# 新建默认用户
puts "创建默认用户"
User.create!(name: 'ivy', mobile:'13826554535', email:'ivy@pooul.cn', password: 'ivy@pooul.cn')
User.create!(name: 'jimmy', mobile:'18682320151', email:'jimmy@pooul.cn', password: 'jimmy@pooul.cn')
User.create!(name: 'alei', mobile:'15817329272', email:'alei@pooul.cn', password: 'alei@pooul.cn')
User.create!(name: 'zk', mobile:'18665319889', email:'zk@pooul.cn', password: 'zk@pooul.cn')
User.create!(name: 'angel', mobile:'18670358555', email:'angel@pooul.cn', password: 'angel@pooul.cn')
User.create!(name: 'qpos', mobile:'18699992568', email:'qpos@pooul.cn', password: 'qpos@pooul.cn')
User.create!(name: 'helapu', mobile:'18684048270', email:'helapu@pooul.cn', password: 'helapu@pooul.cn')
User.create!(name: 'wxl', mobile:'18346827602', email:'wxl@pooul.cn', password: 'wxl@pooul.cn')
User.create!(name: 'ljn', mobile:'15914039837', email:'ljn@pooul.cn', password: 'ljn@pooul.cn')
puts "已创建公司员工默认用户。"
