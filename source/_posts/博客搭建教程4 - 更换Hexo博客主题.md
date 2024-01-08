title: 博客搭建教程4 - 更换Hexo博客主题
author: epya15
tags:
  - 博客
categories:
  - 博客搭建
date: 2023-01-09 04:00:00
img: https://img1.baidu.com/it/u=4061327327,3801077277&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500
excerpt: '截止至2023/2/6，Hexo已经拥有375款主题。'
---
在这里选择喜欢的主题
https://hexo.io/themes/

在Hexo博客仓库目录里可以看到_configs.yml和themes文件夹。
这两个文件夹在更换主题时非常重要。
{% image /images/themeandconfigs.png, width=80%, alt= %}

其中themes文件夹负责存储下载的主题，每一个下载的主题都以其名字的方式放在此文件夹里，例如

{% image /images/themesIntro.png, width=80%, alt= %}

文件_configs.yml则是博客网站的配置文件，主题下载好后，用文本编辑器编辑这个文件，只要修改theme字段，改为主题名称即可，图片中使用bamboo作为当前博客主题。

{% image /images/setbamboostyle.png, width=80%, alt= %}


主题安装方式：
这里的每一个主题都对应一个Github仓库，比如我们选择了Ocean这个主题
https://github.com/zhwangart/hexo-theme-ocean

{% image /images/selectoceanstyle.png, width=80%, alt= %}

可以看到Readme文档，里面有使用Git命令安装主题的方式。

使用$ git clone https://github.com/zhwangart/hexo-theme-ocean.git themes/ocean
将主题下载到themes文件夹，注意目录结构，确保themes下就是ocean的git仓库，而且命名就叫ocean
接着在_configs.yml中（注意不是themes/ocean目录下面的_configs.yml），找到theme字段，更改为
theme: ocean

接下来在博客目录下启动终端
执行hexo s

接下来就可以在浏览器输入 http://localhost:4000/  预览主题了

Q:系统不识别hexo命令？
A：是因为hexo命令没有配置到环境变量，或者没有在合法的目录下执行hexo s命令。hexo并非在任何目录下都可以执行hexo s，必须要在博客工程的根目录下。

想定制主题？
进入themes/ocean文件夹，修改_config.yml文件，通常主题的Git文档中会介绍这个文件里的配置如何修改，你可以在这个配置文件中控制网站图表，是否开启评论系统，是否允许右键复制等等。

Q：我可以在themes文件夹中放置多个主题吗？实际运行网站时显示的是哪一个主题？
A：完全可以，多个主题在themes文件夹中互相并不影响，网站运行时使用的主题就是_config.yml中theme字段配置的主题名。