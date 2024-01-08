title: 博客搭建教程9 - 使用scp命令从Windows向linux传输文件
author: epya15
tags:
  - 博客
categories: []
date: 2023-01-09 09:00:00
img: https://gss0.baidu.com/70cFfyinKgQFm2e88IuM_a/baike/pic/item/64380cd7912397ddea52b9315582b2b7d0a287df.jpg
excerpt: '如果你还在用微信同步文件，那可以了解一下scp命令'
---
Windows使用scp向linux服务器传输文件,可参考这篇博客  
https://www.cnblogs.com/tugenhua0707/p/8278772.html

比如传送一个Windows桌面上的视频到服务器，输入下面指令并回车
scp D:\Users\Administrator\Desktop\video.mp4 root@208.87.201.164:/usr/local
会提示这个：

{% image /images/scpwindowsfirstlink.png, width=80%, alt= %}
这是因为首次连接，双方机器还互相陌生，需要打个招呼，只需输入yes并回车

{% image /images/scpwindowslinkok.png, width=80%, alt= %}
接下来输入远程服务器的密码
注意由于上面我们使用了向root传输数据的命令，因此该密码必须是linux服务器root用户的密码，如果你使用的是云服务器，那么在云服务器控制台/实例页面中能看到  
如果出现下面的图说明传输成功，博主传输了一个59MB视频，时间消耗29s，平均速度为2MB/s  
{% image /images/scptransferdemo.png, width=80%, alt= %}  
接下来到服务器/usr/local目录下查看这个文件就可以了。