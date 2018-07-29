---
title: git使用
date: 2018-07-29 17:40:25
toc: true
tags:
    - git
---
git使用
<!-- more -->

## 创建新仓库
创建新文件夹，打开，然后执行
``` bash
git init
```
以创建新的 git 仓库。

## 克隆仓库

执行如下命令以创建一个本地仓库的克隆版本：
``` bash
git clone /path/to/repository
```
如果是远端服务器上的仓库，命令如下：
``` bash
git clone username@host:/path/to/repository
```

## 添加远程仓库
执行如下命令以添加一个远程仓库到本地
``` bash
git remote add [shortname] [url]
```
> shortname 指定的远程仓库的名字，一般为origin，url为远程仓库的地址

## 配置用户名和密码
当安装Git后首先要做的事情是设置用户名称和e-mail地址。这是非常重要的，因为每次Git提交都会使用该信息。它被永远的嵌入到了你的提交中：
``` bash
git config --global user.name "username"
git config --global user.email "email@example.com"
```
> 如果传递了 –global 选项，因为Git将总是会使用该信息来处理在系统中所做的一切操作。
> 如果希望在一个特定的项目中使用不同的名称或e-mail地址，可以在该项目中运行该命令而不要–global选项。

输入如下命令可以显示 Git 的配置信息
``` bash
git config --list
```
使用 –unset 参数清空需要修改的设置
``` bash
git config --unset --global user.name
```

## 添加与提交
你可以计划改动（把它们添加到缓存区），使用如下命令：
``` bash
git add <filename>
git add *
```
这是 git 基本工作流程的第一步；使用如下命令以实际提交改动：
``` bash
git commit -m "代码提交信息"
```
现在，你的改动已经提交到了 HEAD，但是还没到你的远端仓库。

## 推送改动
你的改动现在已经在本地仓库的 HEAD 中了。执行如下命令以将这些改动提交到远端仓库：
``` bash
git push origin master
```
可以把 master 换成你想要推送的任何分支。

或者
``` bash
git push -u origin master
```
> -u选项指定一个默认主机，这样后面就可以不加任何参数使用git push

如果你还没有克隆现有仓库，并欲将你的仓库连接到某个远程服务器，你可以使用如下命令添加：
``` bash
git remote add origin <server>
```
## 撤销修改
修改了工作区内容并且添加到暂存区，但未提交修改，经过 add 但未 commit 的修改
``` bash
git reset HEAD <file>...
```
修改被添加到暂存区并且提交了修改，（经过 add 和 commit 的修改），此时只要退回版本即可
``` bash
git reset --hard HEAD^
```

## 版本回退
退回到上一个版本
首先，Git必须知道当前版本是哪个版本，在Git中，用 HEAD 表示当前版本，也就是最新的提交 4da437…cd46e2，上一个版本就是HEAD^，上上一个版本就是 HEAD^^，当然往上100个版本写100个^比较容易数不过来，所以写成 HEAD~100。
现在，我们要把当前版本回退到上一个版本就可以使用git reset命令。
``` bash
git reset --hard HEAD^
```
放弃回退
如果想放弃回退，依然可以使用 “$ git reset –hard ID” 来恢复，但是必须知道要恢复版本的ID号，因为 Git log 只存储最后一次版本之前的版本记录，所以需要 git reflog 来找回之前的版本号， git reflog 用来记录用户输入的每一次命令。
``` bash
git reset --hard 4da437f
```
## 分支
分支是用来将特性开发绝缘开来的。在你创建仓库的时候，master 是“默认的”。在其他分支上进行开发，完成后再将它们合并到主分支上。
在实际开发中，我们应该按照几个基本原则进行分支管理：
首先，master 分支应该是非常稳定的，也就是仅用来发布新版本，平时不能在上面做修改；修改应该在 dev 分支上，也就是说，dev 分支是不稳定的，到某个时候，比如新版本发布时，再把 dev 分支合并到 master 上，在 master 分支发布新版本；每个人都在 dev 分支上修改，每个人都有自己的分支，时不时地往 dev 分支上合并就可以了。
查看分支
``` bash
git branch
```
创建分支
``` bash
git branch name
```
创建一个叫做“feature_x”的分支，并切换过去：
``` bash
git checkout -b feature_x
```
切换回主分支:
``` bash
git checkout master
```
再把新建的分支删掉：
``` bash
git branch -d feature_x
```

## 更新与合并
要更新你的本地仓库至最新改动，执行：
``` bash
git pull
```
以在你的工作目录中 获取（fetch） 并 合并（merge） 远端的改动。
要合并其他分支到你的当前分支（例如 master），执行：
``` bash  
git merge <branch>
```
## 解决冲突
两个分支在同一个地方提交修改，这种情况下，Git 无法执行“快速合并”，只能试图把各自的修改合并起来，但这种合并往往就可能会有冲突，尤其是当修改了同一个位置时
如果我们合并分支，git会告诉我们，文件存在冲突，必须手动解决冲突后再提交。git status 也可以告诉我们冲突的文件，此时文件图标和内容都会有响应提示来说明发生了冲突
Git 用<<<<<<<，=======，>>>>>>>标记出不同分支的内容
修改解决冲突后保存，执行如下命令，再提交即可成功合并
``` bash
git add conflict_filename
git commit -m "conflice_info"
git push
```

## 替换本地改动
你可以使用如下命令替换掉本地改动：
``` bash
git checkout -- <filename>
```
此命令会使用 HEAD中的最新内容替换掉你的工作目录中的文件。已添加到缓存区的改动，以及新文件，都不受影响。
假如你想要丢弃你所有的本地改动与提交，可以到服务器上获取最新的版本并将你本地主分支指向到它：
``` bash
git fetch origin
git reset --hard origin/master
```

