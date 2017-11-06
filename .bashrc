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
alias ls='gls --color'

export EDITOR=vim
export LC_CTYPE=en_US.UTF-8

# case insensitive tab completion
bind "set completion-ignore-case on"

# source bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# load local conf
[ -s ~/.bashrc.local ] && source ~/.bashrc.local

# load aliases
[ -s ~/.aliases.sh ] && source ~/.aliases.sh

# reload conf
alias reload-bashrc='source ~/.bashrc'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
