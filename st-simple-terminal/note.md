## SimpleTerminal使用

因为st(simple terminal)的相关patch能让这个终端支持ligature以及emoji功能并且运行所占用的内存要小于kitty和alacritty(不知道为什么，这两个第一个我不能输入emoji,第二个我不能使用ligarure特性)

这里直接是一份可以编译的源码，相关功能以及打过patch, 但是正常显示的前提是正确安装并配置config.h里面的字体, 下面是一个支持emoji的字体的安装shell脚本用于参考, 只要是那个local.conf比较重要

安装ttf-joypixels字体, 然后在 `/etc/fonts/` 下创建文件 `local.conf` 内容写入如下

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <alias>
        <family>sans-serif</family>
        <prefer>
            <family>JoyPixels</family>
            <family>DejaVu Sans</family>
        </prefer>
    </alias>
    <alias>
        <family>serif</family>
        <prefer>
            <family>JoyPixels</family>
            <family>DejaVu Serif</family>
        </prefer>
    </alias>
    <alias>
        <family>monospace</family>
        <prefer>
            <family>JoyPixels</family>
            <family>DejaVu Sans Mono</family>
        </prefer>
    </alias>
</fontconfig>

```

### 中文显示

中文显示的画需要安装中文字体, 这里就安装了`wqy-zenhei` 字体
我的仓库地址 https://github.com/niT-Tin/st
clone 下来之后装好相关字体配置好文件，直接make编译安装即可
