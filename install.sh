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
install_link .common-shrc.sh
install_link .cvsignore 
install_link .git-prompt.conf 
install_link .gitconfig 
install_link .gitignore 
install_link .gitmodules 
install_link .hgrc 
install_link .global-hgignore
install_link .gvimrc 
install_link .vim 
install_link .vimrc 
install_link .zsh 
install_link .zshenv 
install_link .zshrc
install_link bin 
install_link git-prompt
install_link .ackrc

mkdir -p ~/.vim-tmp ~/.tmp
mkdir -m 0700 ~/.ssh
echo "VisualHostKey yes" >> ~/.ssh/config
