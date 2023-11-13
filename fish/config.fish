## Set values
# Hide welcome message

set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set LSP_USE_PLISTS true
set SHELL /bin/fish
set C_INCLUDE_PATH /opt/cuda/include
set CPLUS_INCLUDE_PATH /opt/cuda/include
set ANDROID_HOME /home/liuzehao/Android
set -gx PATH $ANDROID_HOME $PATH
set ANDROID_SDK_ROOT $ANDROID_HOME/Sdk
set -gx PATH $ANDROID_SDK_ROOT $PATH
set -gx PATH $ANDROID_SDK_ROOT/emulator $PATH
set -gx PATH $ANDROID_SDK_ROOT/platform-tools $PATH
# set -gx KITTY_LISTEN_ON yes

# set EDITOR "vim"

# set CUDA_HOME /opt/cuda
# set -gx /opt/cuda/bin

## Export variable need for qt-theme
if type "qtile" >> /dev/null 2>&1
   set -x QT_QPA_PLATFORMTHEME "qt5ct"
end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low


## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end


## Starship prompt
if status --is-interactive
   source ("/usr/bin/starship" init fish --print-full-init | psub)
end


## Advanced command-not-found hook
source /usr/share/doc/find-the-command/ftc.fish


## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end


## Run fastfetch if session is interactive
# if status --is-interactive && type -q fastfetch
#    fastfetch --load-config neofetch
# end

# if status --is-interactive && type -q neofetch
#    neofetch --ascii_distro lfs
# end

#if status --is-interactive && type -q neofetch
#  neofetch --jp2a ~/.config/neofetch/image/nittin_head.png --colors  4 2 2 4 7 6
#end

# if status --is-interactive && type -q neofetch
#   play ~/Audio/kunkun.wav -q &
# end

if status --is-interactive
  /home/liuzehao/.local/bin/pfetch
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /home/liuzehao/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

