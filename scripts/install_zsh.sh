#!/bin/bash
# 安装zsh
# 判断发行版
if [[ -n "$(type apt-get 2>/dev/null)" ]]; then
  sudo apt-get install zsh -y
elif [[ -n "$(type yum 2>/dev/null)"  ]]; then
  sudo yum install zsh -y
elif [[ -n "$(type pacman 2>/dev/null)" ]]; then
  sudo pacman -S zsh --noconfirm
else
  echo "Unknow os"
  exit 1
fi
# oh my zsh
# 这个一般要先在/etc/hosts里面添加raw.githubusercontent.com的ip地址
if [[ -d ~/.oh-my-zsh ]]; then
  rm -rf ~/.oh-my-zsh
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
while :; do
# zsh autosuggestion
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  if [ $? -eq 0 ]; then
    break
  fi
done

while :; do
  # fast-syntax-highlighting
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \\n  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
  if [ $? -eq 0 ]; then
    break
  fi
done

while :; do
  # autopair
  git clone https://github.com/hlissner/zsh-autopair ~/.zsh-autopair
  if [ $? -eq 0 ]; then
    break
  fi
done
# 将zsh-autosuggestions fast-syntax-highlighting添加到.zshrc的plugins中
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions fast-syntax-highlighting)/g' ~/.zshrc
# 将文本追加到.zshrc
echo "source ~/.zsh-autopair/autopair.zsh" >> ~/.zshrc
echo "autopair-init" >> ~/.zshrc
echo -e "zsh plugins:\n\033[33mzsh-autosuggestions\nzsh-autopair\nfast-syntax-highlighting\033[0m\n\033[32minstall success\!\! \033[0m"

echo "请重新启动zsh或者source ~/.zshrc"
