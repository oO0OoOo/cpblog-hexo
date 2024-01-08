cd /www/cypunberk_blog
hexo clean
hexo g
hexo d
echo 删除/www/wwwroot/cypunberk.cn目录下所有内容
rm -rf /www/wwwroot/cypunberk.cn/*
echo 拷贝最新发布内容到/www/wwwroot/cypunberk.cn目录下
mv /www/cypunberk_blog/public/* /www/wwwroot/cypunberk.cn