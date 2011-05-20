# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# put duplicate lines in the history. 
# ... or force ignoredups and ignorespace
HISTCONTROL=

shopt -s histappend # append to the history file, don't overwrite it

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=$((1024*1024*365))

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

export PATH="$PATH:$HOME/.gem/ruby/1.8/bin"

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls --color=auto'

source ~/.profile

PS1='[\u@\h \W]\$'
#PS1='\[\e[1;32m\]'"$PS1"'\[\e[0m\] '

export PATH="$HOME/bin:$PATH"
export PATH="/opt/local/apache2/bin:$PATH"
export PATH="/opt/local/libexec/gnubin:$PATH"
PYTHON_HOME="/opt/local/Library/Frameworks/Python.framework/Versions/2.6"
export PATH="$PYTHON_HOME/bin:$PATH"

# macport path
export PATH="/opt/local/bin:$PATH"

# ruby
export RUBYOPT=-rubygems
export PATH="$HOME/.gem/ruby/1.8/bin:$PATH"

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

export EDITOR=vim

for i in ~/dot-files/bash.d/*; do 
    source "$i"
done

export PS1


