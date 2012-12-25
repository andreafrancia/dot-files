brew install findutils 
brew install xz
brew install coreutils
brew install a2ps
brew install ack
brew install colordiff
brew install ctags 
brew install curl
brew install dos2unix
brew install git
brew install htop
brew install nmap
brew install par
brew install subversion
brew install unrar
brew install watch
brew install wget 
brew install python
brew install bash
brew install bash-completion
brew install grep
brew install openssh
brew install ssh-copy-id

# boost bash completion
curl http://worksintheory.org/files/misc/bash_completion_svn -o "$(brew --prefix)/etc/bash_completion.d/bash_completion_svn"

# Install MacVim
brew install macvim --enable-cscope --enable-clipboard \
                    --custom-icons --with-envycoder --override-system-vim 
mkdir -p ~/Applications
brew linkapps

# OSX already ships the GNU grep, the version it provides is 2.5.1. The
# essential option --ignore-dir has been introduced in 2.5.1a.
brew install https://raw.github.com/adamv/homebrew-alt/master/duplicates/grep.rb

# Tell OSX to show full path in Finder title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
killall Finder
