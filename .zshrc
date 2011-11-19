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

bindkey '\e^h' delete-backward-word  # alt - backspace

# caching 
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
autoload -Uz compinit
compinit

# History 
HISTFILE=~/.histfile
HISTSIZE=$((1024*1024))
SAVEHIST=$HISTSIZE  # Max number of history entries
setopt appendhistory
setopt hist_find_no_dups
setopt no_hist_ignore_space
setopt inc_append_history

# Customization
source ~/.bashrc
