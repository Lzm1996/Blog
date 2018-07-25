---
title: mysql8.0环境部署
date: 2018-07-22 14:17:25
tags: 
    - mysql
---
mysql8.0环境部署
<!-- more -->
## 1.1.下载：

官网下载zip包，我下载的是64位的：

下载地址：[https://dev.mysql.com/downloads/mysql/](https://dev.mysql.com/downloads/mysql/)

下载后解压：（解压在哪个盘都可以的）

我放在了这里 E:\web\mysql-8.0.11-winx64 ，顺便缩短了文件名，所以为&nbsp;E:\web\mysql-8.0.11。

## 1.2.配置环境变量：

**进入 计算机--高级系统设置--高级--环境变量**

**然后新建系统变量**

**变量值改为自己mysql解压的路径**

变量名：MYSQL_HOME

变量值：E:\web\mysql-8.0.11

path里添加：%MYSQL_HOME%\bin;(分号不要忘记)

## 1.3.&nbsp;**生成data文件：**

以管理员身份运行cmd

程序--输入cmd 找到cmd.exe 右键以管理员身份运行

进入E:\web\mysql-8.0.11\bin下

执行命令：
```bash
mysqld --initialize-insecure --user=mysql
```
在E:\web\mysql-8.0.11目录下生成data目录

## 1.4.启动服务：

执行命令：`net start mysql`  启动mysql服务，若提示：服务名无效...(请看步骤：1.5）；

## 1.5.&nbsp;解决启动服务失败（报错）：

提示：服务名无效

解决方法：

执行命令：`mysqld -install`即可（不需要my.ini配置文件 注意：网上写的很多需要my.ini配置文件，其实不需要my.ini配置文件也可以，我之前放置了my.ini文件，反而提示服务无法启动，把my.ini删除后启动成功了）

若出现提示“服务正在启动或停止中，请稍后片刻后再重试一次”，需要去资源管理器中把mysql进程全结束了，重新启动即可。

## 1.6.&nbsp;登录mysql:

登录mysql:(因为之前没设置密码，所以密码为空，不用输入密码，直接回车即可）
```bash
E:\mysql-5.7.20-winx64\bin>mysql -u root -p 
Enter password:
```
## 1.7.&nbsp;查询用户密码:

查询用户密码命令：mysql&gt; select host,user,authentication_string&nbsp;from mysql.user;

host: 允许用户登录的ip‘位置’%表示可以远程；

user:当前数据库的用户名；

authentication_string: 用户密码（后面有提到此字段）；

## 1.8.&nbsp;设置（或修改）root用户密码：

默认root密码为空的话 ，下面使用navicat就无法连接，所以我们需要修改root的密码。

这是很关键的一步。此处踩过N多坑，后来查阅很多才知道在mysql 5.7.9以后废弃了password字段和password()函数；authentication_string:字段表示用户密码。

下面直接演示正确修改root密码的步骤：

　　一、如果当前root用户authentication_string字段下有内容，先将其设置为空，否则直接进行二步骤。
```bash
use mysql;
update user set authentication_string='' where user='root';
```
　　二、使用ALTER修改root用户密码
```bash
ALTER user 'root'@'localhost IDENTIFIED BY 'Cliu123#';
```

注意： 一定不要采取如下形式该密码：

```bash
1.  use mysql;
2.  update user set authentication_string="newpassword" where user="root";
```

这样会给user表中root用户的authentication_string字段下设置了newpassword值；

当再使用ALTER USER 'root'@'localhost' IDENTIFITED BY 'newpassword'时会报错的；

因为authentication_string字段下只能是mysql加密后的41位字符串密码；其他的会报格式错误；

至此，安装mysql和修改root密码告一段落。开始navicat for mysql篇。

账号密码都正确，连接报错1251。我们先来看看这个改动：

在MySQL 8.04前，执行：SET PASSWORD=PASSWORD('[新密码]');但是MySQL8.0.4开始，这样默认是不行的。因为之前，MySQL的密码认证插件是“mysql_native_password”，而现在使用的是“caching_sha2_password”。

so,我们这里需要再次修改一次root密码。

先登录进入mysql环境：执行下面三个命令。（记得带上分号）
```bash
use mysql；
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '新密码';
FLUSH PRIVILEGES;
```
OK.现在再去重连。perfect!