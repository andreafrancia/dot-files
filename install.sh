#!/bin/bash
set errexit
set nounset

main() {
    ensure_all_files_can_be_overwritten "${items[@]}" || \
        die "Failed: Please remove this/these file(s) before the installation: ${files_to_remove[*]}"

    install_all_items "${items[@]}"

    mkdir -p ~/.vim-tmp ~/.tmp
}

items=( .bash_profile .bashrc 
        .cvsignore 
        .git-prompt.conf .gitconfig .gitignore .gitmodules 
        .hgrc .global-hgignore
        .gvimrc .vim .vimrc 
        bin git-prompt )

script_dir="$(dirname "$0")"

install_all_items() {
    local item

    for item in "$@"; do
        install_file "$script_dir/$item" ~/"$item"
    done
}

install_file() {
    local src="$1"
    local dst="$2"

    ln -sfTv "$(abspath "$src")" "$dst"
}

abspath() {
    readlink -f "$1"
}

ensure_all_files_can_be_overwritten() {
    files_to_remove=()
    for item in "$@"; do
        if exists_and_is_not_a_link ~/"$item"; then
	    files_to_remove=( "${files_to_remove[@]}" "~/$item" )
	fi  
    done
    [ ${#files_to_remove[@]} -eq 0 ];
}

exists_and_is_not_a_link() {
    local path="$1"
   
    [ -e "$path" -a ! -L "$path" ]
}

die() {
    local message="$1"
    echo "$message" >&2
    exit 1
}

main
