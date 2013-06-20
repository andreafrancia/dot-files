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
brew install homebrew/dupes/grep
brew install openssh
brew install ssh-copy-id
brew install md5sha1sum
brew install zsh-completions

# Install MacVim
brew install macvim --enable-cscope --enable-clipboard \
                    --custom-icons --with-envycoder --override-system-vim 
mkdir -p ~/Applications
brew linkapps

# Tell OSX to show full path in Finder title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
killall Finder
