# .bashrc


# Bash Prompt ##################################### {{{
WHITE='\[\033[1;37m\]'
LIGHTGRAY='\[\033[0;37m\]'
GRAY='\[\033[1;30m\]'
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
LIGHTRED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
LIGHTGREEN='\[\033[1;32m\]'
BROWN='\[\033[0;33m\]' #Orange
YELLOW='\[\033[1;33m\]'
BLUE='\[\033[0;34m\]'
LIGHTBLUE='\[\033[1;34m\]'
PURPLE='\[\033[0;35m\]'
PINK='\[\033[1;35m\]' #Light Purple
CYAN='\[\033[0;36m\]'
LIGHTCYAN='\[\033[1;36m\]'
DEFAULT='\[\033[0m\]'

export PS1="$RED\u$GREEN@$BLUE\h$PURPLE[\W]$GREEN\$$DEFAULT"
# }}}


# Protect from some mistakes by running commands in interactive mode
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Function to get PID of root SSHD process (useful in case of too many processes opening
function pidssh() {
	ps -ef | grep /usr/sbin | grep ssh | awk '{ print $2 }'
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source local bashrc
if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi

# Git tab autocomplete
if [ -f /usr/share/bash-completion/completions/git ]; then
	. /usr/share/bash-completion/completions/git
fi

# Adds date and time to commands in history
HISTTIMEFORMAT="%F %T "

# Makes history remember longer
HISTSIZE=2000
HISTFILESIZE=2000

# Appends history instead of overwriting
shopt -s histappend

# Ignore duplicates in history
export HISTCONTROL=ignoredups

# Function to search history for some string
function hg() {
	history | grep "$1";
}

# Shortcuts to vimrc and bashrc
alias vimrc='vim ~/dotfiles/.vimrc'
alias bashrc='vim ~/dotfiles/.bashrc'
alias bashrclocal='vim ~/.bashrc_local'
alias loadbash='source ~/.bashrc'

# Ctags
alias gentags='ctags -R .'

# Functions to grep c/cpp files only
function cgrep() {
	grep -r "$1" --color=always | grep "\.c" --color=never
}

function cgrepl() {
	grep -rl "$1" --color=always | grep "\.c" --color=never
}

