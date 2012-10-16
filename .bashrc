:
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
#export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

GREEN="\[\033[00;32m\]"
#MY CUSTOM COLOUR PROMPT: user(GREEN)@host:(GREEN)dir$
# Comment in the above and uncomment this below for a color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[00;37m\]\u\[\033[00;32m\]@\[\033[00;37m\]\h\[\033[00m\]:\[\033[00;32m\]\w\[\033[00;37m\]\$\[\033[00m\] '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#make history a lot bigger
export HISTSIZE=50000

#add ~/bin to my $PATH
#export PATH=$PATH:~/bin:~/eclipse/android-sdk-linux_x86-1.5_r3/tools
export PATH=$PATH:~/bin:~/code/android-sdk-linux/tools

cat ~/.welcome_message

#disable audible or visual bell
set bell-style none

function promptBig
{
    Black="\e[30m"
    Red="\e[31m"
    Green="\e[32m"
    White="\e[00;37m"
    Blue="\e[34m"
    LightBlue="\e[34;1m"
    NC="\e[0m" # No Color
    PS1="\[$Green\033(0\154\033(B\][\[\033(0\161\161\033(B$Green\][\[$White\]\u\[$Green\]@\[$White\]\h\[$Green\]]\[\033(0\161\033(B\][\[$White\]\w\[$Green\]]\[\033(0\161\033(B\][\[$White\]\t\[$Green\]]\[\033(0\161\161\033(B\]]\n\[$Green\033(0\155\161\033(B$Green\][\[$White\]\s\[$Green\]]\[\033(0\161\033(B\][\[$White\]\$\[$Green\]]\[\033(0\161\161\033(B\][\[$NC\] "
    PS2="> "
}
function prompt
{
PS1='${debian_chroot:+($debian_chroot)}\[\033[00;37m\]\u\[\033[00;32m\]@\[\033[00;37m\]\h\[\033[00m\]:\[\033[00;32m\]\w\[\033[00;37m\]>\[\033[00m\] '
}
prompt

# this turns on aggressive history - ALL shells will write to the same history file
export PROMPT_COMMAND='history -a; history -r'

# this turns on dos-like tab completion (where it will just select anything it can find instead of you having to type the first letter, I like this)
# bind '"\C-i": menu-complete'

# env
# TODO: kill this if it breaks anything
export DISPLAY=:0.0

# set some variables for specific paths on goms main linux box
export vid='/media/oneTB/videos/'
export mov='/media/oneTB/videos/movies/'
export tv='/media/twoTB1/videos/tv/'
export tv2='/media/tv2/'
export anime='/media/twoTB1/videos/anime/'
export music='/media/oneTB/music/'
export XBMC_ANDROID_NDK='/home/gom/code/android-ndk-r7-crystax-5.beta2'
export XBMC_ANDROID_SDK='/home/gom/code/android-sdk-linux'
export XBMC_ANDROID_TARBALLS='/home/gom/code'
hostname | figlet
