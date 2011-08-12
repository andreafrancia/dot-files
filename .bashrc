# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return

shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

source ~/.profile

export PS1='[\u@\h \W]\$'

[ -x "$(which pip)" ] && eval "`pip completion --bash`"

export PATH="/usr/local/bin:${PATH}"


for i in ~/dot-files/bash.d/*; do 
    source "$i"
done

export PATH="/usr/local/share/python:$PATH"
export PATH=~/bin.local:"$PATH"


