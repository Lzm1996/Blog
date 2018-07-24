---
title: vue环境部署
date: 2018-07-22 14:17:25
toc: true
tags:
    - vue.js
---
## 第一步 node环境安装

1.1 如果本机没有安装node运行环境，请下载node 安装包进行安装
1.2 如果本机已经安装node的运行换，请更新至最新的node 版本
下载地址：[https://nodejs.org/en/](https://nodejs.org/en/) 或者 [http://nodejs.cn/](http://nodejs.cn/)
---
## 第二步 node环境检测

为了快乐的使用命令行，我们推荐使用 gitbas
2.1 下载git 并安装
下载地址 [https://git-for-windows.githu...](https://git-for-windows.github.io/)
安装成功后 右键菜单
![图片1](https://sfault-image.b0.upaiyun.com/168/578/1685787651-58df73ad45978)

我们可以看到 Gti Bash Here 。说明我们已经安装成功git
2.2  检测node 是否安装成功
右键空白，选择 Gti Bash Here  弹出 

2.2.1 在终端输入 node -v  
![图片2](https://sfault-image.b0.upaiyun.com/192/561/1925617494-58df73ff69305)

如果输出版本号，说明我们安装node 环境成功

---
## 第三步 vue-cli脚手架安装

3.1 如果访问外网比较慢，可以使用淘宝的镜像 [https://npm.taobao.org/](https://npm.taobao.org/)
打开命令终端 npm install -g cnpm --registry=[https://registry.npm.taobao.org](https://registry.npm.taobao.org)
回车之后，我就可以可以快乐的用 cnpm 替代 npm

![图片3](https://sfault-image.b0.upaiyun.com/398/225/3982253046-58df7429ad0ab)

看到这样

![图片4](https://sfault-image.b0.upaiyun.com/199/691/1996915331-58df7433c63bf)

恭喜你，你已经成功安装了 cnpm
但是此后，我们还是使用 npm 来运行命令

3.2 接下来就是重点了 安装vue-cli
npm install vue-cli -g

3.3 进入我们的项目目录，右键 Gti Bash Here

3.4 初始化项目 vue init webpack vue-demo

一直回车直到

![图片5](https://sfault-image.b0.upaiyun.com/725/858/725858355-58df7497cee72)

是否要安装 vue-router 项目中肯定要使用到 所以 y 回车

是否需要 js 语法检测 目前我们不需要 所以 n 回车

是否安装 单元测试工具 目前我们不需要 所以 n 回车

是否需要 端到端测试工具 目前我们不需要 所以 n 回车

接下来 ctr+c 结束

3.5 进入 cd vue-demo

![图片6](https://sfault-image.b0.upaiyun.com/130/088/1300881970-58df7554aa79a)

3.6 执行 npm install 或者cnpm install

如果出现下图，说明安装成功

![图片7](https://sfault-image.b0.upaiyun.com/239/085/2390856303-58df7569eaeff)

3.7 接下来执行 npm run dev

默认浏览器会自动打开

> `注意：如果您的浏览器是ie9以下的版本，请升级浏览器到最新版本或者下载谷歌浏览器或者火狐浏览器进行预览。在地址栏输入 http://localhost:8080/#/进行访问`

![图片8](https://sfault-image.b0.upaiyun.com/171/524/1715248741-58df75bc54706)

恭喜，你已经成功安装，并运行起来vue基础项目，踏入了vue的大门。

