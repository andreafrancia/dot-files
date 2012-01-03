# Customization
source ~/.bashrc

setopt promptsubst                  # perform substitutions in prompt
autoload -U promptinit; promptinit  # Load the prompt theme system
prompt wunjo

setopt interactivecomments
setopt auto_cd         # Type ".." instead of "cd ..", "/usr/" instead of "cd /usr/".
setopt auto_pushd      # This makes cd=pushd
setopt rm_star_wait    # 10 second wait if you do something that will delete everything
setopt no_flow_control # Disable ctrl+s
setopt no_case_glob    # Case insensitive globbing
setopt numeric_glob_sort 
setopt no_clobber
setopt beep
setopt notify

bindkey -e  # Emacs key 

export EDITOR=vi

# Alt+backspace
bindkey '\e^h' backward-kill-word
export WORDCHARS='*?[]~&;!$%^<>'
#bindkey '\e^h' delete-backward-word  # alt - backspace
bindkey "^[[3~"     delete-char
bindkey "^[3;5~"    delete-char

# caching 
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
autoload -Uz compinit; compinit

# Color in completion
eval `dircolors`
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# History 
HISTFILE=~/.histfile
HISTSIZE=$((1024*1024))
SAVEHIST=$HISTSIZE  # Max number of history entries
setopt appendhistory
setopt hist_find_no_dups
setopt no_hist_ignore_space
setopt inc_append_history


unalias run-help
autoload run-help
HELPDIR=~/.zsh_help

activate_virtualenv() {
    if [ -f env/bin/activate ]; then . env/bin/activate;
    elif [ -f ../env/bin/activate ]; then . ../env/bin/activate;
    elif [ -f ../../env/bin/activate ]; then . ../../env/bin/activate;
    elif [ -f ../../../env/bin/activate ]; then . ../../../env/bin/activate;
    fi
}

# Linux specific configuration {{{
if grep -q 'Linux' /proc/version; then
    alias open=xdg-open
fi
# }}}
