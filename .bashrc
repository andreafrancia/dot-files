# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return

. "$(dirname "$BASH_SOURCE")/.shrc"

# history
HISTFILE=~/.bash_history
HISTSIZE=$((1024*365)) # how many history line to be saved on exit

HISTCONTROL= # remember both commands with spaces and duplicages
# Don't overwrite the history at the start of every new session
shopt -s histappend 

shopt -s checkwinsize

[ -x "$(which pip)"  ] && eval "`pip completion --bash`"

load-bash-completion() {
    local prefix="$(brew --prefix)"
    source "$prefix/etc/bash_completion"
    source "$prefix/Library/Contributions/brew_bash_completion.sh"
}

colorize-prompt() { 

    local regular=0;  local bold=1;       local underline=4;
    local black='30'; local red='31';     local green='32'; local yellow='33';
    local blue='34';  local magenta='35'; local cyan='36';  local white='37';

    local reset='\e[0m'

    # trim last space
    PS1="${PS1%" "}"

    # set a colored prompt
    export PS1="\[\e[$regular;${cyan}m\]${PS1}\[$reset\] "
}

colorize-prompt
