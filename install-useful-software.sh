set -o errexit
brew install coreutils findutils --default-names
brew install ctags lftp ncftp wget curl ack unrar watch git python subversion
brew install a2ps bash colordiff duff markdown nmap
brew install macvim --enable-cscope --enable-clipboard \
                    --custom-icons --with-envycoder --override-system-vim 
mkdir -p ~/Applications
brew linkapps

easy_install pip
pip install Mercurial
pip install pyflakes

brew install bash-completion
prefix="$(brew --prefix)"
ln -s "$prefix/Library/Contributions/brew_bash_completion.sh" "$prefix/etc/bash_completion.d"
curl http://worksintheory.org/files/misc/bash_completion_svn -o "$prefix/etc/bash_completion.d/bash_completion_svn"
