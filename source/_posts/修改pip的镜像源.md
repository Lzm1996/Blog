---
title: pip镜像源修改
date: 2018-07-29 20:17:25
toc: true
tags:
    - python
---
pip镜像源修改
<!-- more -->

## pip国内镜像
阿里云 [http://mirrors.aliyun.com/pypi/simple/](http://mirrors.aliyun.com/pypi/simple/)
中国科技大学 [https://pypi.mirrors.ustc.edu.cn/simple/](https://pypi.mirrors.ustc.edu.cn/simple/)
豆瓣 [http://pypi.douban.com/simple/](http://pypi.douban.com/simple/)
清华大学 [https://pypi.tuna.tsinghua.edu.cn/simple/](https://pypi.tuna.tsinghua.edu.cn/simple/)
中国科学技术大学 [http://pypi.mirrors.ustc.edu.cn/simple/](http://pypi.mirrors.ustc.edu.cn/simple/)

##修改源方法

临时使用可以在使用pip的时候在后面加上-i参数，指定pip源
```
pip install scrapy -i https://pypi.tuna.tsinghua.edu.cn/simple
```
永久修改：
linux修改 ~/.pip/pip.conf (没有就创建一个)， 内容如下：
```
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
```
windows直接在user目录中创建一个pip目录，如：C:\Users\xx\pip，新建文件pip.ini，内容如下:
```
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
```