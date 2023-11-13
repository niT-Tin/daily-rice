# FFmpeg于Ubuntu20.04.4上的安装记录

## 提示
首先要明确一点，如果你是 ***将Windows作为日常使用操作系统或者即使是将Linux作为日常使用操作系统但是安装软件基本只会用包管理工具来安装软件*** 的用户，那么首先得改掉以前习惯的鼠标点点，或者apt，pacman，yum等简单的安装软件的思路想法。从源码安装，相当于把别人写好的代码编译之后安装，所以需要你做更多(基本就是敲更多的命令)来保证代码能够被正确编译并且被安装。虽然很大一部分都会有相应的脚本来完成，但是安装体验上对于不熟悉的人来说是十分糟糕的。所以一开始就得摒弃类似于Windows上简单的安装思维。

要适应从源码安装，就得经得起 **折腾** ,要敢于去 **折腾**, 时间一久，这些知识就会成为常识，也是一份宝贵的经验，**耐心** 是十分关键的。(无论是关于安装还是阅读安装文档 :-) )

## 依赖安装 

```bash
sudo apt install gcc g++ make cmake automake \ 
                          gdb nasm yasm wget \ 
                          libsdl2-dev git libasound2-dev
```
* 注意：`libsdl2-dev` 和 `libasound2-dev` 用于对sdl以及alsa的支持(ffplay用得到)(可以查看ffmpeg官方文档)
---
ffmpeg安装自己配置需要的功能，每个模块(库)都需要自己编译安装,这次安装的库有
`fdk-aac`, `sdl2`, `x264`,`yasm`,`nasm`,`lame`

## 库安装
***fdk-aac***
```bash
wget https://jaist.dl.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-0.1.6.tar.gz
tar xvf fdk-aac-0.1.6.tar.gz
cd fdk-aac-0.1.6
./configure
make && sudo make install
```
---
***sdl2***
```bash
wget https://www.libsdl.org/release/SDL2-2.0.22.tar.gz
tar -xvf SDL2-2.0.22.tar.gz
cd SDL2-2.0.22
./configure --enable-video-x11 --enable-x11-shared --enable-video-x11-vm
make
sudo make install
```
---
***x264***
```bash
wget https://code.videolan.org/videolan/x264/-/archive/master/x264-master.tar.bz2
tar -xvf x264-master.tar.bz2
cd x264-master
./configure --enable-static --enable-shared --disable-asm --disable-avs
make && sudo make install
```
---
***yasm***
```bash
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar zxvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
make && sudo make install
```
---
***nasm***
```bash
wget https://www.nasm.us/pub/nasm/releasebuilds/2.13.03/nasm-2.13.03.tar.gz
tar xvf nasm-2.13.03.tar.gz
cd nasm-2.13.03
./configure
make && sudo make install
```
---
***lame***
```bash
wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar -xzf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure
make && sudo make install
```
---
**ffmpeg 源码下载并编译安装**
```bash
wget https://ffmpeg.org/releases/ffmpeg-4.1.9.tar.xz
tar -xvf ffmpeg-4.1.9.tar.xz
cd ffmpeg-4.1.9
./configure --prefix=/usr/local/ffmpeg \ 
            --enable-gpl \
            --enable-small \
            --arch=x86_64 \
            --enable-nonfree \
            --enable-libfdk-aac \
            --enable-libx264 \
            --enable-filter=delogo \ 
            --enable-debug \ 
            --disable-optimizations \
            --enable-shared \
            --enable-yasm \
            --enable-avfilter

make -j4
sudo make install
```
---
**安装之后的配置**
* 配置环境变量
```bash
# 因为本人使用的是zsh所以写入$HOME目录下的.zshrc文件，bash则为同目录下的.bashrc
vim ~/.zshrc
# 按i进入输入模式
export PATH=/usr/local/ffmpeg/bin:$PATH
# 按esc，输入:wq 保存退出
```
* 相关链接配置(Ubuntu20.04)
```bash
sudo vim /etc/ld.so.conf
# 查看include 后包含了哪些文件,下面是我的文件内显示情况
include /etc/ld.so.conf.d/*.conf
# 也就是说在目录/etc/ld.so.conf下的后缀为.conf的文件都会被查看
# 所以在该目录下添加ffmpeg需要的后缀为.conf文件即可
cd /etc/ld.so.conf.d/
vim ffmpeg.conf
# 按i进入输入模式
# 在文件内添加下面内容
/usr/local/ffmpeg/lib
# 按esc，输入:wq 保存退出
sudo ldconfig
```
---
* 在安装过程中可能会遇见很多意想不到的问题，不能全部列举出来，在自己遇到问题的时候，要沉住气，利用搜索引擎，以及根据别人的回答来思考自己的问题，思考问题出在哪里,再根据实际情况做出相应的调整并在解决之后记录下来,再次遇到时也能很快解决，不至于每一步都去google，也能帮助他人。
---
此时如果没有问题的话，安装也就全部完成了，已经编译出的二进制文件中有 `ffmpeg` , `ffplay`, `ffprobe`
