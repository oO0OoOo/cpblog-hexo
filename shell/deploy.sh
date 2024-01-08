#本地进行hexo发布 -> 上传至git -> 远端服务器拉新

echo "===================  Step1  < hexo generate >  ==================="
cd D:\cpblog-hexo
hexo clean
hexo g

echo "===================  Step2  < local git push >  ==================="
git pull
git add -A
git commit -m "conventional update by deploy.sh"
git push

echo "===================  Step3  < server git pull >  ==================="
ssh root@45.207.39.244 bash /www/wwwroot/cpblog-hexo/shell/deploy-server.sh

echo "===================           Finished           ==================="