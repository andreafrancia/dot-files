set expandtab
set shiftwidth=4
set smartindent
set omnifunc=syntaxcomplete#Complete

filetype plugin indent on
syntax on 

autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab textwidth=78 foldmethod=indent
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab textwidth=78 foldmethod=syntax

set smartindent
set cursorline

" Use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
