# Java8 Home
# set JAVA_HOME /home/liuzehao/applications/jdks/jdk1.8.0_341

# Java11 Home
# set JAVA_HOME /home/liuzehao/applications/jdks/jdk-11.0.16.1

# Java17 Home
set JAVA_HOME /home/liuzehao/applications/jdks/jdk-17.0.4.1
set -gx PATH $PATH $JAVA_HOME/bin

# alias
alias n=nvim
alias l=/home/liuzehao/.local/bin/lvim

set -gx DISPLAY :0.0

if status is-interactive
    # Commands to run in interactive sessions can go here
end
#if status --is-login
#    startx
#end
#startx
# ~/.config/fish/config.fish
# You must call it on initialization or listening to directory switching won't work
load_nvm > /dev/stderr
starship init fish | source
