#本地进行hexo发布 -> 上传至git -> 远端服务器拉新
echo "开始了"
cd /www/wwwroot/cpblog-hexo
git reset --hard
git pull
