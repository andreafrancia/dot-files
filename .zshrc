# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return
add_path() {
    local newpath="$1"
    PATH="$newpath:$PATH"
    PATH="${PATH//:$newpath/}"
}
GEM_PATH=~/.gems
add_path "$HOME/bin"
add_path "$HOME/bin.local"
add_path "/usr/local/bin"
add_path "/usr/local/sbin"
add_path "$HOME/.vim/plugged/vim-themis/bin"
add_path "$HOME/git-mass-amend/bin"
add_path "$HOME/baby-steps-tdd/bin"
add_path "/Library/TeX/texbin"
export PATH

export EDITOR=vim
export LC_CTYPE=en_US.UTF-8

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

bindkey -e

# history
HISTFILE=~/.zsh_history
HISTSIZE=$((1024*365))
SAVEHIST=$((1024*365))

# Git-aware fancy prompt {{{
setopt prompt_subst
tilde_or_pwd() {
  echo "$PWD" | sed -e "s/\/Users\/$USER/~/"
}

red-on-error() {
    local red_on_error=$'%{\e[0;%(?.32.31)m%}'
    local no_color=$'%{\e[0m%}'
    echo "$red_on_error$@$no_color"
}
prompt-normal() {
    local dollar="$(red-on-error "\$")"
    local cur_dir=$'%{\e[0;90m%}$(tilde_or_pwd)%{\e[0m%}'
    export PROMPT="$dollar "
    export RPROMPT="$cur_dir "'$(git_cwd_info)'
}
prompt-testing() {
    local green_or_red=$'%{\e[0;%(?.32.31)m%}'
    local pass_or_fail=$'%(?.OK.KO)'
    local dollar="\$"
    local no_color=$'%{\e[0m%}'
    export PROMPT="$green_or_red$pass_or_fail $dollar$no_color "
}
prompt-simple() {
    local dollar="$(red-on-error "\$")"
    export PROMPT="$dollar "
    export RPROMPT=
}
prompt-normal
# }}}

# Bash-like Ctrl+W and Alt+Backspace{{{

# Ctrl+W
unix-word-rubout() {
    local WORDCHARS='*?/_-.[]~=&;!#$%^(){}<>'
    zle backward-kill-word
}
zle -N unix-word-rubout
bindkey '^W' unix-word-rubout

# Alt+backspace
WORDCHARS='*?[]~&;!$%^<>'
bindkey '\e^h' backward-kill-word

# }}}

bindkey "^[[3~"     delete-char
bindkey "^[3;5~"    delete-char

setopt interactivecomments
setopt rm_star_wait    # 10 second wait if you do something that will delete everything
setopt no_flow_control # Disable ctrl+s
setopt no_case_glob    # Case insensitive globbing
setopt numeric_glob_sort 
setopt no_clobber      # Fail when > existent
setopt beep
setopt notify

SAVEHIST=$HISTSIZE  # Max number of history entries
setopt appendhistory
setopt hist_find_no_dups
setopt no_hist_ignore_space
setopt inc_append_history

# Completion
autoload -Uz compinit

# caching 
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Color in completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

function load_compinit_at_first_tab_press() {
    compinit
    bindkey '^I' expand-or-complete
    zle expand-or-complete
}
zle -N load_compinit_at_first_tab_press
bindkey '^I' load_compinit_at_first_tab_press

function 'rmdir!'() {
    rm -fv "$1/.DS_Store">/dev/null
    "$(which -p rmdir)" "$@"
}

function show-evil-whitespaces() {
    ack -k " +$" $(git diff --cached --name-only ) "$@"
}

alias run-help >/dev/null && unalias run-help
autoload run-help
HELPDIR=~/.zsh_help

# zsh completion
fpath=(/usr/local/share/zsh-completions $fpath)

# File protection aliases ----------------------------------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Other aliases ---------------------------------------------------------------
alias grep='grep --color'

# prefer GNU version for some programs, when found in path
for cmd in ls rm cp mv find grep; do
    if type "g$cmd" >& /dev/null; then
        # creates a function like:
        #       ls() { gls "$@"; }
        eval "$cmd() { g$cmd \"\$@\"; }"
        # Note: We use functions because...
        # 1. it is better than adding the gnubin directory to the PATH, e.g.
        #       PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
        #    because functions are not propagated to the scripts invoked by
        #    the shell
        # 2. it is better than using aliases (e.g. alias mv='gmv', because
        #    using aliases at this point would be overridden by further
        #    aliases, e.g. alias mv='mv -i'
    fi
done

# Colors for ls --------------------------------------------------------------
if ls --color . >& /dev/null; then
    alias ls='ls -h --color'
else
    echo "Using the lame \`ls' of BSD"
    alias ls='ls -h -G'
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# load local conf
[ -s ~/.zshrc.local ] && source ~/.zshrc.local

# load aliases
[ -s ~/.aliases.sh ] && source ~/.aliases.sh

# reload conf
alias reload-zshrc='source ~/.zshrc'

# vim: set ft=sh:
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

mkdir_cd () { mkdir -p "$1" && cd "$1"; }

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
