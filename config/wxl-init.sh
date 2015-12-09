echo '切换分支'
git checkout dev

echo '初始化数据库'
rake db:migrate

echo '...ok'
