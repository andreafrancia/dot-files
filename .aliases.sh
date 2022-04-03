alias a='git add -A . && git status --short'
alias d='git diff HEAD'
alias s='git status --short'
alias l='git l'

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

[ -s ~/.aliases.sh.local ] && source ~/.aliases.sh.local
