# 博客搭建记录-安装篇


<!--more-->

## 一、前言

研究生的时候使用hexo搭建过[个人博客](https://lzm1996.github.io/)，但是当时没有写文的习惯以及markdown语法使用的不熟练，只有寥寥几篇博文，而且质量也不高

工作后养成了写文记录的习惯，而且发现这种即时渲染的markdown文档写起来还是很连贯的，在机缘巧合下阅读了一篇关于hugo搭建博客的文章，发现hugo主要使用Golang（相较于hexo的node）还是很匹配自己的技术栈的，于是决定重新搭建个人博客

本篇为个人博客的初见搭建篇，之后关于博客搭建的文档都会收录在合集中

## 二、环境依赖

> [!note]
>
> Hugo为主要的环境依赖，但是在搭建/开发过程中通常也会使用到Git、Golang、Node.js等，这里主要介绍hugo的安装，其他环境可参考Mac工具搭建

Hugo的安装很简单， 参考 [hugo官网](https://gohugo.io/installation/macos/#homebrew) 安装extended版本

``` bash
# brew安装默认会安装extended版本
brew install hugo
# 查看版本
hugo version
```

显示 `hugo v0.141.0+extended+withdeploy darwin/arm64 BuildDate=2025-01-16T13:11:18Z VendorInfo=brew` 即安装完成

## 三、快速入门

> 参考[FixIt快速入门](https://fixit.lruihao.cn/zh-cn/documentation/getting-started/quick-start/) 可以快速搭建/运行你的站点

- **创建网站**

`````bash
# 初始化
hugo new site my-blog
# 添加hugo主题
cd my-blog
git init
git submodule add https://github.com/hugo-fixit/FixIt.git themes/FixIt
echo "theme = 'FixIt'" >> hugo.toml
echo "defaultContentLanguage = 'zh-cn'" >> hugo.toml
# 运行开发服务器查看站点
# -D 参数表示包含草稿内容 --disableFastRender 参数来实时预览你正在编辑的文章页面
hugo server -D --disableFastRender
`````

- **添加内容**

````bash
# 在 content/posts 目录中创建md文件
hugo new content posts/my-first-post.md
````

## 四、主题安装

> [快速入门](#三、快速入门) 中已经介绍了通过git submodule的方式安装主题，[FixIt安装篇](https://fixit.lruihao.cn/zh-cn/documentation/installation/)介绍了其他几种方式，比如个人采用的是==**Hugo模块**==的方式安装

{{< admonition tip >}}
以这种方式，无需要在 `hugo.toml` 中配置 `theme = "FixIt"`。
{{< /admonition >}}

将Hugo 模块用于主题的最简单方法是将其导入配置中，请参阅 [使用 Hugo 模块](https://gohugo.io/hugo-modules/use-modules/)。

1. 初始化 Hugo 模块系统：`hugo mod init github.com/<your_user>/<your_project>`

> [!note]
>
> 这里需要提前创建好你的github项目并remote add关联上本地hugo项目

2. 在.toml配置文件中导入主题：

```toml
[module]
  [[module.imports]]
    path = "github.com/hugo-fixit/FixIt"
```

{{< admonition note >}}

如果你有修改主题的能力和需求，可以将FixIt主题fork到自己的仓库下，并修改fork项目的go.mod文件（将module改为github.com/<your_user>/FixIt）

接着修改配置文件的module.imports的path为你的项目module

{{< /admonition >}}

更新或管理版本，你可以使用 `hugo mod get` 命令，类似go语言的go mod。

```bash
# 更新所有模块
hugo mod get -u
# 更新所有模块及其依赖
hugo mod get -u ./...
# 更新一个模块
hugo mod get -u github.com/hugo-fixit/FixIt
# 获取特定版本（例如 v0.3.2, @latest, @main）
hugo mod get github.com/hugo-fixit/FixIt@v0.3.2
```



---

> 作者: dovisliu  
> URL: http://localhost:1313/posts/173400000000000000000000000000000000000000000000000000000000000/  

