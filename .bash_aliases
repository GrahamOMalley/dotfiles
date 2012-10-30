if [ "$TERM" != "dumb" ]; then
	alias l='ls --color=auto -F'
	alias ls='ls --color=auto -F'
	alias dir='ls --color=auto --format=vertical'
	alias vdir='ls --color=auto --format=long'
fi

alias ll='ls -lhF'
alias lll='ls --color=always -lasth | less -R'
alias tree='tree --charset=ASCII'
alias vim='vim -p'
alias ccat='pygmentize'

alias fixscreen='TERM=xterm'
alias conkystart='conky -d && conky -c ~/.net_conkyrc -d'

# use like sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias dfh='df -h --total | grep -v none'
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G T)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias sbrecent='grep -h "Added torrent" $HOME/log/spiderbro/*.log | sed -e "s/&tr.*$//g" | sed -e "s/magnet.*dn=//g"'

# git
alias gp='git push'
alias gb='git branch'
alias gc='git checkout'
alias gm='git commit -m'
alias gma='git commit -am'
alias gd='git diff'
alias gs='git status'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gl='git log'
alias ga='git add'
alias gcl='git clone'

alias ja2ucstart='killall docky; metacity --replace &; wine /home/gom/JA2UC113/ja2.exe'
alias c3start='sudo mount /media/oneTB/games/pc/CAESARIII/Caesar3.iso /media/iso/ -t iso9660 -o loop'
alias change_to_wine_compat_mode='killall docky; metacity --replace &'
alias change_to_good_graphics_mode='docky &; compiz --replace &'

# ettercap command to replace all images in a browser with something (tubgirl...)
alias wreck_your_buzz='sudo ettercap -i eth1 -T -q -F ~/tools/dos.ef -M ARP /192.168.1.5/ //'

alias f='find . -name'
alias tmux='tmux -2'
