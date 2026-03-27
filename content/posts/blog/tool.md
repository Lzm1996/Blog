---
title: 博客搭建记录-工具篇
subtitle:
date: 2025-03-13T09:41:16+08:00
slug: 5c2e530
draft: false
author:
  name: dovisliu
  link:
  email:
  avatar:
description:
keywords:
license:
comment: false
weight: 0
categories:
  - 
tags:
  - 
collections:
  - 博客搭建
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromFeed: false
hiddenFromRelated: false
summary:
resources:
  - name: featured-image
    src: featured-image.jpg 
  - name: featured-image-preview
    src: featured-image-preview.jpg
toc:
  auto: true
math: false
lightgallery: false
---

<!--more-->

## 一、前言

工欲善其事，必先利其器，本篇将介绍搭建/书写博客常用的工具，之前不愿写个人博客的一部分原因就是因为没有趁手的工具以及写起来不爽

比如个人不是很习惯非原地渲染的编辑器，分屏看效果不是很习惯；图片的处理和存储也是书写博客的一大痛点......

## 二、实时渲染的编辑器

习惯了公司内部的文档编辑渲染方式（比如飞书文档/云雀等），现在写文都倾向于这类实时渲染的编辑方式，所以这里探索了几种方式：

### 2.1 借助飞书文档等第三方文库

> 第三方文库其实就是一个定制好的“博客站点”，用户在上面编写/发文，可以很好的使用企业级的文档能力

|        | 方案介绍                                           | 优缺点                                                       |
| ------ | -------------------------------------------------- | ------------------------------------------------------------ |
| 方案一 | 直接使用飞书文档的知识库或者云雀知识库作为个人博客 | 优点：可以直接使用公司级文档的一些能力，比如画图/多维表格等<br />缺点：个人版飞书文档空间有限，而且加载很慢；文档不利于迁移；不支持页面的定制化；不支持RSS |
| 方案二 | 将飞书文档转成markdown文件                         | 优点：飞书文档作为编辑器使用，博客站点还是使用Hugo搭建，既保证了撰写爽感，又解决了网站的速率/空间有限/文档迁移的问题<br />缺点：目前官方飞书文档不支持导出markdown，github上一些导出项目不是很完善，无法很好处理文档中的图片以及其他样式 |

综上：这类方式目前还不完善，除非直接入手个人会员版

### 2.2 VScode插件

vscode是当下最火的编辑器之一，基于其丰富的插件库基本支持了所有语言的编辑/开发需求

比如基于markdown all in one可以实现md文本的分屏渲染

但是原地渲染的插件比较少见，目前了解的Inkdown Editor可以支持原地渲染，和Typora有点类似，但是功能层面还是比不过Typora

### 2.3 Typora（目前选择）

网上搜了很多笔记软件，发现还是Typora对原地渲染支持的比较好，对md的书写体验是最好的

只是该软件需要收费，如果不激活的话只能打开一个窗口，本人目前也在使用该软件

## 三、图床搭建

> 参考文档 https://sspai.com/post/90170

常见的个人博客图片处理方式一般分为两种：

1. 图片保存到本地，同站点一起发布，通过相对/绝对路径引用图片

> [!note]
>
> 优点是操作简单；
>
> 缺点是需要管理图片、加载较慢、迁移需要同时迁移图片

2. 大家常用的第二种方式即：自己搭建图床服务，将图片上传到CDN服务

> [!note]
>
> 优点是统一管理、加载速率快、公开链接无迁移成本；
>
> 缺点则是前置的搭建成本（包括服务器的成本）

接下来将介绍如何基于Cloudflare R2 + PicGo + Cloudflare Images Transform进行图床搭建

### 3.1 Cloudflare R2

R2是云服务厂商[Cloudflare](https://dash.cloudflare.com/)提供的对象存储服务，注册账号并绑定信用卡（不会收费，用于验证身份）后就开始开始创建图床服务了

- 创建存储桶，并自定义桶命名，创建完后就可以使用了
- 为了使用方便通常还可以绑定自定义域名和开启R2.dev 子域访问

当我们完成上述配置后，可以回到存储桶「对象」界面，上传一张示例图片，点开详情则会显示该图片的访问地址，此时我们就拥有了一个可访问的图床服务了。

但每次都要打开 Cloudflare 页面手动上传图片的方式显然不够便捷。R2 提供了 S3 兼容的 API，可以方便地使用一些客户端/命令行工具进行上传、删除等操作。

- 回到 R2 主页面，点击右上角「管理 R2 API 令牌」，进入后点击「创建 API 令牌」
- 完成创建后会显示所有密钥，我们使用 PicGo 需要的是下面三个信息，只会显示一次，建议在密码管理软件或其他地方妥善保管好这些参数信息，如果忘记了可以操作轮转令牌



至此，我们需要在 Cloudflare R2 上配置的部分就完成了，接下来我们需要配置 PicGo 客户端。

### 3.2 PicGo

PicGo 是一个用于快速上传并获取图片 URL 的工具软件，有着较为丰富的插件生态，支持多种图床服务，其 GitHub 仓库为「[GitHub - Molunerfinn/PicGo](https://github.com/Molunerfinn/PicGo)」，可以下载对应平台客户端使用。

- 配置R2图床（PicGo本体不包括S3图床，需要通过插件安装）
- 图床Amazon S3配置

  - **应用密钥 ID**，填写 R2 API 中的 Access Key ID（访问密钥 ID）

  - **应用密钥**，填写 R2 API 中的 Secret Access Key（机密访问密钥）

  - **桶名**，填写 R2 中创建的 Bucket 名称，如我上文的 `yu-r2-test`

  - **文件路径**，上传到 R2 中的文件路径，我选择使用 `{year}/{month}/{fileName}.{extName}` 来保留原文件的文件名和扩展名。

  - **自定义节点**，填写 R2 API 中的「为 S3 客户端使用管辖权地特定的终结点」，即 `xxx.r2.cloudflarestorage.com` 格式的 S3 Endpoint

  - **自定义域名**，填写上文生成的 `xxx.r2.dev` 格式的域名或自定义域名
- 以上即完成了PicGo工具的配置，上传图片后生成的链接会自动在系统的剪切板中，我们也可以在设置中自定义生成的链接格式，如 `![$fileName]($url)` ，并在上传区的链接格式处选择了「Custom」，这样我上传后就会根据文件名生成以文件名为 Alt 文本的 Markdown 图片链接。

**为了更方便上传图片，这里可以结合Alfred工具实现将剪切板图片自动上传服务器**

- 新建Alfred workflow，如下图所示，两个组件即可

![20250608105205225](https://r2.dovisliu.com/2025/06/20250608105205225.png)

- 其中关键的自动上传脚本如下

> 通过pngpaste命令（需要homebrew安装）将剪切板图片copy到临时文件，然后调用picgo的http接口自动上传图片

``` bash
export PATH="/opt/homebrew/bin:$PATH"

mkdir -p /tmp/alfred-tc/
rm /tmp/alfred-tc/*

now=$(date +%Y-%m-%d:%H:%M:%S)

tmp_path=/tmp/alfred-tc/$now.png
p_log=/tmp/alfred-tc/$now.png.log

pngpaste - >>$tmp_path &>$p_log
if [ "$?" != "0" ]
then
pres=$(cat $p_log)
cat <<EOF
{"items": [
{
    "uid": "item0",
    "title": "$pres",
    "subtitle": "上传图片出错"
}
]}
EOF

exit 0
fi


request=<<EOF
{
    "list":[
        "$tmp_path"
    ]
}
EOF

res=`curl --location --request POST "${picgo_http_url}" \
--header 'Content-Type: application/json' \
--data-raw "$request"`

img_url=$(echo $res | jq -r '.result[0]')

cat <<EOF
{"items": [
{
    "uid": "item0",
    "title": "$img_url",
    "subtitle": "上传图片原始链接",
	"icon":"$img_url",
	"arg":"$img_url"
},
{
    "uid": "item1",
    "title": "$img_url",
    "subtitle": "上传图片markdown链接",
	"icon":"$img_url",
	"arg":"![img]($img_url)"
}
]}
EOF
```

## 四、评论搭建

## 五、搜索功能搭建

