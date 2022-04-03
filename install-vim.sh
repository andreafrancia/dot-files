# Install MacVim
brew install macvim --enable-cscope --enable-clipboard \
                    --custom-icons --with-envycoder --override-system-vim 
mkdir -p ~/Applications
brew linkapps

# Tell OSX to show full path in Finder title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
killall Finder
