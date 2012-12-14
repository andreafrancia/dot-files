# .zshenv is sourced for every invocation of zsh
fpath=($fpath $HOME/.zsh/func)
typeset -U fpath
export PATH="$HOME/.rvm/bin:$PATH"
