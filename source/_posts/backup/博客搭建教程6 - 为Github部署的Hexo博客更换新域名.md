title: 博客搭建教程6 - 为Github部署的Hexo博客更换新域名
author: epya15
tags:
  - 博客
categories:
  - 博客搭建
date: 2023-01-09 06:00:00
img: http://img.idcicp.com//attached/20210708/6376133546709039089257812.jpg
excerpt: '短小好记的域名通常不便宜，但还是有捡漏的机会，又或许你最在意的那个名字根本没有人注册过。'
---
首先在域名购买网站挑选心仪的域名并购买，比如万网：
https://wanwang.aliyun.com/domain

暂时不知道想要什么域名？那买一个最便宜的就可以了。又短又便宜的域名不多见，但是捞到就是赚到。

购买后在域名控制台就能进行域名解析操作了。

{% image /images/wanwanggoumaiyuming.png, width=80%, alt= %}

点击域名后面的【解析】按钮，进入解析界面

关于如何添加解析记录，可以参考这篇文章
https://zhuanlan.zhihu.com/p/103813944

大体操作思路是：
登录自己的github博客仓库，在页面上找到Settings按钮，点击进入
{% image /images/girhubhoutaisettings.png, width=80%, alt= %}

进入Pages页面

{% image /images/githubsettingpage.png, width=80%, alt= %}
在Pages页面里可以看到你目前的域名，是以github.io结尾的，接下来我们在CustomDomain里填写自己的域名，并点击Save
接下来就会发现你的博客地址变成了自己填写的域名
{% image /images/githubsetselfurl.png, width=80%, alt= %}
点击【Visit site】进行测试,看看能否访问。若可以访问，则说明配置成功。