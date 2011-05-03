set expandtab
set shiftwidth=4
set smartindent
set omnifunc=syntaxcomplete#Complete

filetype plugin indent on
syntax on 

set smartindent
set cursorline

" show statusline always
set laststatus=2

" I want a big history (the default is only 20 commands)
set history=1000

" Writing text
au BufRead,BufNewFile *.txt		setfiletype text
runtime macros/justify.vim
autocmd FileType text setlocal textwidth=0 formatoptions+=w

autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab textwidth=78 foldmethod=indent
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab textwidth=78 foldmethod=syntax

" Use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

