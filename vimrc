set ofu=syntaxcomplete#Complete
set expandtab
set shiftwidth=4
set smartindent
filetype plugin indent on

if has("autocmd")
    filetype plugin indent on
endif

autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab textwidth=78 smarttab foldmethod=indent
