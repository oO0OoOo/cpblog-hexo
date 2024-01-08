cd /www/cypunberk_blog
##如果连续执行两次hexo s, 会提示4000端口已经被占用，所以无论如何先停掉4000端口的进程，才能保证hexo s成功##
/www/cypunberk_blog/shell/admin-kill.sh
hexo s