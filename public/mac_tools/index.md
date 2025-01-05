# Mac常用工具


程序员Mac环境配置和常用效率工具整理
<!--more-->

## 基础环境配置
{{< admonition type=note >}}
**建议优先安装并配置好iterm终端工具，再进行环境配置**
{{< /admonition >}}
### brew安装
> Homebrew（brew）是一种管理和安装各种软件包的方便的解决方案。

在安装 Homebrew 之前，需要先安装 Xcode 命令行工具。这个工具包含了 Homebrew 所需的编译器和其他工具。

打开终端（Terminal），然后运行以下命令，按照提示安装即可：
``` bash
xcode-select --install
```
Xcode 命令行工具安装完成后，继续安装 Homebrew。打开终端，执行以下命令：
``` bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
安装完成、配置好环境变量后，可以通过运行`brew --version`来验证是否安装成功

### git

以下是在Mac上配置GitHub SSH Key的详细步骤：

1. 检查是否已经安装SSH
在终端中输入以下命令，检查是否已经安装了SSH：
```bash
ssh -T git@github.com
```
如果出现 `Permission denied (publickey).` 或类似的信息，说明已经安装了SSH，但可能没有配置正确的密钥；如果出现 `command not found` 信息，说明没有安装SSH，需要先安装。

2. 生成新的SSH Key
如果需要生成新的SSH Key，可以使用以下命令：
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
- `t rsa` 表示使用RSA算法生成密钥。
- `b 4096` 表示密钥长度为4096位，这样会更安全。
- `C "your_email@example.com"` 用于给密钥添加注释，通常使用你的电子邮件地址，以便你能记住该密钥的用途。

在运行上述命令后，会提示你输入文件保存位置，一般默认的位置是 `~/.ssh/id_rsa` ，你可以直接按回车键使用默认位置；然后会提示输入密码，这个密码是用来保护你的私钥的，可以输入一个密码，也可以直接按回车键留空（不建议留空）。

3. 复制公钥到GitHub
你需要将生成的公钥添加到GitHub账户中。首先，使用以下命令复制公钥：
```bash
pbcopy < ~/.ssh/id_rsa.pub
```

4. 测试连接
为了确保一切正常，你可以使用以下命令测试连接：
```bash
ssh -T git@github.com
```
如果配置成功，你会看到类似 `Hi username! You've successfully authenticated, but GitHub does not provide shell access.` 的信息。

### vim
新建.vimrc配置，配置如下：
``` vim
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
### hugo

### npm
由于 npm 是随同 Node.js 一起发布的，所以首先要安装 Node.js。
*方法一：使用官方安装包（推荐）*
- 访问 Node.js 官方网站（https://nodejs.org/）。
- 下载适合 Mac 系统的安装包（一般是.pkg 文件）。
- 双击下载的安装包，按照安装向导的提示进行操作。在安装过程中，会自动安装 Node.js 和 npm。
- 安装完成后，可以在终端中输入node -v来检查 Node.js 的版本，输入npm -v来检查 npm 的版本，以确认安装成功。
*方法二：使用 Homebrew（如果已经安装了 Homebrew）*
- Homebrew 是 Mac 上的包管理器。如果已经安装了 Homebrew，可以在终端中输入以下命令来安装 Node.js：

```bash
brew install node
```

安装完成后，同样可以使用node -v和npm -v来检查版本。

## 常用工具

### iterm2安装和配置
1. 下载链接：https://iterm2.com/downloads.html
2. 安装 Oh-My-Zsh
> 官方地址：https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file

Oh-My-Zsh 是一个开源的、社区驱动的框架，用于管理 Zsh 的配置。它提供了大量的主题和插件，方便我们对 Zsh 进行定制。
在终端中运行以下命令来安装 Oh My Zsh：
``` bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 如果请求超时，则使用国内镜像
sh -c "$(curl -fsSL https://gitee.com/pocmon/ohmyzsh/raw/master/tools/install.sh)"
```
3. 下载zsh主题，这里以powerlevel10k为例
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
打开.zshrc文件编辑，设置主题`ZSH_THEME="powerlevel10k/powerlevel10k"`

4. 下载字体
> 一些主题需要特定的系统字体支持，比如p10k需要MesloLGS相关字体，通常终端启动时主题会提示下载字体，但是有可能出现网络超时的问题，这里提供一个手动下载的方法
- 前往 [Nerd Fonts 官方网站](https://www.nerdfonts.com/font-downloads) 下载 MesloLGS NF，随后下载就得到一系列的字体文件（通常是 .ttf 或 .otf 格式），选择 MesloLGS NF相关的
- 双击安装字体
- 在iterm中配置字体
  - 打开 iTerm2，点击 iTerm2 菜单中的 Preferences。
  - 在 Profiles 选项卡中，选择你正在使用的 Profile。
  - 点击 Text，在 Font 部分，从字体列表中选择 MesloLGS NF 字体。
5. 插件安装
``` bash
# 自动提示
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-syntax-highlighting 高亮
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# zsh-completions 额外自动补全
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```
下载完插件后，修改.zshrc文件启用插件`plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)`

### vscode安装和配置
1. 下载链接：https://code.visualstudio.com/Download
2. 设置`code`命令以便在终端中快速打开文件或文件夹
   - 打开 VS Code，通过快捷键 `Command + Shift + P` 调出命令面板。
   - 在命令面板中输入 “path”，找到 “Shell Command: Install 'code' command in PATH” 并执行该命令。
   - 这个操作会在你的系统中设置一个符号链接，使得在终端中可以使用code命令来启动 VS Code。
3. 安装常用插件
   - GitHub Copilot AI代码助手，通过github授权登录使用
   - Markdown All in One

### JetBrains Toolbox
> 管理各类语言编程IDE，如常见的IDEA、Goland等

下载地址：https://www.jetbrains.com.cn/toolbox-app/

### Alfred 4
> 效率工具，支持一些工作流和快速搜索等

下载地址：https://www.alfredapp.com/help/v4/
