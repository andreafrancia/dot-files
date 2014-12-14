# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return

# history
HISTFILE=~/.bash_history
HISTSIZE=$((128*365)) # how many history line to be saved on exit

HISTCONTROL= # remember both commands with spaces and duplicages

# Don't overwrite the history at the start of every new session
shopt -s histappend 

shopt -s checkwinsize

# File protection aliases ----------------------------------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Unbreak Python's error-prone .pyc file generation
export PYTHONDONTWRITEBYTECODE=1
export EDITOR=vim
export LC_CTYPE=en_US.UTF-8
