title: 对超过2G的apk重新进行4字节对齐并做v1+v2签名
author: cypunberk.admin
tags:
  - Android

  - 打包
  categories:

  - Android

  - Unity
  date: 2023-04-20 13:51:00

  img: https://raw.githubusercontent.com/oO0OoOo/cpblog-hexo/main/source/images/591039263be09.jpg
---
###### 工具准备
- zipalign2G.exe文件下载: <i class="fa fa-download"></i> [zipalign2G.exe](https://download.csdn.net/download/liyingzai/13216149?spm=1001.2101.3001.6650.8&utm_medium=distribute.pc_relevant.none-task-download-2%7Edefault%7EOPENSEARCH%7ERate-8-13216149-blog-8109883.235%5Ev29%5Epc_relevant_default_base3&depth_1-utm_source=distribute.pc_relevant.none-task-download-2%7Edefault%7EOPENSEARCH%7ERate-8-13216149-blog-8109883.235%5Ev29%5Epc_relevant_default_base3&utm_relevant_index=8) 
- apksigner.jar（一般位于AndroidSDK的build-tools文件夹内）
- keystore文件，key-alias，key-password信息

###### 操作步骤
假设zipalign2G.exe，apksigner.jar，apk包，keystore的绝对路径位于D:\\
1.对apk重新进行4字节对齐，命令如下  
>D:\zipalign2G.exe -f -v 4 D:\input.apk D:\output_aligned.apk  

提示Verification succesful即为成功

2.进行v1+v2签名，命令如下  
>java -jar D:\apksigner.jar sign --ks D:\myapk.keystore --ks-key-alias myaliasname --ks-pass pass:12345678 --key-pass pass:12345678 --out D:\output_signed.apk D:\output_aligned.apk  

3.通过以下命令验证是否签名成功  
>java -jar D:\apksigner.jar verify -v D:\output_signed.apk  

若出现  
>Verifies  
>Verified using v1 scheme (JAR signing): true  
>Verified using v2 scheme (APK Signature Scheme v2): true  

说明签名成功  

此时的包就可以安装到Android 11版本以上的手机了。