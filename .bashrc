# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return

. "$(dirname "$BASH_SOURCE")/.common-rc.sh"

# history
HISTFILE=~/.bash_history
HISTSIZE=$((1024*365)) # how many history line to be saved on exit

HISTCONTROL= # remember both commands with spaces and duplicages
# Don't overwrite the history at the start of every new session
shopt -s histappend 

shopt -s checkwinsize

prefix="$(brew --prefix || true)"
[ -f "$prefix/etc/bash_completion" ] && source "$prefix/etc/bash_completion"

[ -x "$(which pip)" ] && eval "`pip completion --bash`" # pip
source "$brew_prefix/Library/Contributions/brew_bash_completion.sh"

