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
export PATH=$PATH:~/bin

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
    PS1="\[$LightBlue\033(0\154\033(B\][\[\033(0\161\161\033(B$LightBlue\][\[$White\]\u\[$LightBlue\]@\[$White\]\h\[$LightBlue\]]\[\033(0\161\033(B\][\[$White\]\w\[$LightBlue\]]\[\033(0\161\033(B\][\[$White\]\t\[$LightBlue\]]\[\033(0\161\161\033(B\]]\n\[$LightBlue\033(0\155\161\033(B$LightBlue\][\[$White\]\s\[$LightBlue\]]\[\033(0\161\033(B\][\[$White\]\$\[$LightBlue\]]\[\033(0\161\161\033(B\][\[$NC\] "
    PS2="> "
}
function prompt2
{
    PS1='${debian_chroot:+($debian_chroot)}\[\033[00;37m\]\u\[\033[00;32m\]@\[\033[00;37m\]\h\[\033[00m\]:\[\033[00;32m\]\w\[\033[00;37m\]>\[\033[00m\] '
}
function prompt
{
    PS1="\[$(tput setaf 7)\]\u\[$(tput setaf 6)\]@\[$(tput setaf 7)\]\h:\[$(tput setaf 6)\]\w\[$(tput setaf 7)\]>\[$(tput sgr0)\]"
}
prompt

# this turns on aggressive history - ALL shells will write to the same history file
export PROMPT_COMMAND='history -a; history -r'

# this turns on dos-like tab completion (where it will just select anything it can find instead of you having to type the first letter, I like this)
# bind '"\C-i": menu-complete'

# env
# TODO: kill this if it breaks anything
export DISPLAY=:0.0
LS_COLORS='rs=0:di=01;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;37:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS
export LESS=-R
export GREP_COLORS="mc=01;36:ms=01;36:mt=01;36:fn=01;37:se=01;36"
# set path for Clang when using latest (not from repos)
export PATH=/usr/clang_3_3/bin:$PATH
# set clang as default compiler
#export CC=clang 
#export CXX=clang++ 
# set some variables for specific paths on goms main linux box
export vid='/media/nasGom/video/'
export mov='/media/nasGom/video/movies/'
export tv='/media/nasGom/video/tv/'
export music='/media/nasGom/music/'
export log='~/log/spiderbro/'
hostname | figlet
