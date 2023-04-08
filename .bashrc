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

# reload conf
alias reload-bashrc='source ~/.bashrc'
alias a='git add -A . && git status --short'
alias d='git diff HEAD'
alias s='git status --short'
alias c='git commit -m Save'

PROMPT_COMMAND=__prompt_colorato
function __prompt_colorato() {
    local exit_code="$?"
    local red='\[\e[0;31m\]'
    local green='\[\e[0;32m\]'
    local reset_colors='\[\e[0m\]'

    PS1=
    if [[ $exit_code == 0 ]]; then
        PS1="$green"'\u@\h:\W \$'"$reset_colors "
    else
        PS1="$red"'\u@\h:\W'" ($exit_code)"' \$'"$reset_colors "
    fi
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
