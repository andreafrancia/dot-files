# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return

. "$(dirname "$BASH_SOURCE")/.common-shrc.sh"

# history
HISTFILE=~/.bash_history
HISTSIZE=$((1024*365)) # how many history line to be saved on exit

HISTCONTROL= # remember both commands with spaces and duplicages
# Don't overwrite the history at the start of every new session
shopt -s histappend 

shopt -s checkwinsize

[ -x "$(which pip)"  ] && eval "`pip completion --bash`"
[ -x "$(which brew)" ] && {
	prefix="$(brew --prefix)"	
	[ -f "$prefix/etc/bash_completion" ] && source "$prefix/etc/bash_completion"
	source "$prefix/Library/Contributions/brew_bash_completion.sh"
}

