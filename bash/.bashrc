# alias ls="exa -al --color=always --group-directories-first --icons" # preferred listing
# alias ls="lsd -l" # preferred listing
alias l="/home/liuzehao/.local/bin/lvim"
alias l="/usr/local/bin/nvim"
alias cat='bat --style header --style snip --style changes --style header'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MOZ_ENABLE_WAYLAND=1
. "$HOME/.cargo/env"
source "$HOME"/scripts/completions/lsd/bash/lsd
# 自定义ls命令
function ls() {
  # 匹配以.开头的隐藏文件
  files=(.[!.]*)
  # 匹配正常文件
  files+=(*)
  if [[ ${#files[@]} -gt $LINES ]]; then
    lsd -l "$@"
  else
    lsd --almost-all -l "$@"
  fi
}

function cd() {
  clear
  # 使用command调用内建命令cd(如果直接调用，会因为cd重名而形成无限递归)
  command cd "$@"
  ls .
}

eval "$($HOME/.cargo/bin/starship init bash)"
