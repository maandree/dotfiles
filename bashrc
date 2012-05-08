# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#######################################################################################################
##  Include rules
#######################################################################################################

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features,
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

. /etc/bash_opt


#######################################################################################################
##  BASH History
#######################################################################################################

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


#######################################################################################################
##  Display style
#######################################################################################################

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# we want colours
force_color_prompt=yes
color_prompt=yes

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


#######################################################################################################
##  Illegal actions
#######################################################################################################

# inhibit starting an X session from another X session
if [ "$TERM" != "linux" ]; then
    alias startx="echo -e '\e[1;31mNever start an X session from within an X session!\e[0m'"
    alias xinit="echo -e '\e[1;31mNever start an X session from within an X session!\e[0m'"
fi


#######################################################################################################
##  Standard aliases
#######################################################################################################

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsh='ls -A'

alias ls='ls --color=always'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


#######################################################################################################
##  Linux VT colour palettes
#######################################################################################################

alias   linuxColours="echo -en '\e]P0000000\e]P1AA0000\e]P200AA00\e]P3AA5500\e]P40000AA\e]P5AA00AA\e]P600AAAA\e]P7AAAAAA\e]P8555555\e]P9FF5555\e]PA55FF55\e]PBFFFF55\e]PC5555FF\e]PDFF55FF\e]PE55FFFF\e]PFFFFFFF'"
alias   tangoColours="echo -en '\e]P02E3436\e]P1CC0000\e]P24E9A06\e]P3C4A000\e]P43465A4\e]P575507B\e]P606989A\e]P7D3D7CF\e]P8585858\e]P9FF5555\e]PA55FF55\e]PBFFFF55\e]PC5555FF\e]PDFF55FF\e]PE55FFFF\e]PFFFFFFF'"
alias tangoidColours="echo -en '\e]P0000000\e]P1CC0000\e]P24E9A06\e]P3C4A000\e]P43465A4\e]P575507B\e]P606989A\e]P7D3D7CF\e]P8585858\e]P9FF5555\e]PA55FF55\e]PBFFFF55\e]PC5555FF\e]PDFF55FF\e]PE55FFFF\e]PFFFFFFF'"
alias  cobaltColours="echo -en '\e]P0020840\e]P1CC0000\e]P24E9A06\e]P3C4A000\e]P43465A4\e]P575507B\e]P606989A\e]P7D3D7CF\e]P8585858\e]P9FF5555\e]PA55FF55\e]PBFFFF55\e]PC5555FF\e]PDFF55FF\e]PE55FFFF\e]PFFFFFFF'"
alias  yellowColours="echo -en '\e]P0303008\e]P1CC0000\e]P24E9A06\e]P3C4A000\e]P43465A4\e]P575507B\e]P606989A\e]P7D3D7CF\e]P8585858\e]P9FF5555\e]PA55FF55\e]PBFFFF55\e]PC5555FF\e]PDFF55FF\e]PE55FFFF\e]PFFFFFFF'"
alias    rootColours="echo -en '\e]P0300000\e]P1CD656C\e]P232A679\e]P3CCAD47\e]P42495BE\e]P5A46EB0\e]P600A09F\e]P7D3D7CF\e]P8555753\e]P9EB5E6A\e]PA0EC287\e]PBF2CA38\e]PC00ACE0\e]PDC473D1\e]PE00C3C7\e]PFEEEEEE'"
alias     ncsColours="echo -en '\e]P0020840\e]P1CD656C\e]P232A679\e]P3CCAD47\e]P42495BE\e]P5A46EB0\e]P600A09F\e]P7D3D7CF\e]P8555753\e]P9EB5E6A\e]PA0EC287\e]PBF2CA38\e]PC00ACE0\e]PDC473D1\e]PE00C3C7\e]PFEEEEEE'"
alias lightNcsColours="echo -en '\e]P00C1458\e]P1CD656C\e]P232A679\e]P3CCAD47\e]P42495BE\e]P5A46EB0\e]P600A09F\e]P7D3D7CF\e]P8555753\e]P9EB5E6A\e]PA0EC287\e]PBF2CA38\e]PC00ACE0\e]PDC473D1\e]PE00C3C7\e]PFEEEEEE'"



if [ "$USER" = 'root' ]; then
    alias stdColours="echo -en '\e]P0300000\e]P1CD656C\e]P232A679\e]P3CCAD47\e]P42495BE\e]P5A46EB0\e]P600A09F\e]P7D3D7CF\e]P8555753\e]P9EB5E6A\e]PA0EC287\e]PBF2CA38\e]PC00ACE0\e]PDC473D1\e]PE00C3C7\e]PFEEEEEE'"
else
    alias stdColours="echo -en '\e]P00C1458\e]P1CD656C\e]P232A679\e]P3CCAD47\e]P42495BE\e]P5A46EB0\e]P600A09F\e]P7D3D7CF\e]P8555753\e]P9EB5E6A\e]PA0EC287\e]PBF2CA38\e]PC00ACE0\e]PDC473D1\e]PE00C3C7\e]PFEEEEEE'"
fi

if [ "$TERM" = "linux" ]; then
    stdColours
fi


termpalette=

function palette-set
{
    termpalette=$@
}

function palette-reset
{
    echo -n $termpalette
}

palette-set `stdColours`



#######################################################################################################
##  Command prompt line
#######################################################################################################

termgit=1

function _____br__bashrc_
{
    echo -en "\e[32m$2\e[0m:"
}
function _____bra__bashrc_
{
    _____br__bashrc_ `git status -b -s 2>/dev/null`
}
function _____bran__bashrc_
{
    if [[ $termgit = 1 ]]; then
	git status -b -s 2>/dev/null >&2 && _____bra__bashrc_
	git status -b -s 2>/dev/null >&2 || echo -n ''
    else
	echo -n ''
    fi
}

function git-on
{
    termgit=1
}
function git-off
{
    termgit=0
}

termclock=0

function ____clock__bashrc_
{
    if [[ $termclock = 1 ]]; then
	echo -en " \e[33m($(date +%H:%M:%S))\e[0m"
    fi
}

function clock
{
    if [[ "$1" = "on" ]]; then
	clock-on
    else
	clock-off
    fi
}
function clock-on
{
    termclock=1
}
function clock-off
{
    termclock=0
}

termdir=1

function dir-on
{
    termdir=1
    _____dir__update__bashrc_
    ____window__update__bashrc_
}
function dir-off
{
    termdir=0
    _____dir__update__bashrc_
    ____window__update__bashrc_
}

termdual=0

function ___d_brc_
{
    if [[ $termdual = 1 ]]; then
	echo '\n'
    fi
}

function dual-on
{
    termdual=1
    _____dir__update__bashrc_
    ____window__update__bashrc_
}
function dual-off
{
    termdual=0
    _____dir__update__bashrc_
    ____window__update__bashrc_
}


function _____dir__update__bashrc_
{
if [ "$USER" = 'root' ]; then
  if [ "$TERM" = "linux" ]; then
    if [[ $termdir = 1 ]]; then
      PS1='\[\033[0;34;1m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]\w$(____clock__bashrc_)'`___d_brc_`'\[\033[0;31m\]'
    else
      PS1='\[\033[0;34;1m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]...$(____clock__bashrc_)'`___d_brc_`'\[\033[0;31m\]'
    fi
  else
    if [[ $termdir = 1 ]]; then
      PS1='\[\033[0;34m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]\w$(____clock__bashrc_)'`___d_brc_`'\[\033[0;31m\]'
    else
      PS1='\[\033[0;34m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]...$(____clock__bashrc_)'`___d_brc_`'\[\033[0;31m\]'
    fi
  fi
elif [ "$USER" = 'nobody' ]; then
  if [ "$TERM" = "linux" ]; then
    if [[ $termdir = 1 ]]; then
      PS1='\[\033[0;34;1m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]\w$(____clock__bashrc_)'`___d_brc_`'\[\033[0;32m\]'
    else
      PS1='\[\033[0;34;1m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]...$(____clock__bashrc_)'`___d_brc_`'\[\033[0;32m\]'
    fi
  else
    if [[ $termdir = 1 ]]; then
      PS1='\[\033[0;34m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]\w$(____clock__bashrc_)'`___d_brc_`'\[\033[0;32m\]'
    else
      PS1='\[\033[0;34m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]...$(____clock__bashrc_)'`___d_brc_`'\[\033[0;32m\]'
    fi
  fi
else
  if [ "$TERM" = "linux" ]; then
    if [[ $termdir = 1 ]]; then
      PS1='\[\033[0;34;1m\]\u\[\033[m\]@\[\033[34m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]\w$(____clock__bashrc_)'`___d_brc_`'\[\033[34;1m\]'
    else
      PS1='\[\033[0;34;1m\]\u\[\033[m\]@\[\033[34m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]...$(____clock__bashrc_)'`___d_brc_`'\[\033[34;1m\]'
    fi
  else
    if [[ $termdir = 1 ]]; then
      PS1='\[\033[0;34m\]\u\[\033[m\]@\[\033[34m\]\h\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]\w$(____clock__bashrc_)'`___d_brc_`'\[\033[34;1m\]'
    else
      PS1='\[\033[0;34m\]\u\[\033[m\]@\[\033[34m\]\h\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]...$(____clock__bashrc_)'`___d_brc_`'\[\033[34;1m\]'
    fi
  fi
fi

PS1="$PS1\$\[\033[0m\] "
}

_____dir__update__bashrc_


#######################################################################################################
##  Windows terminals
#######################################################################################################

function ____window__update__bashrc_
{
case "$TERM" in
    xterm*|rxvt*)
	PS1="\[\e]0;\u@\h: \w  ||  `tty`\a\]$PS1"
	;;
    *)
	;;
esac
}

____window__update__bashrc_

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


#######################################################################################################
##  Release unification and bug and functionallity workarounds
#######################################################################################################

#Release unification and bug workaround for VLC
if [ "$TERM" = "linux" ]; then
     function nvlc()
     {
	 /usr/bin/nvlc --no-video "$@"
	 palette-reset
     }
else
    alias nvlc="nvlc --no-video"
fi

alias mplayer="mplayer -softvol -msgcolor"
alias nplayer="mplayer -softvol -novideo"

if [ "$TERM" = "linux" ]; then
    function ponysay
    {
	exec ponysay $@
	palette-reset
    }
    function unisay
    {
	exec unisay $@
	palette-reset
    }
fi


#######################################################################################################
##  Handy commands
#######################################################################################################

# ls piped to less with colours
function lss
{
    ls --color=yes "$@" | less -r
}

# cat with invisible output for password masking
function blackcat
{
    echo -en '\e[0;30;40m'
    cat "$@"
    echo -en '\e[0m'
}

# emacs fitted for terminals (actually, no effect in Linux VT)
if [ "$TERM" = "linux" ]; then
    function nemacs
    {
	emacs -nw "$@"
    }
else
    function nemacs
    {
	echo -en '\e]0;emacs: '"$1"'\a'
	emacs -nw "$@"
	echo -en '\e]0;\u@\h: \w  ||  `tty`\a'
    }
fi

function mkcd
{
    mkdir "$@"
    cd "$1"
}

alias etty='echo -en "\ec"'

alias dt="date +%Y-\(%m\)%b-%d\ %T,\ %a\ w%W/%V,\ %Z"

alias battery="acpi -V"

alias term="echo -en '\ec'; acpi; echo -en '\e[0;'$(echo `tput cols` - 7 | bc)'H'; date +%H:%M:%S"

alias suu="su || su || su #"

function zu
{
    su "$@" || zu "$@"
}

alias pac-lis="sudo pacman -Qi | grep Licences | tsort 2> /dev/null | distinct : Licenses | sort"

alias rebash="source ~/.bashrc"

alias edbash="emacs -nw ~/.bashrc"

alias i0="sudo init 0"

alias lesser="less -r"

alias VIRTUALBOX="sudo modprobe vboxdrv"


swd="${HOME}"
function swd
{
    swd=`pwd`
}
function rwd
{
    cd $swd
}


#######################################################################################################
##  Git commands
#######################################################################################################

alias gitpu="git push -u origin"

alias gitpush="git push -u origin master"

alias gitpushgh="git push -u origin gh-pages"

alias gitpushdv="git push -u origin develop"

alias gitcom="git commit -m"


#######################################################################################################
##  Package management
#######################################################################################################

alias Pacman="sudo yaourt"

alias aur="sudo yaourt --aur"

alias pacman="sudo pacman"


#######################################################################################################
##  Daemons
#######################################################################################################

alias start-gpm='sudo gpm -m /dev/input/mice -t imps2'

alias stop-gpm='sudo gpm -k'

alias restart-network='sudo /etc/rc.d/network restart'


#######################################################################################################
##  File maniplution
#######################################################################################################

alias pdfconcat='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=concatenated.pdf'

alias pdfcat='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=cat.pdf'


#######################################################################################################
##  Just for fun
#######################################################################################################

alias blue="echo -e "\""print('\ec\e[0;44m', end='');\ni = 0;\nwhile(i < $(tput cols)):\n x = hex(int(float(i / $(tput cols)) ** 1.88 * 255)).replace('x', '0');\n x = x[len(x) - 2 : ];\n print('\e]P40000' + x, end=' ');\n i += 1;\nprint(' \b\e[0m\e]P4365A4', end='');"\"" | python; palette-reset"

function dog
{
    if [[ "$1" = '--' ]]; then
	cat -- "$2"
    elif [[ "$1" = '--help' ]]; then
	echo "dog is not cat"
    else
	cat -- "$1"
    fi
}


#######################################################################################################
##  main()
#######################################################################################################

export LOCALE="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"

etty
#term
dt
if [ "$TERM" = "linux" ]; then
    fortune | unisay -p linux-vt -P
else
    fortune | unisay -p unicode -P
fi

export EDITOR="emacs -nw"


#######################################################################################################
##  Runlevels
#######################################################################################################

alias boot-re='shutdown -f now'

#### THESE SHOULD BE UPDATED!

alias boot-linux='rm /etc/inittab ; cat /etc/inittab.linux > /etc/inittab ; rm /etc/rc.conf ; cat /etc/rc.conf.linux > /etc/rc.conf ; echo -e "\nLinux VT while agetty in all tty:s will start at next reboot\nType \e[31mboot-mate\e[0m to reset.\n"'

alias boot-mate='rm /etc/inittab ; cat /etc/inittab.mate > /etc/inittab ; rm /etc/rc.conf ; cat /etc/rc.conf.mate > /etc/rc.conf ; echo -e "\nMATE will be start at next reboot, 20 agettys will be openned in Linux VT.\nThis is default mode, type \e[32mboot-linux\e[0m for Linux VT with agettys in all tty:s.\n"'

alias boot-x='rm /etc/inittab ; cat /etc/inittab.x > /etc/inittab ; rm /etc/rc.conf ; cat /etc/rc.conf.x > /etc/rc.conf ; echo -e "\nLinux VT will be start at next reboot, 20 agettys will be openned in Linux VT.\nType \e[32mboot-linux\e[0m for Linux VT with agettys in all tty:s.\n"'


#######################################################################################################
##  Filesystem mounting
#######################################################################################################

alias open-Secondary="cryptsetup luksOpen /dev/sda3 Secondary; mount /dev/mapper/Secondary /media/Secondary"
alias open-Extension0="cryptsetup luksOpen /dev/sdd1 Extension0; mount /dev/mapper/Extension0 /media/Extension0"
alias open-Extension1="cryptsetup luksOpen /dev/sdc1 Extension1; mount /dev/mapper/Extension1 /media/Extension1"
alias open-Extension2="cryptsetup luksOpen /dev/sdb1 Extension2; mount /dev/mapper/Extension2 /media/Extension2"
alias open-Extension3="cryptsetup luksOpen /dev/sde1 Extension3; mount /dev/mapper/Extension3 /media/Extension3"

function open-ALL
{
    open-Secondary
    open-Extension0
    open-Extension1
    open-Extension2
    open-Extension3
}


#######################################################################################################
##  Space for echoed program invocations
#######################################################################################################

alias s="less ~/Desktop/maandree.schema"

alias sshcsc="ssh -XC maandree@u-shell.csc.kth.se"
alias sshcsc-u="ssh -XC maandree@u-shell.csc.kth.se"
alias sshcsc-s="ssh -XC maandree@s-shell.csc.kth.se"

alias gitpushme="git push -u origin maandree"
alias cdgit="cd ~/git"
