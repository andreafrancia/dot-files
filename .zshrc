# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return

bindkey -e
. ~/.shrc

# history
HISTFILE=~/.zsh_history
HISTSIZE=$((1024*365))
SAVEHIST=$((1024*365))

# Git-aware fancy prompt {{{
setopt prompt_subst
tilde_or_pwd() {
  echo $PWD | sed -e "s/\/Users\/$USER/~/"
}

red-on-error() {
    red_on_error=$'%{\e[0;%(?.32.31)m%}'
    no_color=$'%{\e[0m%}'
    echo "$red_on_error$@$no_color"
}
prompt-normal() {
    arrow="$(red-on-error ">")"
    git_info='$(git_cwd_info)'
    cur_dir=$'%{\e[0;90m%}$(tilde_or_pwd)%{\e[0m%}'
    export PROMPT="$arrow "
    export RPROMPT="$cur_dir $git_info"
}
prompt-simple() {
    dollar="$(red-on-error "\$")"
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
setopt auto_cd         # Type ".." instead of "cd ..", "/usr/" instead of "cd /usr/".
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

function rmdir() {
    rm -f "$1/.DS_Store">/dev/null
    "$(which -p rmdir)" "$@"
}

unalias run-help
autoload run-help
HELPDIR=~/.zsh_help

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# zsh completion
fpath=(/usr/local/share/zsh-completions $fpath)
