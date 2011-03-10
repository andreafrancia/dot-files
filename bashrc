# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# misc
shopt -s checkwinsize
export PATH="$PATH:$HOME/.gem/ruby/1.8/bin"

for i in ~/dot-files/bash.d/*; do 
    	source "$i"
done
