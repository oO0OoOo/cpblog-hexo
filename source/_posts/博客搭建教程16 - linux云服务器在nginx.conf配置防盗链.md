title: 博客搭建教程16 - linux云服务器在nginx.conf配置防盗链
author: epya15
tags:
  - 博客
categories: []
date: 2023-01-09 16:00:00
img: https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/4/17/16a2a86415e2db30~tplv-t2oaga2asx-zoom-crop-mark:3024:3024:3024:1702.awebp
excerpt: '防止多媒体资源被其它网站引用从而占据流失用户或占据带宽'
---
简单的防盗链设置，可参考如下文章  
https://www.huati365.com/16b0661323e8cec6  
https://blog.csdn.net/qq_52162404/article/details/127051356  
https://www.jb51.net/article/251177.htm  

总结下来写法，以经由博主验证  
编辑.../nginx/conf/nginx.conf文件，  
如果下面这段代码是注释的状态，则将其打开  
{% image /images/nginxconfopensf.png, width=80%, alt= %}  
再增加下面代码  
{% image /images/nginxsetlocation.png, width=80%, alt= %}  
然后重启nginx  
nginx -s reload  
如果自己的网站能显示图片，其它网站CNAME过来的就不显示图片，就说明配置成功  
盗链网站效果如下  
{% image /images/otherwebsitelocaitionnginx.png, width=80%, alt= %}  
这里实现了如果检测到盗链行为就用一张图片回击，也可以只return 403，显示一张裂开的图片  
盗链提示图片资源  
{% image /images/invalid_referer_tip.png, width=80%, alt= %}