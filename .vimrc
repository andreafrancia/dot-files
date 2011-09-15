" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

call pathogen#infect()
:Helptags

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" Remember more commands and search history
set history=1000

" Make tab completion for files/buffers act like bash
set wildmenu

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Keep more context when scrolling off the end of a buffer
set scrolloff=3

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Andrea: my colorschme
colorscheme xoria256

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


" GRB: hide the toolbar in GUI mode
if has("gui_running")
    set go-=T
end

" From GRB:
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

" From GRB:
" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

" Andrea modifications =====================================================
" Andrea: Draw a red line on column (one char after the textwidth value)
" from http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns/3765575#3765575
if exists('+colorcolumn')
    set colorcolumn=+1
endif

set t_Co=256 " Andrea: enable 256 colors

" Andrea: highlight the line containing the cursor
set cursorline
set history=1001 " I want a big history (the default is only 20 commands)

" Writing text
au BufRead,BufNewFile *.txt setfiletype text
runtime macros/justify.vim  " format with _j
autocmd FileType text setlocal textwidth=0 formatoptions+=w textwidth=78

" Andrea: formatting
set formatoptions+=n " numbered lists
" From GRB: Don't use Ex mode, use Q for formatting
map Q gq

" Andrea: Should open all (almost) level 
set foldlevelstart=20

" Andrea: sane editing configuration:
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set smarttab "Tab insert blanks and backspace eat blanks
set laststatus=2 " show statusline always
set showmatch
set incsearch
set hlsearch     " highlight found word after search

" Andrea: show tabs and spaces:
set listchars=tab:>-,trail:·

" GRB: clear the search buffer when hitting comma then return
nnoremap ,<CR> :nohlsearch<CR>
set switchbuf=useopen
set number
set numberwidth=5

autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab textwidth=78 foldmethod=syntax

" Python configuration
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab textwidth=78 foldmethod=indent
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set formatoptions+=l

" Syntastic for python
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=0


" Completion fall-back for non supported languages
set omnifunc=syntaxcomplete#Complete

"Enable completion
set completeopt=menu,preview,longest,menuone

" GRB: Use emacs-style tab completion when selecting files, etc..
set wildmode=longest,list

" NERDTree
nnoremap <leader>f :NERDTreeToggle<CR>

source ~/dot-files/refactor-support-and-utilities.vim

set autoindent

