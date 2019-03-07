
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Key mappings {{{
let mapleader=","
nnoremap <esc>; ,
nnoremap <leader>f  :NERDTreeToggle<CR>
nnoremap <leader>k  :Rg<CR>
nnoremap <leader>rg :Rg ""<Left>
nnoremap <leader>d  :call <SID>StripTrailingWhitespaces()<CR>
" Map ,e to open files in the same directory of the current file
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

runtime visual-at.vim

" Load plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'elixir-editors/vim-elixir'

set switchbuf=useopen

set splitright 

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

" prevents ecomba/vim-ruby-refactoring auto mapping
let g:ruby_refactoring_map_keys = 0 

" matchit required by nelstrom/vim-textobj-rubyblock
" matchit required by ecomba/vim-ruby-refactoring
runtime macros/matchit.vim

" Language server
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

let g:LanguageClient_serverCommands = {
    \ 'ruby': ['tcp://localhost:7658']
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

autocmd FileType ruby setlocal omnifunc=LanguageClient#complete


" Don't send a stop signal to the server when exiting vim.
" This is optional, but I don't like having to restart Solargraph
" every time I restart vim.
let g:LanguageClient_autoStop = 0


Plug 'tpope/vim-commentary'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'kana/vim-textobj-user'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
" Plug 'mhinz/vim-signify'
Plug 'tpope/vim-bundler'
Plug 'kien/ctrlp.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/xoria256.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'haya14busa/vim-asterisk'

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
" Completion {{{
"
" Completion fall-back for non supported languages
set omnifunc=syntaxcomplete#Complete

" Configure completino for buffers
set completeopt=
set completeopt+=menu     " Show menu
set completeopt+=menuone  " Show menu also when there is only one item
set completeopt+=longest  " Complete with the longest match available
set completeopt-=preview  " Show extra information about the the current item
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

" vimrc autoreload https://superuser.com/a/1120318
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

" }}}

autocmd FileType sh setlocal sts=4 sw=4

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

autocmd FileType ruby nnoremap <leader><leader> :wa \| call LauncRSpec()<CR>
nnoremap <leader>tf  :let g:test_file = 1<cr>
function! LauncRSpec()
  :!clear && rspec
endfunction

vnoremap <leader>rv  :call ExtractVariable()<cr>
nnoremap <leader>ri  :call InlineVariable()<cr>
nnoremap <leader>a   :call Automate()<CR>
nnoremap <leader>xp  :call AddExpectTo()<CR>
nnoremap <leader>dou :call PromoteToDouble()<cr>
nnoremap <leader>eat :call EatArgument()<cr>
nnoremap <leader>let :call ExtractIntoRspecLet()<cr>
nnoremap <leader>mr  :call MakeRequire()<cr>
nnoremap <leader>gf  :call OpenRequire()<cr>
nnoremap <leader>rel  :RExtractLet<cr>
nnoremap <leader>bef  :call ExtractIntoBefore()<cr>
vnoremap <leader>rem  :RExtractMethod<cr>
nnoremap <leader>mm  :call MakeRubyThing('module')<cr>
nnoremap <leader>mf  :call MakeRubyThing('def')<cr>
nnoremap <leader>mc  :call MakeRubyThing('class')<cr>

let g:blockle_mapping = '<Leader>{'
Plug 'jgdavey/vim-blockle'

function! MakeRubyThing(thing_type)
    let save_cursor = getcurpos()
    let thing_name = expand('<cword>')
    let line = getline('.')
    let col = getcurpos()[2]
    execute "normal! O".a:thing_type." ".thing_name."\<cr>end"
    call setpos('.', save_cursor)
    execute "normal! jj"
endfunction

" Tell ruby syntax to highlight trailing whitespaces (:help ruby_space_errors)
let ruby_space_errors = 1

autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab textwidth=78

" Make gf working for requires filenames
if executable('rg')
  set grepprg=rg\ --vimgrep
endif
autocmd FileType ruby setlocal path^=spec path^=lib
function! TestAll()
  call AssertEquals(1,1)
  call AssertEquals('foo/bar/baz', RequireName('lib/foo/bar/baz'))
  call AssertEquals('foo/bar/baz', RequireName('lib/foo/bar/baz.rb'))
  call AssertEquals("require 'foo/bar/baz'", RequireLinePattern('lib/foo/bar/baz.rb'))
endfunction
function! SearchRequireLines(...)
  if a:0 > 0
    let path = a:1
  else
    let path = expand('%')
  endif
  let pattern = RequireLinePattern(path)
  silent! execute "grep! " . shellescape(pattern) . " ."
  cwindow
  redraw!
endfunction
function! RequireLinePattern(path)
  return "require '" . RequireName(a:path) . "'"
endfunction"
function! RequireName(path)
  let tmp = substitute(a:path, "^lib/", "", "")
  return substitute(tmp, ".rb$", "", "")
endfunction
function! AssertEquals(expected, actual)
  if a:expected == a:actual
    echom "PASS"
  else
    throw "FAIL Expected:" . a:expected . ", Actual: " . a:actual
  endif
endfunction

" Adapted from ruby-refactoring vim plugin
function! ExtractIntoRspecLet()
  normal 0
  if empty(matchstr(getline("."), "=")) == 1
    echo "Can't find an assignment"
    return
  end
  normal! dd
  exec "?^\\(RSpec\\.\\)*\\s*\\<\\(describe\\|context\\)\\>"
  normal! $p
  exec 's/\v([a-z_][a-zA-Z0-9_]*) \= (.+)/let(:\1) { \2 }'
  normal V=
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
call plug#end()
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
