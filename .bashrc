# .bashrc

export PS1="[\u@\h \W]$"

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source local bashrc
if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi

# Git tab autocomplete
source /usr/share/bash-completion/completions/git

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
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
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

