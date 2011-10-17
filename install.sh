#!/bin/bash
set errexit
set nounset

script_dir="$(dirname "$0")"

main() {

    items=( .bash_profile .bashrc 
            .cvsignore 
            .git-prompt.conf .gitconfig .gitignore .gitmodules 
            .gvimrc .vim .vimrc 
            bin git-prompt )

    files_to_remove=()
    for item in "${items[@]}"; do
        if exists_and_is_not_a_link ~/"$item"; then
	    files_to_remove=( "${files_to_remove[@]}" "~/$item" )
            echo "${files_to_remove[@]}"
	fi  
    done

    if [ ${#files_to_remove[@]} -gt 0 ]; then
	die "Failed: Please remove those files before the installation: ${files_to_remove[*]}"
    fi

    for item in "${items[@]}"; do
        ln -sfTv "$(item_abspath "$item")" ~/"$item"
    done

    mkdir -p ~/.vim-tmp ~/.tmp
}

item_abspath() {
    local item="$1"
    local item_relpath="$script_dir/$item"
    local item_abspath="$(readlink -f "$item_relpath")"
    echo "$item_abspath"
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
