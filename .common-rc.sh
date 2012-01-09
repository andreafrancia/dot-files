# PATH (the last inserted wins) ----------------------------------------------
brew_prefix=~/homebrew                  # user homebrew installation
PATH="/sbin:/usr/sbin:$PATH"
PATH="/usr/local/bin:$PATH"             # standard homebrew location
PATH="/usr/local/sbin:$PATH"
PATH="$brew_prefix/bin:$PATH"
PATH="$brew_prefix/sbin:$PATH"
PATH=~/bin:"$PATH"                      # user executable shared among all machines
PATH=~/bin.local:"$PATH"                # user executable for this machine
PATH=~/local/bin:"$PATH"                # software built with --prefix=~/local
PATH="$brew_prefix/share/python3:$PATH" # python from homebrew
PATH="$brew_prefix/share/python:$PATH"  # python from homebrew
PATH="$HOME/.gem/ruby/1.8/bin:$PATH"
export PATH

export EDITOR=vim
export PIP_DOWNLOAD_CACHE=~/.pip/cache # PIP download cache

# File protection aliases ----------------------------------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Unbreak Python's error-prone .pyc file generation
export PYTHONDONTWRITEBYTECODE=1

# Other aliases ---------------------------------------------------------------
alias grep='grep --color'

# Colors for ls --------------------------------------------------------------
if ls --color . >& /dev/null; then
    alias ls='ls --color'
else
    echo "Using the lame \`ls' of BSD"
    alias ls='ls -G'
fi

# PyCompletion
[ -x "$(which pycompletion)" ] && source "$(which pycompletion)" || \
    echo "Use 'pip install pycompletion' if you wants completions for nose, fabric, virtualenv, ... and others."

activate_virtualenv() {
    if [ -f env/bin/activate ]; then . env/bin/activate;
    elif [ -f ../env/bin/activate ]; then . ../env/bin/activate;
    elif [ -f ../../env/bin/activate ]; then . ../../env/bin/activate;
    elif [ -f ../../../env/bin/activate ]; then . ../../../env/bin/activate;
    fi
}

