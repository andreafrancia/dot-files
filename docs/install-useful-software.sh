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
"$(brew --prefix)/share/python/pip" install --upgrade distribute
"$(brew --prefix)/share/python/pip" install Mercurial pyflakes
"$(brew --prefix)/share/python/pip" install 'http://pypi.python.org/packages/source/r/readline/readline-6.2.1.tar.gz#md5=9604527863378512247fcaf938100797'
"$(brew --prefix)/share/python/pip" install ipython


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
