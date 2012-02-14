set -o errexit
cd ~
git clone git@github.com:andreafrancia/homebrew.git

install-package () {
    brew install "$@"
}

install-macvim() {
    brew install macvim --enable-cscope --enable-clipboard \
                        --custom-icons --with-envycoder --override-system-vim 
    mkdir -p ~/Applications
    brew linkapps
}

install-package findutils 
install-package xz
install-package coreutils
install-package a2ps
install-package ack
install-package bash
install-package colordiff
install-package ctags 
install-package curl
install-package dos2unix
install-package git
install-package grep
install-package htop
install-package nmap
install-package par
install-package subversion
install-package unrar
install-package watch
install-package wget 

install-macvim


# Python 
install-python-for-development()
{
    brew install python
    "$(brew --prefix)/share/python/easy_install" pip
    alias pip="$(brew --prefix)/share/python/pip"
    pip install --upgrade distribute
    pip install pyflakes            # needed by syntastic
    pip install readline ipython    # install them toghether in order to avoid buggy readline of OS X
    pip install nose
    easy_install nose-machineout    # as of 2011-11-02 machine-out seems not working with pip
    #pip install Mercurial 
}

install-python-for-development

# Bash completion
brew install bash-completion
curl http://worksintheory.org/files/misc/bash_completion_svn -o "$(brew --prefix)/etc/bash_completion.d/bash_completion_svn"

# Software Elisa
brew install gfortran gnuplot 

# Tell OSX to show full path in Finder title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
killall Finder

echo "Done"
