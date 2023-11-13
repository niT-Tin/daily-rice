## ranger(终端文件浏览器配置文件)
终端预览图片需要安装w3m
需要图标，安装对应图标插件(ranger_devicons)
将 `scope.sh` 添加执行权限之后放在 `~/.config/ranger/` 目录下。默认预览视频是展示相关信息，这里可以安装ffmpeg或者ffmpegthumnailer(这里起作用的实际是后者)对视频取一帧作为视频预览，这里直接将scope.sh脚本里handle_image函数里的case的video分支解开就行。
