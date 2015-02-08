brew install findutils 
brew install coreutils
brew install ctags 
brew install curl
brew install git
brew install htop
brew install nmap
brew install unrar
brew install watch
brew install wget 
brew install python
brew install bash
brew install grep
brew install openssh
brew install ssh-copy-id
brew install zsh-completions

# Install MacVim
brew install macvim --enable-cscope --enable-clipboard \
                    --custom-icons --with-envycoder --override-system-vim 
mkdir -p ~/Applications
brew linkapps

# Tell OSX to show full path in Finder title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
killall Finder
