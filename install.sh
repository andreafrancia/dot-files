#!/bin/bash
set -o errexit
set -o nounset

abspath() {
    echo "$PWD/$1"
}

exists_and_is_not_a_link() {
    local path="$1"

    [ -e "$path" -a ! -L "$path" ]
}

install_link() {
    local script_dir="$(dirname "$0")"
    local item="$1"
    local src="$script_dir/$item"
    local dest=~/"$item"

    exists_and_is_not_a_link "$dest" && { echo "Please remove this: $dest" >&2; exit 1; }

    /bin/rm -f "$dest"
    /bin/ln -sfv "$(abspath "$src")" "$dest"

}

install_link .bash_profile 
install_link .bashrc 
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
echo "VisualHostKey yes" >> ~/.ssh/config
