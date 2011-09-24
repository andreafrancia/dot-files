# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return

shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

source ~/.profile

# prompt ---------------------------------------------------------------------
export PS1='[\u@\h \W]\$'

# File protection aliases ----------------------------------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Some aliases ---------------------------------------------------------------
alias kdiff3='/Applications/kdiff3.app/Contents/MacOS/kdiff3'
alias grep='grep --color'
alias grep-sources='grep --exclude-dir=.svn --color -r .'

# PATH (the last inserted win) -----------------------------------------------
export PATH="/sbin:/usr/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:${PATH}" # standard homebrew location
export PATH=~/homebrew/bin:"$PATH"   # user homebrew installation
export PATH="$(brew --prefix)/sbin:$PATH"
export PATH=~/bin:"$PATH"        # user executable shared among all machines
export PATH=~/bin.local:"$PATH"  # user executable for this machine
export PATH=~/local/bin:"$PATH"  # software built with --prefix=~/local
export PATH="$(brew --prefix)/share/python:$PATH"  # python from homebrew

# Colors for ls --------------------------------------------------------------
if ls --color . >& /dev/null; then
    alias ls='ls --color'
else
    echo "Using the lame \`ls' of BSD"
    alias ls='ls -G'
fi

# Default Editor -------------------------------------------------------------
export EDITOR=vim

# "Infinite" bash history ----------------------------------------------------
export HISTSIZE=$((1024*1024*365))
shopt -s histappend # Don't overwrite the history at the start of every new session
HISTCONTROL= # setting to nothing means to remember both commands with spaces and duplicages

# Bash completion
prefix="$(brew --prefix || true)"
[ -f "$prefix/etc/bash_completion" ] && source "$prefix/etc/bash_completion"
[ -x "$(which pip)" ] && eval "`pip completion --bash`" # pip
source "$(brew --prefix)/Library/Contributions/brew_bash_completion.sh"

# PIP download cache
export PIP_DOWNLOAD_CACHE=~/.pip/cache

# rest -----------------------------------------------------------------------
for i in ~/dot-files/bash-interactive.d/*.bash; do 
    source "$i"
done

