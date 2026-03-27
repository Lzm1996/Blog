# 程序员Mac工作环境搭建


程序员在面对新机时，如何快速有序的搭建工作环境，本文包括基础的环境配置和常用效率工具的整理


<!--more-->

## 基础环境配置

{{< admonition tip >}}  
**建议优先**[安装并配置好iterm终端工具](#iterm2%E5%AE%89%E8%A3%85%E5%92%8C%E9%85%8D%E7%BD%AE)**，再进行其他环境配置**  
{{< /admonition >}}

### iterm2安装和配置

1. 下载链接：[https://iterm2.com/downloads.html](https://iterm2.com/downloads.html)
2. 安装 Oh-My-Zsh：[官方地址](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file)

> [!note]
> 
> Oh-My-Zsh 是一个开源的、社区驱动的框架，用于管理 Zsh 的配置。它提供了大量的主题和插件，方便我们对 Zsh 进行定制（zsh不需要额外安装，现在mac终端都是自带的）

在终端中运行以下命令来安装 Oh My Zsh：

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 如果请求超时，则使用国内镜像
sh -c "$(curl -fsSL https://gitee.com/pocmon/ohmyzsh/raw/master/tools/install.sh)"
```

3. 下载zsh主题，这里以powerlevel10k为例

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 打开.zshrc文件编辑，设置主题 `ZSH_THEME="powerlevel10k/powerlevel10k"`
```

4. 下载字体 ==（可选）==

> [!TIP]
> 
> 一些主题需要特定的系统字体支持，比如p10k需要MesloLGS相关字体，通常终端启动时主题会提示下载字体，但是有**可能出现网络超时**的问题，这里提供一个手动下载的方法

- 前往 [Nerd Fonts 官方网站](https://www.nerdfonts.com/font-downloads) 下载 MesloLGS NF，随后下载就得到一系列的字体文件（通常是 .ttf 或 .otf 格式），选择 MesloLGS NF相关的
- 双击安装字体
- 在iterm中配置字体

  - 打开 iTerm2，点击 iTerm2 菜单中的 Preferences。
  - 在 Profiles 选项卡中，选择你正在使用的 Profile。
  - 点击 Text，在 Font 部分，从字体列表中选择 MesloLGS NF 字体。


5. 插件安装 **（建议）**

```bash
# 自动提示
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting 高亮
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-completions 额外自动补全
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

> [!IMPORTANT]
> 
> 下载完插件后，修改.zshrc文件启用插件 `plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)`

### brew安装

> Homebrew（brew）是一种管理和安装各种软件包的方便的解决方案。

在安装 Homebrew 之前，需要先安装 Xcode 命令行工具，这个工具包含了 Homebrew 所需的编译器和其他工具。打开终端（Terminal），然后运行以下命令，按照提示安装即可：

```bash
xcode-select --install
```

Xcode 命令行工具安装完成后，继续安装 Homebrew。打开终端，执行以下命令：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安装完成、配置好环境变量后，可以通过运行 `brew --version`来验证是否安装成功

### git

在Mac上配置GitHub SSH Key的详细步骤：

1. 检查是否已经安装SSH  
   在终端中输入以下命令，检查是否已经安装了SSH：

```bash
ssh -T git@github.com
```

如果出现 `Permission denied (publickey).` 或类似的信息，说明已经安装了SSH，但可能没有配置正确的密钥；如果出现 `command not found` 信息，说明没有安装SSH，需要先安装。

2. 生成新的SSH Key，如果需要生成新的SSH Key，可以使用以下命令：

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

> [!tip]
> 
> - `t rsa` 表示使用RSA算法生成密钥。
> - `b 4096` 表示密钥长度为4096位，这样会更安全。
> - `C "your_email@example.com"` 用于给密钥添加注释，通常使用你的电子邮件地址，以便你能记住该密钥的用途。

在运行上述命令后，会提示你输入文件保存位置，一般默认的位置是 `~/.ssh/id_rsa` ，你可以直接按回车键使用默认位置；然后会提示输入密码，这个密码是用来保护你的私钥的，可以输入一个密码，也可以直接按回车键留空（不建议留空）。

3. 复制公钥到GitHub（你需要将生成的公钥添加到GitHub账户中），使用以下命令复制公钥

```bash
pbcopy < ~/.ssh/id_rsa.pub
```

4. 测试连接，使用以下命令测试连接：

```bash
ssh -T git@github.com

# 如果配置成功，你会看到类似 `Hi username! You've successfully authenticated, but GitHub does not provide shell access.` 的信息。
```

5. 配置git config

```bash
# 配置用户名
git config --global user.name "Your Name"

# 配置邮箱
git config --global user.email "your_email@example.com"

# 查看全局配置
git config --global --list
```

### vim

> [!NOTE]
> 
> 个人使用vim不是很多，主要还是使用别的IDE进行开发或者编辑文本，因此这里只展示基础的vim配置
> 
> 如果想把vim打造成一个开发利器，建议参考的配置 **[vim-plus-plus](https://github.com/FLHonker/vim-plus-plus)** 和 **[powerVim](https://github.com/youngyangyang04/PowerVim)**

新建.vimrc配置，配置如下：

```vim
set encoding=utf-8

# 搜索忽视大小写
set ignorecase

# 允许粘贴
set paste

# 显示行号
set number

# 允许鼠标
set mouse=a

# 自动缩进
set autoindent

# 高亮显示当前行
set cursorline
```

## 开发环境配置

> 根据不同编程语言进行划分，用到时配置即可

### golang

1. 使用homebrew安装或者官网下载pkg安装即可

```bash
brew install go
```

2. 验证 `go version`

### node & npm

由于 npm 是随同 Node.js 一起发布的，所以首先要安装 Node.js。

*方法一：使用官方安装包（推荐）*

- 访问 Node.js 官方网站（ [https://nodejs.org/](https://nodejs.org/) ）。
- 下载适合 Mac 系统的安装包（一般是.pkg 文件）。
- 双击下载的安装包，按照安装向导的提示进行操作。在安装过程中，会自动安装 Node.js 和 npm。
- 安装完成后，可以在终端中输入node -v来检查 Node.js 的版本，输入npm -v来检查 npm 的版本，以确认安装成功。

*方法二：使用 Homebrew（如果已经安装了 Homebrew）*

- Homebrew 是 Mac 上的包管理器。如果已经安装了 Homebrew，可以在终端中输入以下命令来安装 Node.js：

```bash
brew install node
```

安装完成后，同样可以使用node -v和npm -v来检查版本。

### java

现在一般都使用8～11版本的jdk，可以参考以下几种安装方式：

1. 使用oracle官网安装包进行安装

> oracle安装jdk需要注册登录，以及低版本jdk安装页面可能进不去，可以使用国内华为云的jdk  
[https://blog.csdn.net/wuyujin1997/article/details/122897900](https://blog.csdn.net/wuyujin1997/article/details/122897900)

2. 使用brew安装指定版本open-jdk

```bash
brew install openjdk@11
```

### python

现在一般使用3.6/7/8版本的python，但是旧版本的py官网已经不提供安装了，需要使用类似pyenv的管理包来安装  
{{< admonition warning >}}  
直接使用 `brew install pyenv`会有问题，后续无法成功安装python3.8，建议下载网上最新版pyenv进行安装  
{{< /admonition >}}

1. 安装pyenv

```bash
curl https://pyenv.run | bash

echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc

source ~/.zshrc
```

2. 使用pyenv安装python

```bash
pyenv install 3.8.17
# 设置全局python-version
pyenv global 3.8.17
```

3. 使用python创建虚拟环境，用于不同工作环境的隔离

```bash
# 在项目根目录下执行venv命令，ksenv是自定义环境名
python -m venv ksenv
# 激活环境，然后可以在该环境下使用pip安装所需依赖
source ksenv/bin/activate
```

4. 退出虚拟环境

````
deactivate
````

## 常用工具工具

### vscode安装和配置

1. 下载链接：[https://code.visualstudio.com/Download](https://code.visualstudio.com/Download)
2. 设置 `code`命令以便在终端中快速打开文件或文件夹

   - 打开 VS Code，通过快捷键 `Command + Shift + P` 调出命令面板。
   - 在命令面板中输入 “path”，找到 “Shell Command: Install 'code' command in PATH” 并执行该命令。
   - 这个操作会在你的系统中设置一个符号链接，使得在终端中可以使用code命令来启动 VS Code。

3. 安装常用插件

   - GitHub Copilot AI代码助手，通过github授权登录使用
   - Markdown All in One
   - Inkdown Editor


### JetBrains Toolbox

> 管理各类语言编程IDE，如常见的IDEA、Goland等

下载地址：[https://www.jetbrains.com.cn/toolbox-app/](https://www.jetbrains.com.cn/toolbox-app/)

### Alfred 4

> 效率工具，支持一些工作流和快速搜索等，需要购买

下载地址：[https://www.alfredapp.com/help/v4/](https://www.alfredapp.com/help/v4/)

常用workflow：

| workflow         | 功能             | 链接                                                                                                                       |
| ---------------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------- |
| Epoch Converter  | 时间戳工具       | [https://github.com/snooze92/alfred-epoch-converter](https://github.com/snooze92/alfred-epoch-converter)                   |
| ip               | 获取当前机器ip   | [https://github.com/freshcn/alfred_workflows](https://github.com/freshcn/alfred_workflows)                                 |
| 驼峰下划线互转   | 驼峰、下划线互转 | [https://github.com/freshcn/alfred_workflows](https://github.com/freshcn/alfred_workflows)                                 |
| CodeVar          | 变量命名         | [https://github.com/daniellauyu/pyCodevar?tab=readme-ov-file](https://github.com/daniellauyu/pyCodevar?tab=readme-ov-file) |
| Youdao Translate | 有道翻译         | [https://github.com/wensonsmith/YoudaoTranslator](https://github.com/wensonsmith/YoudaoTranslator)                         |
| Kill Process     | 杀死进程         | [https://github.com/ngreenstein/alfred-process-killer](https://github.com/ngreenstein/alfred-process-killer)               |

### Typora

> 编写markdown的利器，需要购买，也可以破解

这里基于sequoia 15.3系统的Mac M3机器进行破解：主要是修改Typora的配置文件，避免弹出未激活框，实际上还是只能打开一个页面，有条件还是建议购买

> https://blog.csdn.net/a79998/article/details/138564412

1. 找到并打开对应的配置文件

> 找配置文件的方式：在应用程序中右键->显示包内容，然后找一个文件夹右键->服务->New Iterm2

![img](https://i-blog.csdnimg.cn/blog_migrate/d5c4135e00d159d88de74c76a2e3936a.png)

``` bash
# 使用vscode打开文件
code /Applications/Typora.app/Contents/Resources/TypeMark/page-dist/static/js/LicenseIndex.180dd4c7.5b0f7af9.chunk.js
```

2. 文件中搜索e.hasActivated，并将 `e.hasActivated="true"==e.hasActivated` 改为 `e.hasActivated="true"=="true"`

> [!CAUTION]
>
> Mac可能没有权限修改该目录下的文件，可搜索 `关闭SIP`进行处理


---

> 作者: dovisliu  
> URL: http://localhost:1313/posts/mac_tools/  

