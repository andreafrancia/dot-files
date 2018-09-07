alias a='git add -A . && git status --short'
alias c='git commit -m "Save." .'
alias d='git diff HEAD'
alias s='git status --short'

[ -s ~/.aliases.sh.local ] && source ~/.aliases.sh.local
