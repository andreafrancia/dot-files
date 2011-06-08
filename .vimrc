" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" Make tab completion for files/buffers act like bash
set wildmenu

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Keep more context when scrolling off the end of a buffer
set scrolloff=3

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands


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
autocmd FileType text setlocal textwidth=0 formatoptions+=w textwidth=78

autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab textwidth=78 foldmethod=indent
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab textwidth=78 foldmethod=syntax

" Use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set omnifunc=syntaxcomplete#Complete
set laststatus=2
set showmatch
set incsearch

" === Python ================================================================= 

" GRB: add pydoc command
:command! -nargs=+ Pydoc :call ShowPydoc("<args>")
function! ShowPydoc(module, ...)
    let fPath = "/tmp/pyHelp_" . a:module . ".pydoc"
    :execute ":!pydoc " . a:module . " > " . fPath
    :execute ":sp ".fPath
endfunction

" GRB: Put useful info in status line
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
:hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red

" GRB: clear the search buffer when hitting return
:nnoremap ,<CR> :nohlsearch<cr>



