title: 博客搭建教程10 - 将托管在Github的Hexo博客迁移到个人云服务器
author: epya15
tags:
  - 博客
categories:
  - 博客搭建
date: 2023-01-09 10:00:00
img: https://www.easeus.com.cn/attachment/chuanshu/qinayi-15.png
excerpt: '防止Github有朝一日不再提供免费服务或彻底被墙'
---
Q：我觉得目前将网站托管到github上已经很好了，迁移至私服有足够的必要性吗？
A：迁移至私服不是必须的，如果你觉得github已经足够，那么可以跳过该教程，事实上很多人的博客都是直接托管给github的。但境内网络访问github很不稳定，加之由于github仓库是公开的，所以还是有很多缺点，使用github仓库时要时刻注意对自己网站数据的保护，否则会有泄露风险。

如果你希望在服务器建立git服务器，每次发布博客时将变更同步至服务器的git仓库，那么可以先给服务器安装git  
切换至root用户  
su root  
安装git  
yum –y install git  
键入git指令验证是否安装成功  
创建git用户，先不创建密码  
adduser git  
检查是否创建成功 cd /home && ls -al  
如果显示有git则说明用户创建成功   
接下来找一个喜欢的目录，创建一个新的git库，需要你自己起一个喜欢的名字，我起名为cpblog.git，注意.git后缀不要变  
git init --bare cpblog.git  
此时终端提示你创建了一个空的git库，这就说明操作对了。  
接下来将Hexo博客转移到服务器，以后使用hexo d发布博客就在服务器上进行了，我们需要做的是当你执行hexo d时将网站推送至自己的git仓库
新建文件夹作为博客根目录   
mkdir cpblog_webroot  
chmod 777 cpblog_webroot  
使用Git-Hooks同步网站根目录，这里使用的是Git中的“post-receive”，当有Git收发的时候会调用该脚本，自动将最新内容同步到网站根目录中
用下面的指令新建勾子文件
vim cpblog.git/hooks/post-receive
将以下语句写入文件
#!/bin/sh
git --work-tree=/usr/local/cpblog_webroot --git-dir=/root/cpblog.git checkout -f
(注意博客路径和当前用户)
保存并赋予执行权限
chmod +x cpblog.git/hooks/post-receive
sudo chown -R git:git cpblog.git
sudo chown -R git:git cpblog_webroot

修改/usr/local/nginx/conf/nginx.conf
将里面的地址改为cpblog_webroot的位置
server {
    listen    80 default_server;
    listen    [::] default_server;
    server_name    blog.59devops.com;
    root    /usr/local/cpblog_webroot
}

配置账户免密码登录  
创建 ssh 的默认目录  
进入 git 账户的主目录  
cd /home/git  
创建 .ssh 的配置，如果此文件夹已经存在请忽略此步  
mkdir .ssh  
创建校验公钥的配置文件  
进入 .ssh 目录并创建 authorized_keys 文件，此文件存放客户端远程访问的 ssh 的公钥  
cd .ssh  
touch authorized_keys  
cd ..  
设置权限  
chmod 700 .ssh/  
chmod 600 .ssh/authorized_keys  

配置Hexo的”_config.yml”  
打开位于Hexo博客根目录下的“_config.yml”文件，找到“deploy”并修改  

deploy:
   type: git
   repository: root@服务器的公网IP:/usr/local/cpblog.git  #此行改为你的私服仓库地址
   branch: main      # 分支,注意看一下仓库的主干分支是master还是main

从此以后，每次执行hexo d时，就会将网站推送到服务器的git仓库里。  
本地执行下列命令进行验证  
hexo clean  
hexo g  
hexo d  

如果你在执行hexo d时被提示输入密码，那么可以阅读接下来的内容实现hexo d免密码  下面我们添加秘钥实现免密推送   

找到服务器的id_rsa.pub文件，id_rsa.pub 文件中的内容追加到当前目录下的 authorized_keys 中  
cat id_rsa.pub >> authorized_keys  

最后别忘了做一件事，就是去域名供应商后台配置解析域名  
将你的服务器公网IP填到域名解析列表中就可以了，可搜索其它文章了解具体操作。