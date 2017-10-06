" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

nnoremap ]c :cnext<CR>
nnoremap ,, :wa \| :make<CR>
nnoremap [c :cprev<CR>
set efm=\ \ File\ \"%f\"\\,\ line\ %l%.%#
set makeprg=nosetests

" Load plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'Lokaltog/vim-powerline'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/ack.vim'
Plug 'vim-scripts/xoria256.vim'
call plug#end()
" }}}

let g:Powerline_symbols = 'fancy'
" Behaviour {{{
set history=10000   " I want a big history (the default is only 50 commands)
set hidden          " Allow backgrounding buffers, even unsaved ones

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif
" }}}
" Editing {{{
set backspace=indent,eol,start    " allow backspacing over everything in
                                  " insert mode
set autoindent
set expandtab
set tabstop=8                     " Real TABs stops at 8 period.
set shiftwidth=4
set softtabstop=4
set smarttab                      " Tab insert blanks and backspace eat blanks
set laststatus=2                  " show statusline always
set formatoptions-=t              " Do not autowrap by default

nnoremap <Leader>u :GundoToggle<CR>
set undofile

" Undo for Ctrl+W and Ctrl+U {{{
" Use:
"  - Ctrl-W to delete the previous word,
"  - Ctrl-U to delete a line, and
" all while remaining in insert mode.
" See comment in http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <silent> <C-W> <C-\><C-O>db
inoremap <silent> <C-U> <C-\><C-O>d0
" }}}
" }}}
" Searching {{{
set showmatch
set incsearch
set hlsearch     " highlight found word after search
set noignorecase  "make searches case-sensitive

" clear the search highlight on normal clear
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

set smartcase
" }}}
" Visualisation {{{
set t_Co=256          " Andrea: enable 256 colors
set foldlevelstart=20 " Andrea: Should open all (almost) level
set listchars=tab:▸\ ,trail:·,eol:¬ " Andrea: show tabs and spaces:
" Andrea: Draw a red line on column (one char after the textwidth value)
if exists('+colorcolumn') | set colorcolumn=+1 | endif
set background=dark
colorscheme xoria256

set cursorline       " Andrea: highlight the line containing the cursor
set ruler            " show the cursor position all the time
set showcmd          " display incomplete commands
set number
set relativenumber
set numberwidth=5
set scrolloff=4      " Keep more context when scrolling off the end of a
                     " buffer
set nowrap
syntax on

if has("gui_running")
    set guioptions-=T   " hide the toolbar in GUI mode
    set columns=80      " this seems not to work
endif

highlight Folded guibg=white guifg=blue
set foldtext=AFMyFoldText()
function! AFMyFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{'.'{{\d\=', '', 'g')
  return v:folddashes . sub
endfunction

" Andrea: remove trailing spaces from line
nnoremap <leader>d :s/\s\+$//<CR>
vnoremap <leader>d :s/\s\+$//<CR>
" }}}
" Completion {{{
"
" Completion fall-back for non supported languages
set omnifunc=syntaxcomplete#Complete

" Configure completino for buffers
set completeopt=
set completeopt+=menu     " Show menu
set completeopt+=menuone  " Show menu also when there is only one item
set completeopt+=longest  " Complete with the longest match available
set completeopt+=preview  " Show extra information about the the current item
set complete-=t
set complete-=i
"
" Configure the command line completion
set wildchar=<Tab>        " Tab start the completion
set nowildmenu
set wildmode=list:longest
set wildignore+=*.pyc

" }}}
" Specific file formats section {{{

filetype plugin indent on          " Enable file type detection.

" Text files {{{
autocmd BufRead,BufNewFile *.txt setfiletype text
autocmd BufRead,BufNewFile README setfiletype text

autocmd FileType text setlocal formatoptions-=t   " dont autowrap
autocmd FileType text setlocal formatoptions+=n   " recognize numbered lists
autocmd FileType text setlocal shiftwidth=3
autocmd FileType text setlocal softtabstop=2

runtime macros/justify.vim  " format with _j
" }}}

" Markdown {{{
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd FileType markdown setlocal shiftwidth=4 softtabstop=4 expandtab
                                 \ formatoptions-=t
" }}}

autocmd BufEnter /private/tmp/crontab.* setlocal backupcopy=yes

" }}}
" Directory for swap files and backups {{{
set backup		" keep a backup file
" Store temporary files in a central spot :
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp  " where to put backups
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp  " where to put swapfile
autocmd FocusLost * :wa  "save on focus lost
" }}}

" QuickFix {{{
nnoremap ,t :wa \| :make<CR>
nnoremap ,l :wa \| :lmake<CR>
set switchbuf=useopen
nnoremap <c-j> :cprevious <CR>
nnoremap <c-k> :cnext <CR>
" }}}
" Plugins Configuratons {{{

" Syntastic {{{


" Key mappings {{{
"
let mapleader=","

" Map ,f to toggle NERDTree
nnoremap <leader>f :NERDTreeToggle<CR>

" Map ,e and ,v to open files in the same directory as the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Map ,n to rename file
map <leader>n :call RenameFile()<cr>

" Refactoring
vnoremap <leader>rv :call ExtractVariable()<cr>
nnoremap <leader>ri :call InlineVariable()<cr>

" }}}

" ============================================================================
" Function definitions
" ============================================================================

function! ExtractVariable()
    let name = input("Variable name: ")
    if name == ''
        return
    endif
    " Enter visual mode (not sure why this is needed since we're already in
    " visual mode anyway)
    normal! gv

    " Replace selected text with the variable name
    exec "normal c" . name
    " Define the variable on the line above
    exec "normal! O" . name . " = "
    " Paste the original selected text to be the variable value
    normal! $p
endfunction

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

function! InlineVariable()
    " Copy the variable under the cursor into the 'a' register
    " XXX: How do I copy into a variable so I don't pollute the registers?
    :normal "ayiw
    " It takes 4 diws to get the variable, equal sign, and surrounding
    " whitespace. I'm not sure why. diw is different from dw in this respect.
    :normal 4diw
    " Delete the expression into the 'b' register
    :normal "bd$
    " Delete the remnants of the line
    :normal dd
    " Go to the end of the previous line so we can start our search for the
    " usage of the variable to replace. Doing '0' instead of 'k$' doesn't
    " work; I'm not sure why.
    normal k$
    " Find the next occurence of the variable
    exec '/\<' . @a . '\>'
    " Replace that occurence with the text we yanked
    exec ':.s/\<' . @a . '\>/' . @b
endfunction

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
" }}}
" Some commands {{{
" From GRB: Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w
command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>
" Andrea: formatting
map Q gq
" From GRB:
" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
" }}}
