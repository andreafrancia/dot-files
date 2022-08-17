#!/bin/bash
set -o errexit
set -o nounset

install_link() {
    local item="$1"
    local src="${PWD##$HOME/}/$item"
    local dest="$HOME/$item"

    make_backup_if_necessary "$dest"
    /bin/rm -f "$dest"
    /bin/ln -sfv "$src" "$dest"
}

make_backup_if_necessary() {
    local path="$1"

    # if exists and is not a link 
    if [ -e "$path" -a ! -L "$path" ]; then
        # it deserve a backup
        mv -v "$path" "$path.backup"
    fi
}

install_link .bash_profile 
install_link .bashrc 
install_link .gitconfig 
install_link .gitignore 
install_link .gvimrc 
install_link .vim 
install_link .vimrc 
install_link .zshenv 
install_link .zsh 
install_link .zlogin 
install_link .zshrc
install_link bin 
install_link .dircolors
install_link .gemrc
install_link .irbrc
install_link global.gitignore

mkdir -p ~/.vim-tmp ~/.tmp
mkdir -p -m 0700 ~/.ssh
echo "VisualHostKey yes" >> ~/.ssh/config
