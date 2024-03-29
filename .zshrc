# If not running interactively ... get out of here! 
[ -z "$PS1" ] && return
add_path() {
    local newpath="$1"
    PATH="$newpath:$PATH"
    PATH="${PATH//:$newpath/}"
}
GEM_PATH=~/.gems
add_path "$HOME/bin"
add_path "/usr/local/bin"
add_path "/usr/local/sbin"
export PATH

export EDITOR=vim
export LC_CTYPE=C.UTF-8
export LC_CTYPE=C
export LC_CTYPE=
export LC_CTYPE=en_US.UTF-8

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

bindkey -e

# history
setopt SHARE_HISTORY # save the each command in history file and save the timestamp
HISTFILE=~/.zsh_history
HISTSIZE=$((1024*365))
SAVEHIST=$((1024*365))

# Git-aware fancy prompt {{{
setopt prompt_subst

red-on-error() {
    local red_on_error=$'%{\e[0;%(?.32.31)m%}'
    local no_color=$'%{\e[0m%}'
    echo "$red_on_error$@$no_color"
}
pwd_with_tilde()
{
    echo "${PWD/$HOME/~}"
}
prompt-normal() {
    local dollar="$(red-on-error "\$")"
    local cur_dir=$'%{\e[0;90m%}$(pwd_with_tilde)%{\e[0m%}'
    export PROMPT="$dollar "
    export RPROMPT="$cur_dir "'$(git_cwd_info)'
}
prompt-simple() {
    local dollar="$(red-on-error "\$")"
    export PROMPT="$dollar "
    export RPROMPT=
}

prompt-starship() {
    eval "$(starship init zsh)"
}

if starship --version >& /dev/null; then
    prompt-starship
else
    prompt-normal
fi

set-title() {
	echo -ne "\033]0;$USER@$HOST:${PWD/#$HOME/~}\007"
}
precmd_functions+=(set-title)
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

function show-evil-whitespaces() {
    ack -k " +$" $(git diff --cached --name-only ) "$@"
}

alias run-help >/dev/null && unalias run-help
autoload run-help
HELPDIR=~/.zsh_help

# zsh completion
fpath=(/usr/local/share/zsh-completions $fpath)

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

# File protection aliases ----------------------------------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Other aliases ---------------------------------------------------------------
alias grep='grep --color'

# Colors for ls --------------------------------------------------------------
if ls --color --version . >& /dev/null; then
    alias ls='ls -h --color'
else
    echo "Using the lame \`ls' of BSD"
    alias ls='ls -h -G'
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# load local conf
[ -s ~/.zshrc.local ] && source ~/.zshrc.local

# aliases
alias a='git add -A . && git status --short'
alias d='git diff HEAD'
alias s='git status --short'

c() 
{
    local message="${1:-"Save."}"
    maybe_run git commit -m "$message"
}

maybe_run()
{
    if [[ -n $DONT_RUN ]]
    then
        printf "Would have ran: "
        local line="$(printf " %q" "$@")"
        line="${line:1}"
        printf "%s\n" "$line"
    else
        "$@"
    fi
}

test_git_aliases_functions()
{
    local DONT_RUN=t
    expect_stdout 'Would have ran: git commit -m Save.' \
        'c' 
    expect_stdout 'Would have ran: git commit -m a\ message\ with\ special\ chars\ \*\;' \
        'c' 'a message with special chars *;'
}

expect_stdout()
{
    local expected_stdout="$1"
    shift
    local stdout="$($@)"
    diff -u <(printf "%s\n" "$expected_stdout") <(printf "%s\n" "$stdout")
}

# reload conf
alias reload-zshrc='source ~/.zshrc'

# vim: set ft=sh:
mkdir_cd () { mkdir -p "$1" && cd "$1"; }

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
rvm-as-a-function()
{
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
}

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1 # disable upgrade of all other packages during install

nvm-activate()
{
    if [ -s  ~/.zsh-nvm/zsh-nvm.plugin.zsh ]; then
        source ~/.zsh-nvm/zsh-nvm.plugin.zsh
    fi
}

aa() {
    local activate_source
    for activate_source in env/bin/activate venv/bin/activate; do
        if [[ -f "$activate_source" ]]; then
            source "$activate_source"
            return 0
        else
            echo "$activate_source not found" 2>&1
        fi
    done
    echo "Virtual Env not found" 2>&1
    return 1
}
alias tt='pushd ~/wiki'

### Bashhub.com Installation
if [ -f ~/super-zsh-history/load_in_shell.zsh ]; then
    source ~/super-zsh-history/load_in_shell.zsh
fi

export PATH=~"/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

#zsh completion
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
[ -f ~/.ghcup/env ] && source ~/.ghcup/env # ghcup-env
alias e="exa --git"

[ -f /opt/homebrew/etc/profile.d/z.sh ] && source /opt/homebrew/etc/profile.d/z.sh 

rvm-as-a-function

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Created by `pipx` on 2023-04-08 09:12:09
export PATH="$PATH":~/.local/bin
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"
