#!/bin/bash
wget https://jaist.dl.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-0.1.6.tar.gz
tar xvf fdk-aac-0.1.6.tar.gz
cd fdk-aac-0.1.6
./configure
make -j$(nproc) && sudo make install
if [ $? == 0 ]; then
	echo fdk-aac install completed
else
	echo fdk-aac install failed!!!
fi
cd ..

wget https://www.libsdl.org/release/SDL2-2.0.22.tar.gz
tar -xvf SDL2-2.0.22.tar.gz
cd SDL2-2.0.22
./configure --enable-video-x11 --enable-x11-shared --enable-video-x11-vm
make -j$(nproc)
sudo make install
if [ $? == 0 ]; then
	echo sdl2 install completed
else
	echo sdl2 install failed!!!
fi
cd ..

wget https://code.videolan.org/videolan/x264/-/archive/master/x264-master.tar.bz2
tar -xvf x264-master.tar.bz2
cd x264-master
./configure --enable-static --enable-shared --disable-asm --disable-avs
make -j$(nproc) && sudo make install
if [ $? == 0 ]; then
	echo x264 install completed
else
	echo x264 install failed!!!
fi
cd ..
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar zxvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
make -j$(nproc) && sudo make install
if [ $? == 0 ]; then
	echo yasm install completed
else
	echo yasm install failed!!!
fi
cd ..

wget https://www.nasm.us/pub/nasm/releasebuilds/2.13.03/nasm-2.13.03.tar.gz
tar xvf nasm-2.13.03.tar.gz
cd nasm-2.13.03
./configure
make -j$(nproc) && sudo make install
if [ $? == 0 ]; then
	echo nasm install completed
else
	echo nasm install failed!!!
fi
cd ..
wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar -xzf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure
make -j$(nproc) && sudo make install
if [ $? == 0 ]; then
	echo lame install completed
else
	echo lame install failed!!!
fi
cd ..
wget https://ffmpeg.org/releases/ffmpeg-4.1.9.tar.xz
tar -xvf ffmpeg-4.1.9.tar.xz
cd ffmpeg-4.1.9
./configure --prefix=/usr/local/ffmpeg --enable-gpl --enable-small --arch=x86_64 --enable-nonfree --enable-libfdk-aac --enable-libx264 --enable-filter=delogo --enable-debug --disable-optimizations --enable-shared --enable-yasm --enable-avfilter
make -j$(nproc)
sudo make install
if [ $? == 0 ]; then
	echo ffmpeg install completed
else
	echo ffmpeg install failed!!!
fi
cd ..
