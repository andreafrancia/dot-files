brew install coreutils --with-default-names
brew install ctags
brew install lftp ncftp
brew install wget curl
brew install ack unrar watch 
brew install git 
brew install python

brew install macvim --enable-cscope --enable-clipboard \
     --custom-icons --with-envycoder --override-system-vim 
mkdir -p ~/Applications
brew linkapps
