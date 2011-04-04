set expandtab
set shiftwidth=4
set smartindent
set omnifunc=syntaxcomplete#Complete

filetype plugin indent on
syntax on 

autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab textwidth=78 smarttab foldmethod=indent
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab textwidth=78 expandtab foldmethod=syntax

set smartindent
colorscheme vividchalk

" Writing text
au BufRead,BufNewFile *.txt		setfiletype text
runtime macros/justify.vim
autocmd FileType text setlocal textwidth=78 formatoptions+=w

