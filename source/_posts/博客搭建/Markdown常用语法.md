---
title: Markdown常用语法
author: epya15
tags:
  - 博客
categories:
  - 博客搭建
date: 2023-01-09 15:00:00
excerpt: 'Markdown语法'
img: https://raw.githubusercontent.com/oO0OoOo/cpblog-hexo/main/source/images/bg/5910392d25805.jpg
bgImg: [
    'https://raw.githubusercontent.com/oO0OoOo/cpblog-hexo/main/source/images/bg/5910391f5ba57.jpg,
]
---

本文记录了书写博文时常用的Markdown语法和Html标签

Markdown官方文档：https://markdown.tw/  
https://markdown.com.cn/basic-syntax/  
推荐阅读：
https://xuxiaoshi.gitee.io/Hexo%E9%97%AE%E9%A2%98-Hexo%E5%86%99%E4%BD%9C%E8%AF%AD%E6%B3%95%E6%8C%87%E5%8D%97/
本博客网站是基于Bamboo主题修改的，以下是Bamboo作者的Markdown语法博客，实现了很多额外的效果。
https://yuang01.github.io/categories/%E5%89%8D%E7%AB%AF/


## 文本
### 单行文本  
这是一行示例文本，没有任何语法规则。
### 多行文本
这是第一行，在本行结尾处键入2个空格再回车，即可开启第二行，只键入回车是不会换行的。  
这是第二行。
### 文本缩进与空格
　本行采用了1个汉字的缩进，方法为在这句话前面键入一个**全角空格**。同样地，我们也可以键入多个全角空格实现多层次缩进。  
　　　　本行采用了4个汉字（即8个字节）的缩进。在前方键入了4个全角空格。  
　　　　在Markdown的语法中，半角空格无论连续打多少个，都只能产生1个空格，这和Word，记事本等软件的使用习惯截然不同。因此若想在文本中增加大量空隙，可以选择使用连续的全角空格。就　　像　　这　　样。  
<span id="jump1"></span>
### 区块文本
区块文本适用于展示诗歌，名言，代码等内容，语法为在文本段上下使用\`\`\`包夹，例如：
```
　这是一段区块文本，能够拥有自己的框框，感觉这句话很重要。
```
此外，使用单个\`包夹可以在一行文本内突出某些文字，例如`美丽且突出`的我
### 标题文本
在行首插入1到6个# ，各对应到标题1到6阶，例如：  
```
# 这是一级标题
## 这是二级标题
### 这是三级标题
#### 这是四级标题
##### 这是五级标题
###### 这是六级标题
```
需要注意的是，只有1到4级标题才会被文章目录收录。

以下为Bamboo主题的定制标题样式，依赖额外js代码实现，不属于基础的Markdown语法：  
```
{% title h1, 这是一级标题 %}
{% title h6, 这是六级标题, red %}
{% titleB h5, 这是五级标题, #895546 %}
```
{% title h1, 这是一级标题 %}
{% title h6, 这是六级标题, red %}
{% titleB h5, 这是五级标题, #895546 %}  

### 引用

```
>这是一个块引用
>>这是一个二层块引用
>
>返回到第一层
```

>这是一个块引用
>>这是一个二层块引用
>
>返回到第一层

```
>这是一个块引用
>>这是一个二层块引用
>这样无法返回到第一层
```

>这是一个块引用
>>这是一个二层块引用
>这样无法返回到第一层

### 文本加粗，倾斜，上下标，删除线，下划线，大小号
（MarkDown兼容HTML语言,可直接使用HTML的语法）  
在Markdown中只需在文本前后打上星号,即可将包夹的文字**加粗**或*倾斜*：  
```
**想要加粗的内容**
*想要倾斜的内容*
```
<sup>上标</sup>和<sub>下标</sub>的写法：
```
这是<sup>上标</sup>和<sub>下标</sub>
```
<s>删除线</s>和<u>下划线</u>的写法：
```
<s>删除线</s>和<u>下划线</u>
```
<small>小号文本</small> 正常文本 <big>大号文本</big>：
```
<small>小号文本</small> 正常文本 <big>大号文本</big>
```
文本大小号的标签可以嵌套，例如：
```
<big><big><big><big><big><big><big>超巨大号文本</big></big></big></big></big></big></big> 
```
<big><big><big><big><big><big><big>超巨大号文本</big></big></big></big></big></big></big>   

以下为不太常用到的文本修饰，属于Bamboo主题的定制样式，依赖额外js代码实现，不属于基础的Markdown语法：  
```
带 {% emp 着重号 %} 的文本
带 {% wavy 波浪线 %} 的文本
键盘样式的文本 {% kbd command %} + {% kbd D %}
密码样式的文本：{% psw 这里没有验证码 %}
<span id="jump1"></span>
```
带 {% emp 着重号 %} 的文本  
带 {% wavy 波浪线 %} 的文本  
键盘样式的文本 {% kbd command %} + {% kbd D %}  
密码样式的文本：{% psw 您的验证码为：**** %}  

### 超链接

[链接到百度](https://www.baidu.com)  
[链接到站内页](/about/)  
[网络图片](https://www.baidu.com/img/bd_logo1.png?where=super)  
[站点icon](/medias/logo.jpg)  
[跳转到页面内某一位置](#jump1)
```
[链接到百度](https://www.baidu.com)  
[链接到站内页](/about/)
[网络图片](https://www.baidu.com/img/bd_logo1.png?where=super)
[站点icon](/medias/logo.jpg)
[跳转到页面内某一位置](#jump1)
注意，需要在跳转的目的地写上对应标签，jump1名字可自定义
<span id="jump1"></span>
```

### 分割线
可以在一行中用三个或以上的星号、减号、下划线来建立一个分割线。例如：  
我是分割线上面的文字
***
我是分割线下面的文字

### 小图标

想了解小图标更多使用方式，可参考以下教程：  
[Font Awesome 图标](https://www.runoob.com/font-awesome/fontawesome-tutorial.html  )  


```
<i class="fa fa-pencil"></i> 铅笔　
<i class="fa fa-cloud-upload"></i> 上传  
<i class="fa fa-download"></i> 下载　
<i class="fa fa-download fa-lg"></i> 下载变大 33%　
<i class="fa fa-download fa-2x" style="color:red;"></i> 下载两倍大
<i class="fa fa-refresh fa-spin"></i>  fa-spin 类可以让图标旋转  
<i class="fa fa-spinner fa-pulse"></i> fa-pulse 类可以使图标以 8 步为周期进行旋转。
```
<i class="fa fa-pencil"></i> 铅笔  
<i class="fa fa-download"></i> 下载　  
<i class="fa fa-download fa-lg"></i> 下载变大(33%)　  
<i class="fa fa-download fa-2x" style="color:red;"></i> 下载两倍大且变成红色  
<i class="fa fa-refresh fa-spin"></i>  fa-spin 类可以让图标旋转  
<i class="fa fa-spinner fa-pulse"></i> fa-pulse 类可以使图标以 8 步为周期进行旋转。


### 文本变色
```
<font color="red">红色</font>
<font color="#00D239">绿色</font>  //00D239为十六进制RGB颜色代码，前两位为R，中间两位为G，后两位为B
```
<font color="red">变成红色后，</font><font color="#00D239">我又变成了绿色</font>
### 文本底色
添加文本底色可以模拟记号笔的效果：  
```
本文仅适合<font style="background: orange">18岁以上</font>儿童观看
```
本文仅适合<font style="background: orange">18岁以上</font>儿童观看
### 特殊符号
以下列出了一些特殊符号，可在博文中按需使用  

▍▏➥→☛➨☑✔✘✚☷⊙●○⊕◎Θ⊙¤㊣㈱★☆◆◇◣◢◥▲▼⊿◤◥ ▷◁▶◀△◇◆▽▂▃▄▅▆▇██■▓□〓≡ ╝╚╔ ╗╬ ═ ╓ ╩ ┠ ┨┯ ┷┏┓┗┛┳⊥『』┌ ┐└ ┘∟↑↓→←↘↙┇┅ ﹉﹊﹍﹎╭ ╮╰ ╯∵∴‖︴﹏﹋﹌〖〗·≈～※∪∈の℡§∮ξ№∑⌒ζω＊≮≯ ＋－×÷±／＝∫∝ ∧∨∏‖∠≌∽Ψ〓￥〒￠￡♀♂√∩¤≡①②③④⑤⑥⑦⑧⑨⑩⑴⑵⑶⑷⑸⑹⑺⑻⑼⑽⑾⑿⒀⒁⒂⒃⒄⒅⒆⒇

### 左右对齐，居中
```
Mr.Cindy，你好：
<center>这是居中的写法</center>
<div style="text-align:right">2023年1月23日</div>
```
Mr.Cindy，你好：
<center>这是居中的写法</center>
<div style="text-align:right">2023年1月23日</div>

## 图表
### 列表
```
1. 第一项：
    - 第一项嵌套的第一个元素
    - 第一项嵌套的第二个元素
      - 第一项嵌套的第二个元素嵌套的第一个元素
        -  第一项嵌套的第二个元素嵌套的第一个元素嵌套的第一个元素
2. 第二项：
    - 第二项嵌套的第一个元素
      - 第二项嵌套的第一个元素嵌套的第一个元素
    - 第二项嵌套的第二元素
```
1. 第一项：
    - 第一项嵌套的第一个元素
    - 第一项嵌套的第二个元素
      - 第一项嵌套的第二个元素嵌套的第一个元素
        -  第一项嵌套的第二个元素嵌套的第一个元素嵌套的第一个元素
2. 第二项：
    - 第二项嵌套的第一个元素
      - 第二项嵌套的第一个元素嵌套的第一个元素
    - 第二项嵌套的第二元素


### 表格
```
|水果|颜色|甜度|价格|
|---|:---:|:---|---:| 
|草莓|红色|★|160|
|葡萄干|紫|★★★|5000|
|默认对齐|居中|左对齐|右对齐|
```
|水果|颜色|甜度|价格|
|---|:---:|:---|---:| 
|草莓|红色|★|160|
|葡萄干|紫|★★★|5000|
|默认对齐|居中|左对齐|右对齐|

（在手机浏览器不生效？博主也发现了这个问题）

### 选项卡
```
{% tabs tab-id %}
<!-- tab 栏目1 -->
栏目1的内容
<!-- endtab -->
<!-- tab 栏目2 -->
栏目2的内容
<!-- endtab -->
{% endtabs %}
```
{% tabs tab-id %}
<!-- tab 栏目1 -->
栏目1的内容
<!-- endtab -->
<!-- tab 栏目2 -->
栏目2的内容
<!-- endtab -->
{% endtabs %}

### 时间线
```
{% timeline %}
{% timenode 2021-01-01 [1.0.3 -> 1.0.3](https://github.com/yuang01/hexo-theme-bamboo) %}
完成了工作A
工作B继续延期
{% endtimenode %}
{% timenode 2020-08-15 [1.0.2 -> 1.0.2](https://github.com/yuang01/hexo-theme-bamboo) %}
工作B决定延期
{% endtimenode %}
{% timenode 2020-08-08 [1.0.0 -> 1.0.0](https://github.com/yuang01/hexo-theme-bamboo) %}
进行工作A
进行工作B
{% endtimenode %}
{% endtimeline %}
```
{% timeline %}
{% timenode 2021-01-01 [1.0.3 -> 1.0.3](https://github.com/yuang01/hexo-theme-bamboo) %}
完成了工作A
工作B继续延期
{% endtimenode %}
{% timenode 2020-08-15 [1.0.2 -> 1.0.2](https://github.com/yuang01/hexo-theme-bamboo) %}
工作B决定延期
{% endtimenode %}
{% timenode 2020-08-08 [1.0.0 -> 1.0.0](https://github.com/yuang01/hexo-theme-bamboo) %}
进行工作A
进行工作B
{% endtimenode %}
{% endtimeline %}

## 多媒体
### 图片
```
<img src="https://www.baidu.com/img/bd_logo1.png?where=super" width="50%" height="50%" /> 
```
效果：
<img src="https://www.baidu.com/img/bd_logo1.png?where=super" width="50%" height="50%" /> 


### 网站小窗
```
<iframe name="斗鱼首页" width="100%" height="540px" frameborder="0" src="https://www.douyu.com/"></iframe>
```
效果：
<iframe name="斗鱼首页" width="100%" height="540px" frameborder="0" src="https://www.douyu.com/"></iframe>  

### 视频

#### 引用视频源
该方式引用视频无法在markdown编辑软件中实时预览
```
{% video  https://assets.mixkit.co/videos/preview/mixkit-down-the-river-in-a-bamboo-canoe-6804-large.mp4 %}
```
效果：
{% video  https://assets.mixkit.co/videos/preview/mixkit-down-the-river-in-a-bamboo-canoe-6804-large.mp4 %}

换用`<video>`标签的方式则可以实时预览  

```
<video width="480" controls loop align-items: center src="https://assets.mixkit.co/videos/preview/mixkit-down-the-river-in-a-bamboo-canoe-6804-large.mp4" />
```

<video width="480" controls loop align-items: center src="https://assets.mixkit.co/videos/preview/mixkit-down-the-river-in-a-bamboo-canoe-6804-large.mp4" />