---
title: python生成二维码图片
author: cypunberk.admin
tags:
  - Android
  - 打包
categories:
  - OpenHarmony
  - Unity
date: 2024-04-18 00:00:00
img: https://raw.githubusercontent.com/oO0OoOo/cpblog-hexo/main/source/images/bg/591039263be09.jpg
---
安装python环境，将下面代码保存到generateQRcode.py文件

```python
#pip install qrcode
#用法 py generateQRcode.py "Hello world!" "D:/qrcode.png"

import qrcode
import sys

url = "Hello world!"
output = "D:/qrcode.png"

if len(sys.argv) >= 2:
    url = sys.argv[1]
if len(sys.argv) >= 3:
    output = sys.argv[2]

qr = qrcode.QRCode(version=1, error_correction=qrcode.constants.ERROR_CORRECT_L, box_size=20, border=2)
qr.add_data(url)
qr.make(fit=True)
img = qr.make_image(fill_color="black", back_color="white")
img.save(output)
```

打开cmd窗口键入：

py generateQRcode.py "Hello world!" "D:/qrcode.png"

即可生成图片。