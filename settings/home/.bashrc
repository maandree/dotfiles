# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export PATH=$(echo ~)"/.local/bin:"$PATH
export GPG_KEY=69E7C5ED



## emacs fitted for terminals
#if [ "$TERM" = "linux" ]; then
#    xem=1
#    function nemacs
#    {
#	if [ "$xem" = '1' ]; then
#	    #echo -en '\e[?8c'
#	    TERM='xterm'
#	fi
#	echo -en '\e[?8c'
#	emacs -nw "$@"
#	echo -en '\e[?8c'
#	TERM='linux'
#	#if [ "$xem" = '1' ]; then
#	#    echo -en '\e[?0c'
#	#fi
#    }
#else
#    function nemacs
#    {
#	xhi=0
#	if [ "$TERM" = 'xterm-256color' ]; then
#	    xhi=1
#	    TERM='xterm'
#	fi
#	echo -en '\e]0;emacs: '"$1"'\a'
#	#if [ "$COLORTERM" = '' ] && [ "$TERM" = 'xterm' ]; then
#	#    (sleep 0.5 ; palette-reset ) &
#	#fi
#	emacs -nw "$@"
#	echo -en '\e]0;\u@\h: \w  ||  `tty`\a'
#	if [ $xhi = 1 ]; then
#	    TERM='xterm-256color'
#	fi
#    }
#fi

## make less more friendly for non-text input files, see lesspipe(1)  ## bullshit
#[ -x /usr/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh /usr/bin/lesspipe.sh)"


# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#################################################################################################
#################################################################################################

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

. ~/.config/.bashrc_autocomplete
. ~/.config/.bashrc_history
. ~/.config/.bashrc_colour
. ~/.config/.bashrc_illegal
. ~/.config/.bashrc_stdalias
. ~/.config/.bashrc_palette.xterm
. ~/.config/.bashrc_palette.linux
. ~/.config/.bashrc_prompt
. ~/.config/.bashrc_window
. ~/.config/.bashrc_export
. ~/.config/.bashrc_extra
. ~/.config/.bashrc_cmd
. ~/.config/.bashrc_git
. ~/.config/.bashrc_pacman
. ~/.config/.bashrc_daemons
. ~/.config/.bashrc_modprobe
. ~/.config/.bashrc_pdf
. ~/.config/.bashrc_main
. ~/.config/.bashrc_boot
. ~/.config/.bashrc_mount


#################################################################################################
##  Personal
#################################################################################################

. ~/.config/.bashrc_crypt
. ~/.config/.bashrc_encryption
. ~/.config/.bashrc_ssh

alias s="java7 -cp ~/git/schema/bin/ se.kth.maandree.mastertimekeeper.Program ~/maandree.schema"

alias q="ponymenu"

