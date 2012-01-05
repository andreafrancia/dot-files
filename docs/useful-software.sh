set -o errexit
cd ~
git clone git@github.com:andreafrancia/homebrew.git

brew install findutils --default-names
brew install coreutils --default-names
brew install ctags 
brew install lftp
brew install ncftp
brew install wget 
brew install ack
brew install unrar
brew install watch
brew install git
brew install subversion
brew install a2ps
brew install bash
brew install colordiff
brew install duff
brew install markdown
brew install nmap
brew install grep
brew install curl
brew install ctags
brew install iftop
brew install dos2unix
brew install w3m
brew install par
brew install htop

# MacVim
brew install macvim --enable-cscope --enable-clipboard \
                    --custom-icons --with-envycoder --override-system-vim 
mkdir -p ~/Applications
brew linkapps

# Python 
brew install readline python
"$(brew --prefix)/share/python/easy_install" pip
alias pip="$(brew --prefix)/share/python/pip"
pip install --upgrade distribute
pip install Mercurial 
pip install pyflakes            # needed by syntastic
pip install readline ipython    # install them toghether in order to avoid buggy readline of OS X
pip install nose
easy_install nose-machineout    # as of 2011-11-02 machine-out seems not working with pip

# Bash completion
brew install bash-completion
curl http://worksintheory.org/files/misc/bash_completion_svn -o "$(brew --prefix)/etc/bash_completion.d/bash_completion_svn"

# Software Elisa
brew install gfortran gnuplot 

# Tell svnX to not create an alias in ~/bin
defaults write com.lachoseinteractive.svnX installSvnxTool -bool NO

# Tell OSX to show full path in Finder title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
killall Finder

# Enable git color
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto

# Enable zsh run-help 

cd .zsh_help
curl -ohelpfiles 'http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=blob_plain;f=Util/helpfiles;hb=HEAD'
man zshbuiltins | colcrt - | perl zsh-4.3.12/Util/helpfiles

echo "
unalias run-help
autoload run-help
HELPDIR=~/.zsh_help
" >> ~/.zshrc 


echo "Done"
