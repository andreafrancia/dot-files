# enable infinite history
export HISTSIZE=$((1024*1024*365))
# append all commands to the history file, don't overwrite it at the start of every new session
shopt -s histappend
# remember both commands with spaces and duplicages
HISTCONTROL=

