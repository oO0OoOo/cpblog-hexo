title: 博客搭建教程11 - 使用linux+nginx建站每次云服务器重启后的例行检查操作
author: epya15
tags:
  - 博客
categories:
  - 博客搭建
date: 2023-01-09 11:00:00
img: https://img2.baidu.com/it/u=2273045471,518867457&fm=253&fmt=auto&app=138&f=PNG?w=822&h=500
excerpt: '将一些需要检查的点统一记录下来作为备忘录。'
---
重启服务器后的例行操作  

1.检查防火墙  
检查防火墙状态：systemctl status firewalld  
若出现绿色的active(running)，说明防火墙已经启动，否则
systemctl start firewalld开启防火墙，没有任何提示即开启成功  
如果没有反应，或者等待1分钟后出现timeout，需要先kill掉现在的防火墙进程再重新开启  
kill防火墙进程：pkill -f firewalld  
然后再重新systemctl start firewalld开启防火墙，没有任何提示即开启成功  

2.检查nginx端口（比如80端口）  
firewall-cmd --query-port=80/tcp  
返回yes即没问题，否则打开80端口  
firewall-cmd --add-port=80/tcp --permanent  
开启后需再次重启防火墙，才能生效  
firewall-cmd --reload  

3.检查nginx服务  
开启nginx：nginx  
（nginx关闭命令：nginx -s stop）  
（nginx重启命令：nginx -s reload）  
在其它机器上访问服务器IP:端口号，如果出现nginx页面，就表示开启成功（出现40x 页面也无所谓）  
如果开启nginx提示端口被占用，需要杀死占用这个端口的进程  
可以使用一个快捷的方法，直接杀死指定端口的所有进程，比如80端口  
kill -9 $(lsof -i:80 -t)  
或者可以仔细查看是哪个进程占用了80端口  
查看80端口使用情况  
netstat -lnp|grep 80  
比如正在被nginx占用，记住显示的进程号，比如1053  
停掉nginx  
systemctl stop nginx  
强制杀掉1053进程  
kill -9 1053  
再查询  
netstat -lnp|grep 80  
没结果说明已经不占用了  
接着重新开启nginx服务  

