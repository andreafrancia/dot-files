# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return

. "$(dirname "$BASH_SOURCE")/.shrc"

# history
HISTFILE=~/.bash_history
HISTSIZE=$((128*365)) # how many history line to be saved on exit

HISTCONTROL= # remember both commands with spaces and duplicages

# Don't overwrite the history at the start of every new session
shopt -s histappend 

shopt -s checkwinsize
