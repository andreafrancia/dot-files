# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

alias ls='ls --color=auto'

source ~/.profile

PS1='[\u@\h \W]\$'

PYTHON_HOME="/opt/local/Library/Frameworks/Python.framework/Versions/2.6"
export PATH="$PYTHON_HOME/bin:$PATH"

eval "`pip completion --bash`"

# ruby
export RUBYOPT=-rubygems
export PATH="$HOME/.gem/ruby/1.8/bin:$PATH"

for i in ~/dot-files/bash.d/*; do 
    source "$i"
done

export PS1


