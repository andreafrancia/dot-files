set -o errexit
cd ~
git clone git@github.com:andreafrancia/homebrew.git

brew install coreutils findutils --default-names
brew install ctags lftp ncftp wget ack unrar watch git subversion \
             a2ps bash colordiff duff markdown nmap grep curl \
             ctags iftop dos2unix w3m par htop

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
