# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export PATH=$(echo ~)"/.local/bin:"$PATH

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#################################################################################################
##  Include rules
#################################################################################################

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features,
function recomplete()
{
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
    fi
    if [ -f /usr/share/bash-completion/bash_completion ] && ! shopt -oq posix; then
	. /usr/share/bash-completion/bash_completion
    fi
    if [ -d ~/.local/bash_completion.d ] && ! shopt -oq posix; then
	rm ~/.local/bash_completion.d/*~ 2>/dev/null
	rm ~/.local/bash_completion.d/#*# 2>/dev/null
	completionscripts=( ~/.local/bash_completion.d/"*" )
	for completionscript in $completionscripts; do
	    . $completionscript
	done
    fi
    if [ -d /usr/share/bash-completion/completions ] && ! shopt -oq posix; then
	completionscripts=( /usr/share/bash-completion/completions/"*" )
	for completionscript in $completionscripts; do
	    . $completionscript
	done
    fi


    if [ -f /etc/bash_opt ]; then
	. /etc/bash_opt
    fi
}
recomplete


#################################################################################################
##  BASH History
#################################################################################################

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


#################################################################################################
##  Display style
#################################################################################################

## make less more friendly for non-text input files, see lesspipe(1)  ## bullshit
#[ -x /usr/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh /usr/bin/lesspipe.sh)"

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


#################################################################################################
##  Illegal actions
#################################################################################################

# inhibit starting an X session from another X session
if [ "$TERM" = "dumb" ]; then
    alias startx="echo -e '\e[1;31mDon not start an X session from a dumb terminal!\e[0m'"
    alias xinit="echo -e '\e[1;31mDon not start an X session from a dumb terminal!\e[0m'"
elif [ "$TERM" != "linux" ]; then
    alias startx="echo -e '\e[1;31mNever start an X session from within an X session!\e[0m'"
    alias xinit="echo -e '\e[1;31mNever start an X session from within an X session!\e[0m'"
fi


#################################################################################################
##  Standard aliases
#################################################################################################

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsh='ls -A'

alias ls='ls --color=always'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


#################################################################################################
##  xterm colour palettes
#################################################################################################

if [ "$TERM" = "xterm" ] || [ "$TERM" = "xterm-256color" ]; then
    alias   linuxColours='echo -en '\''\e]4;0;rgb:00/00/00\e\\\e]4;1;rgb:AA/00/00\e\\\e]4;2;rgb:00/AA/00\e\\\e]4;3;rgb:AA/55/00\e\\\e]4;4;rgb:00/00/AA\e\\\e]4;5;rgb:AA/00/AA\e\\\e]4;6;rgb:00/AA/AA\e\\\e]4;7;rgb:AA/AA/AA\e\\\e]4;8;rgb:55/55/55\e\\\e]4;9;rgb:FF/55/55\e\\\e]4;10;rgb:55/FF/55\e\\\e]4;11;rgb:FF/FF/55\e\\\e]4;12;rgb:55/55/FF\e\\\e]4;13;rgb:FF/55/FF\e\\\e]4;14;rgb:55/FF/FF\e\\\e]4;15;rgb:FF/FF/FF\e\\'\'
    alias   tangoColours='echo -en '\''\e]4;0;rgb:2E/34/36\e\\\e]4;1;rgb:CC/00/00\e\\\e]4;2;rgb:4E/9A/06\e\\\e]4;3;rgb:C4/A0/00\e\\\e]4;4;rgb:34/65/A4\e\\\e]4;5;rgb:75/50/7B\e\\\e]4;6;rgb:06/98/9A\e\\\e]4;7;rgb:D3/D7/CF\e\\\e]4;8;rgb:58/58/58\e\\\e]4;9;rgb:FF/55/55\e\\\e]4;10;rgb:55/FF/55\e\\\e]4;11;rgb:FF/FF/55\e\\\e]4;12;rgb:55/55/FF\e\\\e]4;13;rgb:FF/55/FF\e\\\e]4;14;rgb:55/FF/FF\e\\\e]4;15;rgb:FF/FF/FF\e\\'\'
    alias tangoidColours='echo -en '\''\e]4;0;rgb:00/00/00\e\\\e]4;1;rgb:CC/00/00\e\\\e]4;2;rgb:4E/9A/06\e\\\e]4;3;rgb:C4/A0/00\e\\\e]4;4;rgb:34/65/A4\e\\\e]4;5;rgb:75/50/7B\e\\\e]4;6;rgb:06/98/9A\e\\\e]4;7;rgb:D3/D7/CF\e\\\e]4;8;rgb:58/58/58\e\\\e]4;9;rgb:FF/55/55\e\\\e]4;10;rgb:55/FF/55\e\\\e]4;11;rgb:FF/FF/55\e\\\e]4;12;rgb:55/55/FF\e\\\e]4;13;rgb:FF/25/5FF\e\\\e]4;14;rgb:55/FF/FF\e\\\e]4;15;rgb:FF/FF/FF\e\\'\'
    alias  cobaltColours='echo -en '\''\e]4;0;rgb:02/08/40\e\\\e]4;1;rgb:CC/00/00\e\\\e]4;2;rgb:4E/9A/06\e\\\e]4;3;rgb:C4/A0/00\e\\\e]4;4;rgb:34/657A4\e\\\e]4;5;rgb:75/50/7B\e\\\e]4;6;rgb:06/98/9A\e\\\e]4;7;rgb:D3/D7/CF\e\\\e]4;8;rgb:58/58/58\e\\\e]4;9;rgb:FF/55/55\e\\\e]4;10;rgb:55/FF/55\e\\\e]4;11;rgb:FF/FF/55\e\\\e]4;12;rgb:55/55/FF\e\\\e]4;13;rgb:FF/55/FF\e\\\e]4;14;rgb:55/FF/FF\e\\\e]4;15;rgb:FF/FF/FF\e\\'\'
    alias  yellowColours='echo -en '\''\e]4;0;rgb:30/30/08\e\\\e]4;1;rgb:CC/00/00\e\\\e]4;2;rgb:4E/9A/06\e\\\e]4;3;rgb:C4/A0/00\e\\\e]4;4;rgb:34/65/A4\e\\\e]4;5;rgb:75/50/7B\e\\\e]4;6;rgb:06/98/9A\e\\\e]4;7;rgb:D3/D7/CF\e\\\e]4;8;rgb:58/58/58\e\\\e]4;9;rgb:FF/55/55\e\\\e]4;10;rgb:55/FF/55\e\\\e]4;11;rgb:FF/FF/55\e\\\e]4;12;rgb:55/55/FF\e\\\e]4;13;rgb:FF/55/FF\e\\\e]4;14;rgb:55/FF/FF\e\\\e]4;15;rgb:FF/FF/FF\e\\'\'
    alias    rootColours='echo -en '\''\e]4;0;rgb:30/00/00\e\\\e]4;1;rgb:CD/65/6C\e\\\e]4;2;rgb:32/A6/79\e\\\e]4;3;rgb:CC/AD/47\e\\\e]4;4;rgb:24/95/BE\e\\\e]4;5;rgb:A4/6E/B0\e\\\e]4;6;rgb:00/A0/9F\e\\\e]4;7;rgb:D3/D7/CF\e\\\e]4;8;rgb:55/57/53\e\\\e]4;9;rgb:EB/5E/6A\e\\\e]4;10;rgb:0E/C2/87\e\\\e]4;11;rgb:F2/CA/38\e\\\e]4;12;rgb:00/AC/E0\e\\\e]4;13;rgb:C4/73/D1\e\\\e]4;14;rgb:00/C3/C7\e\\\e]4;15;rgb:EE/EE/EE\e\\'\'
    alias     ncsColours='echo -en '\''\e]4;0;rgb:02/08/40\e\\\e]4;1;rgb:CD/65/6C\e\\\e]4;2;rgb:32/A6/79\e\\\e]4;3;rgb:CC/AD/47\e\\\e]4;4;rgb:24/95/BE\e\\\e]4;5;rgb:A4/6E/B0\e\\\e]4;6;rgb:00/A0/9F\e\\\e]4;7;rgb:D3/D7/CF\e\\\e]4;8;rgb:55/57/53\e\\\e]4;9;rgb:EB/5E76A\e\\\e]4;10;rgb:0E/C2/87\e\\\e]4;11;rgb:F2/CA/38\e\\\e]4;12;rgb:00/AC/E0\e\\\e]4;13;rgb:C4/73/D1\e\\\e]4;14;rgb:00/C3/C7\e\\\e]4;15;rgb:EE/EE/EE\e\\'\'
    alias lightNcsColours='echo -en '\''\e]4;0;rgb:0C/14/58\e\\\e]4;1;rgb:CD/65/6C\e\\\e]4;2;rgb:32/A6/79\e\\\e]4;3;rgb:CC/AD/47\e\\\e]4;4;rgb:24/95/BE\e\\\e]4;5;rgb:A4/6E/B0\e\\\e]4;6;rgb:00/A0/9F\e\\\e]4;7;rgb:D3/D7/CF\e\\\e]4;8;rgb:55/57/53\e\\\e]4;9;rgb:EB/5E/6A\e\\\e]4;10;rgb:0E/C2/87\e\\\e]4;11;rgb:F2/CA/38\e\\\e]4;12;rgb:00/AC/E0\e\\\e]4;13;rgb:C4/73/D1\e\\\e]4;14;rgb:00/C3/C7\e\\\e]4;15;rgb:EE/EE/EE\e\\'\'
    alias blackNcsColours='echo -en '\''\e]4;0;rgb:00/00/00\e\\\e]4;1;rgb:CD/65/6C\e\\\e]4;2;rgb:32/A6/79\e\\\e]4;3;rgb:CC/AD/47\e\\\e]4;4;rgb:24/95/BE\e\\\e]4;5;rgb:A4/6E/B0\e\\\e]4;6;rgb:00/A0/9F\e\\\e]4;7;rgb:D3/D7/CF\e\\\e]4;8;rgb:55/57/53\e\\\e]4;9;rgb:EB/5E/6A\e\\\e]4;10;rgb:0E/C2/87\e\\\e]4;11;rgb:F2/CA/38\e\\\e]4;12;rgb:00/AC/E0\e\\\e]4;13;rgb:C4/73/D1\e\\\e]4;14;rgb:00/C3/C7\e\\\e]4;15;rgb:EE/EE/EE\e\\'\'
    
    
    
    if [ "$USER" = 'root' ]; then
	alias stdColours="rootColours"
    else
	alias stdColours="lightNcsColours"
    fi
    
    if [ "$COLORTERM" = '' ]; then
	stdColours
    fi
    
    
    export termpalette=
    
    function palette-set
    {
	export termpalette=$@
    }
    
    function palette-reset
    {
	echo -n $termpalette
    }
    
    if [ "$COLORTERM" = '' ]; then
	palette-set `stdColours`
    fi
fi


#################################################################################################
##  Linux VT colour palettes
#################################################################################################

if [ "$TERM" = "linux" ]; then
    alias   linuxColours="echo -en '\e]P0000000\e]P1AA0000\e]P200AA00\e]P3AA5500\e]P40000AA\e]P5AA00AA\e]P600AAAA\e]P7AAAAAA\e]P8555555\e]P9FF5555\e]PA55FF55\e]PBFFFF55\e]PC5555FF\e]PDFF55FF\e]PE55FFFF\e]PFFFFFFF'"
    alias   tangoColours="echo -en '\e]P02E3436\e]P1CC0000\e]P24E9A06\e]P3C4A000\e]P43465A4\e]P575507B\e]P606989A\e]P7D3D7CF\e]P8585858\e]P9FF5555\e]PA55FF55\e]PBFFFF55\e]PC5555FF\e]PDFF55FF\e]PE55FFFF\e]PFFFFFFF'"
    alias tangoidColours="echo -en '\e]P0000000\e]P1CC0000\e]P24E9A06\e]P3C4A000\e]P43465A4\e]P575507B\e]P606989A\e]P7D3D7CF\e]P8585858\e]P9FF5555\e]PA55FF55\e]PBFFFF55\e]PC5555FF\e]PDFF55FF\e]PE55FFFF\e]PFFFFFFF'"
    alias  cobaltColours="echo -en '\e]P0020840\e]P1CC0000\e]P24E9A06\e]P3C4A000\e]P43465A4\e]P575507B\e]P606989A\e]P7D3D7CF\e]P8585858\e]P9FF5555\e]PA55FF55\e]PBFFFF55\e]PC5555FF\e]PDFF55FF\e]PE55FFFF\e]PFFFFFFF'"
    alias  yellowColours="echo -en '\e]P0303008\e]P1CC0000\e]P24E9A06\e]P3C4A000\e]P43465A4\e]P575507B\e]P606989A\e]P7D3D7CF\e]P8585858\e]P9FF5555\e]PA55FF55\e]PBFFFF55\e]PC5555FF\e]PDFF55FF\e]PE55FFFF\e]PFFFFFFF'"
    alias    rootColours="echo -en '\e]P0300000\e]P1CD656C\e]P232A679\e]P3CCAD47\e]P42495BE\e]P5A46EB0\e]P600A09F\e]P7D3D7CF\e]P8555753\e]P9EB5E6A\e]PA0EC287\e]PBF2CA38\e]PC00ACE0\e]PDC473D1\e]PE00C3C7\e]PFEEEEEE'"
    alias     ncsColours="echo -en '\e]P0020840\e]P1CD656C\e]P232A679\e]P3CCAD47\e]P42495BE\e]P5A46EB0\e]P600A09F\e]P7D3D7CF\e]P8555753\e]P9EB5E6A\e]PA0EC287\e]PBF2CA38\e]PC00ACE0\e]PDC473D1\e]PE00C3C7\e]PFEEEEEE'"
    alias lightNcsColours="echo -en '\e]P00C1458\e]P1CD656C\e]P232A679\e]P3CCAD47\e]P42495BE\e]P5A46EB0\e]P600A09F\e]P7D3D7CF\e]P8555753\e]P9EB5E6A\e]PA0EC287\e]PBF2CA38\e]PC00ACE0\e]PDC473D1\e]PE00C3C7\e]PFEEEEEE'"
    alias blackNcsColours="echo -en '\e]P0000000\e]P1CD656C\e]P232A679\e]P3CCAD47\e]P42495BE\e]P5A46EB0\e]P600A09F\e]P7D3D7CF\e]P8555753\e]P9EB5E6A\e]PA0EC287\e]PBF2CA38\e]PC00ACE0\e]PDC473D1\e]PE00C3C7\e]PFEEEEEE'"
    
    
    
    if [ "$USER" = 'root' ]; then
	alias stdColours=rootNcsColours
    else
	alias stdColours=lightNcsColours
    fi
    
    stdColours
    
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
fi



#################################################################################################
##  Command prompt line
#################################################################################################

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

termdual=1

function ___d_brc_
{
    if [[ $termdual = 1 ]]; then
	echo '\[\033[0m\033[C\033[D\]\n'
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
        PS1='\[\033[?8c\033[0;34;1m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]\w$(____clock__bashrc_)'`___d_brc_`'\[\033[0;31m\]'
      else
        PS1='\[\033[?8c\033[0;34;1m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]...$(____clock__bashrc_)'`___d_brc_`'\[\033[0;31m\]'
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
        PS1='\[\033[?8c\033[0;34;1m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]\w$(____clock__bashrc_)'`___d_brc_`'\[\033[0;32m\]'
      else
        PS1='\[\033[?8c\033[0;34;1m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]...$(____clock__bashrc_)'`___d_brc_`'\[\033[0;32m\]'
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
        PS1='\[\033[?8c\033[0;34;1m\]\u\[\033[m\]@\[\033[34m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]\w$(____clock__bashrc_)'`___d_brc_`'\[\033[34;1m\]'
      else
        PS1='\[\033[?8c\033[0;34;1m\]\u\[\033[m\]@\[\033[34m\]\h\[\033[0m\].\[\033[36m\]\l\[\033[0m\]:$(_____bran__bashrc_) \[\033[35m\]...$(____clock__bashrc_)'`___d_brc_`'\[\033[34;1m\]'
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


#################################################################################################
##  Windows terminals
#################################################################################################

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


#################################################################################################
##  Important exports
#################################################################################################

export LOCALE="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"

export EDITOR="emacs -nw"

export CVS_RSH="ssh"


#################################################################################################
##  Release unification and bug and functionallity workarounds
#################################################################################################

#Release unification and bug workaround for VLC
if [ "$TERM" = "linux" ]; then
    function nvlc1
    {
	(palette-reset; sleep 0.5; palette-reset; sleep 0.5; palette-reset) & 
	22:00 /usr/bin/nvlc --no-video "$@" || echo -n ''
    }
    function nvlc2
    {
	stty icanon echo icrnl -echoctl -ixoff ixon onlcr iutf8
	palette-reset
    }
    function nvlc
    {
	nvlc1 "$@"
	nvlc2
    }
else
    alias nvlc="22:00 nvlc --no-video"
fi

alias mplayer="mplayer -softvol -msgcolor"
alias nplayer="mplayer -softvol -novideo"

if [ "$TERM" = "linux" ]; then
    function ponysay_nopal
    {
	export PONYSAY_KMS_PALETTE=``
	export PONYSAY_KMS_PALETTE_CMD=``
	/usr/bin/ponysay "$@"
	palette-reset
    }
    function ponysay
    {
	export PONYSAY_KMS_PALETTE=`palette-reset`
	/usr/bin/ponysay "$@"
	palette-reset
    }
    function unisay
    {
	/usr/bin/unisay "$@"
	palette-reset
    }
fi


#################################################################################################
##  Handy commands
#################################################################################################

function unlock
{
    rm ~/."$1"/lock
}

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

# emacs fitted for terminals
if [ "$TERM" = "linux" ]; then
    xem=1
    function nemacs
    {
	if [ "$xem" = '1' ]; then
	    #echo -en '\e[?8c'
	    TERM='xterm'
	fi
	echo -en '\e[?8c'
	emacs -nw "$@"
	echo -en '\e[?8c'
	TERM='linux'
	#if [ "$xem" = '1' ]; then
	#    echo -en '\e[?0c'
	#fi
    }
else
    function nemacs
    {
	xhi=0
	if [ "$TERM" = 'xterm-256color' ]; then
	    xhi=1
	    TERM='xterm'
	fi
	echo -en '\e]0;emacs: '"$1"'\a'
	#if [ "$COLORTERM" = '' ] && [ "$TERM" = 'xterm' ]; then
	#    (sleep 0.5 ; palette-reset ) &
	#fi
	emacs -nw "$@"
	echo -en '\e]0;\u@\h: \w  ||  `tty`\a'
	if [ $xhi = 1 ]; then
	    TERM='xterm-256color'
	fi
    }
fi

function mkcd
{
    mkdir "$@"
    cd "$1"
}

if [ "$COLORTERM" = '' ]; then
    if [ "$TERM" = 'xterm' ] || [ "$TERM" = 'xterm-256color' ]; then
	alias etty='echo -en "\ec";palette-reset'
    else
	alias etty='echo -en "\ec"'
    fi
else
    alias etty='echo -en "\ec"'
fi

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

alias edbash="nemacs ~/.bashrc"

alias i0="sudo init 0"

alias lesser="less -r"

alias VIRTUALBOX="sudo modprobe vboxdrv"


swd="${HOME}"
swd2="${HOME}"
function swd
{
    swd="`pwd`"
}
function rwd
{
    cd "$swd"
}
function swd2
{
    swd2="`pwd`"
}
function rwd2
{
    cd "$swd2"
}

function todo
{
    for todo in $(echo xxx todo fixme); do
	grep -rinI --colour=always $todo | grep -v "$(echo -e '^\e\\[.*m\e\\[K\\.')"
    done
    [[ -f "./dev/TODO" ]] &&
	cat "./dev/TODO"
}

function purge
{
    rm *~  2>/dev/null
    rm .*~  2>/dev/null
    rm \#*\#  2>/dev/null
    rm .\#*  2>/dev/null
}

function purger
{
    rm $(find . 2>/dev/null | grep '~$')       2>/dev/null
    rm $(find . 2>/dev/null | egrep '/(.|)#')  2>/dev/null
}

function burstgif
{
    for image in "$@"; do
	convert -coalesce "$image" "$image".%d.gif
    done
}

function burstgif-rm
{
    for image in "$@"; do
	convert -coalesce "$image" "$image".%d.gif
	rm "$image"
    done
}

function touchall
{
    find "$@" | sed -e 's/'\''/'\''\\'\'\''/g' | sed -e 's/^/'\''/' -e 's/$/'\''/g' | xargs touch
}


#################################################################################################
##  Git commands
#################################################################################################

alias gitpu="git push -u origin"
alias gitcom="git commit -m"
alias gitlog="git log --graph --decorate"
alias gitlogg="git log --graph --decorate --full-history"

function _____gp___bashrc_
{
    echo "$2"
}
function _____gp__bashrc_
{
    _____gp___bashrc_ `git status -b -s 2>/dev/null`
}
function ___git_branch_
{
    echo `_____gp__bashrc_ | cut -d . -f 1`
}

function gitpush
{
    git push -u origin `___git_branch_`
}

function gemacs
{
    nemacs "$@"
    git add "$@"
}

function gitcheckout
{
    git checkout "$@"
    cd .
}

function gitpull
{
    __gb_=`___git_branch_`
    git checkout "$1"
    git pull
    git checkout $__gb_
    git pull . "$1"
}

function gitp
{
    __gb_=`___git_branch_`
    git pull
    git checkout "$1"
    git pull
    git pull . $__gb_
}

function gittag
{
    git tag -a "$@"
    git checkout "$1"
    git push -u origin "$1"
}

function gitupdate
{
    git fetch upstream
    git pull . upstream/`___git_branch_`
}


#################################################################################################
##  Package management
#################################################################################################

alias Pacman="sudo yaourt"

alias aur="sudo yaourt --aur"

alias pacman="sudo pacman-color"


#################################################################################################
##  Daemons
#################################################################################################

alias start-gpm='sudo gpm -m /dev/input/mice -t imps2'

alias stop-gpm='sudo gpm -k'

alias restart-network='sudo /etc/rc.d/network restart'


#################################################################################################
##  File maniplution
#################################################################################################

alias pdfconcat='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=concatenated.pdf'

alias pdfcat='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=cat.pdf'


#################################################################################################
##  Just for fun
#################################################################################################

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


#################################################################################################
##  main()
#################################################################################################

if [ "$TERM" = "dumb" ]; then
    dt
    clock on
else
    etty
    #term
    dt
    if [ "$TERM" = "linux" ]; then
	pinkie | unisay -p linux-vt -P
	echo -en '\e[?8c'
    else
	pinkie | unisay -p unicode -P
	if [[ ! -f "/dev/shm/.$DISPLAY" ]]; then
	    touch "/dev/shm/.$DISPLAY"
	    setxkbmap 2>/dev/null >/dev/null
	fi
    fi
    if [ "$TERM" = "xterm" ]; then
	#if [ "$COLORTERM" = "mate-terminal" ]; then
	    TERM=xterm-256color
	#fi
    fi
    if [ "$COLORTERM" = '' ]; then
	if [ "$TERM" = 'xterm' ] || [ "$TERM" = 'xterm-256color' ]; then
	    palette-reset
	fi
    fi
fi

export LS_COLORS=\
'rs=0:'\
'di=01;34:'\
'ln=01;36:'\
'mh=00:'\
'pi=42;30:'\
'so=42;37:'\
'do=01;37:'\
'bd=46;37:'\
'cd=46;30:'\
'or=01;31:'\
'su=30;44:'\
'sg=37;44:'\
'ca=01;30;41:'\
'tw=33:'\
'ow=32:'\
'st=31:'\
'ex=01;32:'\
\
'*.tar=34:*.tgz=34:*.arj=34:*.taz=34:*.lzh=34:*.lzma=34:*.tlz=34:*.txz=34:*.zip=34:*.z=34:*.Z=34:*.dz=34:*.gz=34:*.lz=34:*.xz=34:*.bz2=34:*.bz=34:'\
'*.tbz=34:*.tbz2=34:*.tz=34:*.deb=34:*.rpm=34:*.jar=34:*.war=34:*.ear=34:*.sar=34:*.rar=34:*.ace=34:*.zoo=34:*.cpio=34:*.7z=34:*.rz=34:'\
\
'*.jpg=35:*.jpeg=35:*.gif=35:*.bmp=35:*.pbm=35:*.pgm=35:*.ppm=35:*.tga=35:*.xbm=35:*.xpm=35:*.tif=35:*.tiff=35:*.png=35:*.svg=35:*.svgz=35:*.mng=35:'\
'*.pcx=35:*.mov=35:*.mpg=35:*.mpeg=35:*.m2v=35:*.mkv=35:*.webm=35:*.ogm=35:*.mp4=35:*.m4v=35:*.mp4v=35:*.vob=35:*.qt=35:*.nuv=35:*.wmv=35:*.asf=35:'\
'*.rm=35:*.rmvb=35:*.flc=35:*.avi=35:*.fli=35:*.flv=35:*.gl=35:*.dl=35:*.xcf=35:*.xwd=35:*.yuv=35:*.cgm=35:*.emf=35:*.axv=35:*.anx=35:*.ogv=35:*.ogx=35:'\
\
'*.aac=36:*.au=36:*.flac=36:*.m4a=36:*.mid=36:*.midi=36:*.mka=36:*.mp3=36:*.mpc=36:*.ogg=36:*.ra=36:*.wav=36:*.axa=36:*.oga=36:*.spx=36:*.xspf=36:'


#################################################################################################
##  Runlevels
#################################################################################################

alias boot-re='shutdown -f now'

#### THESE SHOULD BE UPDATED!

alias boot-linux='rm /etc/inittab ; cat /etc/inittab.linux > /etc/inittab ; rm /etc/rc.conf ; cat /etc/rc.conf.linux > /etc/rc.conf ; echo -e "\nLinux VT while agetty in all tty:s will start at next reboot\nType \e[31mboot-mate\e[0m to reset.\n"'

alias boot-mate='rm /etc/inittab ; cat /etc/inittab.mate > /etc/inittab ; rm /etc/rc.conf ; cat /etc/rc.conf.mate > /etc/rc.conf ; echo -e "\nMATE will be start at next reboot, 20 agettys will be openned in Linux VT.\nThis is default mode, type \e[32mboot-linux\e[0m for Linux VT with agettys in all tty:s.\n"'

alias boot-x='rm /etc/inittab ; cat /etc/inittab.x > /etc/inittab ; rm /etc/rc.conf ; cat /etc/rc.conf.x > /etc/rc.conf ; echo -e "\nLinux VT will be start at next reboot, 20 agettys will be openned in Linux VT.\nType \e[32mboot-linux\e[0m for Linux VT with agettys in all tty:s.\n"'


#################################################################################################
##  Filesystem mounting
#################################################################################################

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


#################################################################################################
##  Space for echoed program invocations
#################################################################################################

alias s="less ~/maandree.schema"

alias sshcsc="ssh -XC maandree@u-shell.csc.kth.se"
alias sshcsc-u="ssh -XC maandree@u-shell.csc.kth.se"
alias sshcsc-s="ssh -XC maandree@s-shell.csc.kth.se"

alias sftpcsc="sftp maandree@u-shell.csc.kth.se"
alias sftpcsc-u="sftp maandree@u-shell.csc.kth.se"
alias sftpcsc-s="sftp maandree@s-shell.csc.kth.se"

alias cdgit="cd ~/git"
alias build=". build.sh"
alias clean=". clean.sh"
alias run=". run.sh"
alias dev="./dev.sh"
alias ge="gemacs"
alias spell="./dev/spell.sh"
alias dist="./dev/dist.sh"

alias notesmod='find . | egrep \\.\(png\|svg\|odt\|pdf\|missing\)\$ | sed -e '\''s/^/'\''\'\'''\''/'\'' -e '\''s/$/'\''\'\'''\''/'\'' | xargs chmod 644'
