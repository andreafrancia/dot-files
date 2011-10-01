function svn-repair-move() {
    usage="Usage:
    $FUNCNAME SRC DEST"
    local src="${1?"$usage"}"
    local dest="${2?"$usage"}"
    [ -f "$src" ] && { echo "Refusing overwriting \`$src'" >&2 ; return; }
    mv --no-clobber "$dest" "$src"
    svn mv "$src" "$dest"
}
