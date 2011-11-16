# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return

source ~/.profile

# PATH (the last inserted wins) ----------------------------------------------
PATH="/sbin:/usr/sbin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:${PATH}" # standard homebrew location
PATH=~/homebrew/bin:"$PATH"   # user homebrew installation
PATH="$(brew --prefix)/sbin:$PATH"
PATH=~/bin:"$PATH"        # user executable shared among all machines
PATH=~/bin.local:"$PATH"  # user executable for this machine
PATH=~/local/bin:"$PATH"  # software built with --prefix=~/local
PATH="$(brew --prefix)/share/python:$PATH"  # python from homebrew
export PATH

# misc environments
export EDITOR=vim # The best editor ever
export PIP_DOWNLOAD_CACHE=~/.pip/cache # PIP download cache

# ============================================================================
# Ineractive
# ============================================================================

# File protection aliases ----------------------------------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Other aliases ---------------------------------------------------------------
alias grep='grep --color'

# Colors for ls --------------------------------------------------------------
if ls --color . >& /dev/null; then
    alias ls='ls --color'
else
    echo "Using the lame \`ls' of BSD"
    alias ls='ls -G'
fi

# "Infinite" bash history ----------------------------------------------------
HISTSIZE=$((1024*1024*365))
HISTCONTROL= # remember both commands with spaces and duplicages

if type shopt >& /dev/null; then
    shopt -s histappend # Don't overwrite the history at the start of every new session
    shopt -s checkwinsize
fi

# Bash completion ------------------------------------------------------------
if type complete >& /dev/null; then 
    prefix="$(brew --prefix || true)"
    [ -f "$prefix/etc/bash_completion" ] && source "$prefix/etc/bash_completion"
    [ -x "$(which pip)" ] && eval "`pip completion --bash`" # pip
    source "$(brew --prefix)/Library/Contributions/brew_bash_completion.sh"
    [ -x "$(which pycompletion)" ] && source "$(which pycompletion)" || \
        echo "Use 'pip install pycompletion' if you wants bash completions for nose, fabric, virtualenv, ... and others."
fi


