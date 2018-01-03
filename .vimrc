" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Key mappings {{{
let mapleader=","
let g:ruby_refactoring_map_keys = 0 "0 disables plugin auto mapping
nnoremap <leader><leader> :wa \| :!clear && rspec<CR>
nnoremap <leader>a   :call Automate()<CR>
nnoremap <leader>xp  :call AddExpectTo()<CR>
nnoremap <leader>dou :call PromoteToDouble()<cr>
nnoremap <leader>d   :call <SID>StripTrailingWhitespaces()<CR>
nnoremap <leader>eat :call EatArgument()<cr>
nnoremap <leader>let :call ExtractIntoRspecLet()<cr>
nnoremap <leader>mr  :call MakeRequire()<cr>
nnoremap <leader>gf  :call OpenRequire()<cr>
nnoremap <leader>rel  :RExtractLet<cr>
vnoremap <leader>rem  :RExtractMethod<cr>
vnoremap <leader>rv  :call ExtractVariable()<cr>
nnoremap <leader>ri  :call InlineVariable()<cr>
nnoremap <leader>mm  :call MakeMethod()<cr>
nnoremap <leader>f   :NERDTreeToggle<CR>
nnoremap <leader>k :Rg<CR>
nnoremap <leader>rg :Rg ""<Left>
nnoremap <leader>t :wa \| :make<CR>
" Latex
nnoremap <leader>ls ciw\lstinline{<c-r>-}<esc>
vnoremap <leader>ls c\lstinline{<c-r>-}<esc>
nnoremap ,verb O\begin{verbatim}<esc>o\end{verbatim}<esc>
" Map ,e and ,v to open files in the same directory as the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
" Map ,n to rename file
map <leader>n :call RenameFile()<cr>
" Asterisk
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)

set switchbuf=useopen
" From GRB: Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w
" From GRB:
" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
function! <SID>StripTrailingWhitespaces()
    " from http://vimcasts.org/episodes/tidying-whitespace/
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" matchit required by nelstrom/vim-textobj-rubyblock
" matchit required by ecomba/vim-ruby-refactoring
runtime macros/matchit.vim
" Load plugins {{{
call plug#begin('~/.vim/plugged')
" Plug 'gi1242/vim-tex-syntax'
Plug 'keflavich/macvim-skim'
Plug 'vim-scripts/DrawIt'
Plug 'tpope/vim-commentary'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'kana/vim-textobj-user'
Plug 'thinca/vim-themis'
Plug 'Lokaltog/vim-powerline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-bundler'
Plug 'kien/ctrlp.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/xoria256.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'haya14busa/vim-asterisk'
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/vim-UT'
Plug '~/vim-automate'
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
set smarttab                      " Tab insert blanks and backspace eat blanks
set laststatus=2                  " show statusline always
set formatoptions-=t              " Do not autowrap by default

" Undo {{
if has('persistent_undo')
    " Keep undo history across sessions by storing it in a file
    set undofile
    " don't pollute working dirs with vim undo files
    " the double slash at the end // tell vim to build undo file names from
    " complete path of the edited file
    set undodir=~/.vim/undo//
    " Vim wont create the directory for you
    silent call system('mkdir -pv ' . &undodir)
endif
" }}

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

" VimScript files {{{
autocmd FileType vim setlocal shiftwidth=2 softtabstop=2 expandtab
" }}}

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

" Plugins Configuratons {{{

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INLINE VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InlineVariable()
    " Copy the variable under the cursor into the 'a' register
    :let l:tmp_a = @a
    :normal "ayiw
    " Delete variable and equals sign
    :normal 2daW
    " Delete the expression into the 'b' register
    :let l:tmp_b = @b
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
    exec ':.s/\<' . @a . '\>/' . escape(@b, "/")
    :let @a = l:tmp_a
    :let @b = l:tmp_b
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
