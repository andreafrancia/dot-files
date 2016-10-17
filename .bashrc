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

export EDITOR=vim
export LC_CTYPE=en_US.UTF-8

# Trucco del dollaro
PROMPT_COMMAND=__testing_prompt

function __testing_prompt() {
    local exit_code="$?"
    local red='\[\e[0;31m\]'
    local green='\[\e[0;32m\]'
    local reset_colors='\[\e[0m\]'

    if [[ $exit_code == 0 ]]; then
        PS1="$green\$$reset_colors "
    else
        PS1="$red\$$reset_colors "
    fi
}