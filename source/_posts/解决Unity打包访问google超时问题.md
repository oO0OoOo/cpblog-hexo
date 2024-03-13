title: 解决Unity打包访问google超时问题
author: cypunberk.admin
tags:

  - Android

  - 打包
    categories:

  - Android

  - Unity
    date: 2023-04-20 13:51:00
    
    img: https://raw.githubusercontent.com/oO0OoOo/cpblog-hexo/main/source/images/591039263be09.jpg

###### 问题现象
Unity打Android包时卡在以下步骤，拖慢打包速度，但最终可以打包成功。

![image-20240313194810990](https://raw.githubusercontent.com/oO0OoOo/cpblog-hexo/main/source/images/202403131948046.png)

![image-20240313195142535](https://raw.githubusercontent.com/oO0OoOo/cpblog-hexo/main/source/images/202403131951553.png)

###### 问题原因

访问google超时，如果想印证是否由访问超时所致，可以将本地断网，若打包速度变快，即为此问题。

###### 解决方法

更改gradle文件的maven地址，一般是baseProjectTemplate.gradle文件。如果文件内有用到google()，mavenCentral()，需替换成阿里云镜像地址。

例：原版

> repositories {\*\*ARTIFACTORYREPOSITORY\*\*
> 		google()
>                 mavenCentral()
> }



替换后：

> repositories {\*\*ARTIFACTORYREPOSITORY\*\*
> 		maven { url 'https://maven.aliyun.com/repository/google'}
>                 maven { url 'https://maven.aliyun.com/repository/central}
> }



此外，在Unity打包的过程中还会利用Android SDK Tools进行本地sdk依赖检查，这步也会访问到google，所以还需做下面的处理。（需要提前准备好代理IP和端口）



先到Unity的Preference窗口查看Android SDK Tools的路径，如下图

![image-20240313200410008](https://raw.githubusercontent.com/oO0OoOo/cpblog-hexo/main/source/images/202403132004046.png)



去到这个路径下，再进到\tools\bin，找到sdkmanager.bat文件，使用文本编辑工具打开。

找到下面这一行

> "%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %SDKMANAGER_OPTS%  -classpath "%CLASSPATH%" com.android.sdklib.tool.sdkmanager.SdkManagerCli %CMD_LINE_ARGS%

替换成（注意里面加粗的地方，要换成自己的代理地址）

> "%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %SDKMANAGER_OPTS%  -classpath "%CLASSPATH%" com.android.sdklib.tool.sdkmanager.SdkManagerCli **--no_https --proxy=http --proxy_host=xxx.xxx.xxx.xxx --proxy_port=xxxx** %CMD_LINE_ARGS% 



全部完成。

