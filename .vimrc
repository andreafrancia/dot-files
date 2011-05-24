set expandtab
set shiftwidth=4
set smartindent
set omnifunc=syntaxcomplete#Complete

filetype plugin indent on
syntax on 
set ruler

" Draw a red line on column (one char after the textwidth value)
" from " http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns/3765575#3765575
if exists('+colorcolumn')
    set colorcolumn=+1
endif

set t_Co=256 " enable 256 colors
colorscheme xoria256

set smartindent
set cursorline

" show statusline always
set laststatus=2

" I want a big history (the default is only 20 commands)
set history=1000

" Writing text
au BufRead,BufNewFile *.txt setfiletype text
runtime macros/justify.vim
autocmd FileType text setlocal textwidth=0 formatoptions+=w

autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab textwidth=78 foldmethod=indent
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab textwidth=78 foldmethod=syntax

" Use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

