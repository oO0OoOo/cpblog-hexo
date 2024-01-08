title: 博客搭建教程8 - 在CentOS云服务器利用Nginx搭建Hexo博客
author: epya15
tags:
  - 博客
categories:
  - 博客搭建
date: 2023-01-09 08:00:00
img: https://img-blog.csdnimg.cn/img_convert/ce4a8a59fdfee8f3106a3a0851558c76.png
excerpt: ''
---
关于图形界面：  
有的云服务器将CentOS系统的图形界面阉割，如果想和Windows系统一样看到图形界面，需要额外进行安装。  
但是要注意，虽然图形界面在交互上比命令行更加直观，但是会占用大约500MB的内存，这也就意味着，如果你购买的服务器内存小于500MB，一定是无法安装图形界面的。实际上，1G内存的服务器也不建议安装图形界面，在实测中，1G内存的服务器运行图形界面会非常卡，打开一个firefox浏览器有概率直接让服务器卡死。而2G及以上的服务器安装图形界面则是无压力的，实测在2G服务器上运行CentOS系统+GNOME桌面，内存占用在50%左右。  
接下来的教程中都是以命令行的方式操作的，如果你可以接受命令行，那就尽量不要安装图形界面，毕竟它会占用一部分服务器的资源，影响到服务器的性能。  
如果你实在希望使用图形界面的方式操作，可以按照如下教程安装。  
在图形界面中打开【终端】也可以执行命令行，实测在1G内存情况下在图形界面执行【终端】是没有问题的。（但不要再开更多窗口了）  
https://blog.csdn.net/weixin_45115705/article/details/100553983

Q：找不到usr文件夹？
A：可以试试点击桌面的【主文件夹】图表，或者找到桌面左上角的【应用程序/附件/文件】,在打开的资源管理器窗口找到【其他位置】选项，点击后找到【计算机】，再点击即可看到盘根的全部文件夹，usr就在其中。
在服务器端或许由于缺少播放视频的插件而无法预览视频，但这本就不是服务器的职责，我们只要确保该文件被平安地放到指定的目录，并且可以被外部网络访问到即可。
接下来我们要做的工作就是将该视频部署到某一个网络地址，生成可以被访问的外链。

在linux安装nginx，可参考这篇文章，博主实测没有问题
https://blog.csdn.net/t8116189520/article/details/81909574  
Q：我是图形界面门徒，如何在CentOS图形界面系统上输入命令？
A：在桌面左上角应用程序中找到【系统工具/终端】即可。请注意，通过此种方式运行终端，要注意自己是否拥有root权限，如果不是root用户，需要切到root用户，或者在命令前加sudo指令。否则，你在安装nginx过程中会频繁提示【您需要root权限执行此命令】,【permission denied】，【you need to be root to xxxx】等报错。

Q：如何获取root权限？
A：可以执行su root切到root用户，选择root作为用户名登录，即可获得root权限。如果是图形界面，你可以选择注销当前账号的登录，回到登录界面，然后选择以其他身份登入，以此切换到root账号。

nginx安装完毕后，为了今后使用方便，将nginx配置到环境变量  
echo 'export PATH=/usr/local/nginx/sbin:$PATH' >> /etc/profile
并使其生效  
source /etc/profile  
接下来直接输入nginx -v,看看环境变量有没有配置成功

按照该命令安装nginx后，nginx所在的目录为usr/local/nginx，该文件夹内的nginx-1.13.7.tar.gz是安装包文件，可以删除了
删除的命令是：sudo rm -rf nginx-1.13.7.tar.gz

配置nginx过程中可能涉及到使用命令行修改文件内容,以下博客介绍的比较好，建议参考  
https://blog.csdn.net/qq_51515673/article/details/124390606  

配置完nginx后还需要开启防火墙，并且确保自己设置nginx网站端口是开放的，可参考如下文章  
https://blog.csdn.net/szw906689771/article/details/121647887
下面的文章介绍了查看端口是否开启的方法：  
https://www.muzhuangnet.com/show/78535.html
比如你要开启8089端口，那么就是下面这句话：  
firewall-cmd --query-port=8089/tcp  
如果返回的是no，则说明端口还没有打开  
开启8089端口的命令：  
firewall-cmd --add-port=8089/tcp --permanent
开启后需再次重启防火墙，才能生效  
firewall-cmd --reload
然后再查询一次端口是否打开，如果是yes，就成功了。
Q：我还是no，怎么办？
A：你在使用云服务器吗？那可能还需要在服务器控制台的安全组中创建规则，在【入方向规则】中添加对应的端口

开启nginx：nginx -c /usr/local/nginx/conf/nginx.conf  
（nginx关闭命令：nginx -s stop）  
（nginx重启命令：nginx -s reload）  
如果服务器有安装GNOME图形界面，接下来可以打开服务器的firefox浏览器，在地址栏输入本机公网IP:端口号，看看有没有显示nginx的welcome界面，如果看到了，说明nginx服务启动成功。如果操作系统没有图形界面，可以通过curl命令访问页面。   
然后在其它机器上访问http://服务器公网IP:端口号，看看能否出现nginx的welcome页面。  
如果你是严格按照文档配置的nginx，那么现在，/usr/local/nginx/html是网站资源的根目录，所有的资源都必须在此目录下才可以被访问到  
Q：可以更换目录吗？  
A：可以，只需要修改/usr/local/nginx/conf/nginx.conf文件重新指定目录即可，可以在网上轻松搜到关于这个文件的修改方法。  
nginx.conf这个文件有很多用处，在本教程的其它文章中，我们还会涉及到这个文件来实现防盗链功能。  
接下来我们都以/usr/local/nginx/html作为资源根目录来举例。  
现在做一个测试，我们要在nginx的文件夹下放置一个资源，然后尝试在其它设备上访问  
首先在服务器的nginx/html目录下创建新文件夹Images
找一台其它设备，比如一台windows电脑，使用scp指令拷贝一个图片到服务器，例如：（注意图片原路径和ip地址不能照抄）  
scp myImage.jpg root@192.168.1.104:/usr/local/nginx/html/Images
然后在这台windows电脑打开浏览器访问该图片，地址栏中依旧填写本机公网IP:端口号，与此同时在后面加上文件路径，例如192.168.1.104:8089/Images/myImage.jpg  
浏览器显示出图片了吗？如果显示出了图片，那么恭喜，你已经完成了第一次网站资源更新。  

注意：重启服务器时，nginx会重新回到关闭状态，防火墙也可能会关闭，需要留意。  开机后可能需要执行的操作：   
重新开启防火墙：systemctl start firewalld
重新启动nginx：nginx