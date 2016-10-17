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
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWDIRTYSTATE=true
PROMPT_COMMAND='__git_ps1 "\w" "$(__dollar_trick) "'

function __dollar_trick() {
    local exit_code="$?"
    local red='\[\e[0;31m\]'
    local green='\[\e[0;32m\]'
    local reset_colors='\[\e[0m\]'

    if [[ $exit_code == 0 ]]; then
        echo "$green\$$reset_colors"
    else
        echo "$red\$$reset_colors"
    fi
}

if [ -f "$(brew --prefix git)/etc/bash_completion.d/git-prompt.sh" ]; then
    source "$(brew --prefix git)/etc/bash_completion.d/git-prompt.sh"
fi
