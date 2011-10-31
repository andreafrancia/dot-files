" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" For some reason crontab complains if Vim does the backups of the temporary
" file created by "crontab -e"
set backupskip=/tmp/crontab.*

call pathogen#infect()  " Enable pathogen and all its installed bundles
:Helptags               " enable help for pathogen bundles

" Usage section
set hidden              " Allow backgrounding buffers without writing them

" ============================================================================
" Editing
" ============================================================================
set backspace=indent,eol,start    " allow backspacing over everything in 
                                  " insert mode
" Use:
"  - Ctrl-W to delete the previous word,
"  - Ctrl-U to delete a line, and
" all while remaining in insert mode.
" See comment in http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <silent> <C-W> <C-\><C-O>db
inoremap <silent> <C-U> <C-\><C-O>d0

" ============================================================================
" Directory for swap files and backups
" ============================================================================
set backup		" keep a backup file
" Store temporary files in a central spot : 
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp  " where to put backups
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp  " where to put swapfile

filetype plugin indent on          " Enable file type detection.

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" From GRB:
" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" From GRB: Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w
"
" Andrea: formatting
map Q gq

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

" Andrea: Draw a red line on column (one char after the textwidth value)
" from http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns/3765575#3765575
if exists('+colorcolumn') | set colorcolumn=+1 | endif

set t_Co=256 " Andrea: enable 256 colors

set history=65535    " I want a big history (the default is only 20 commands)

set foldlevelstart=20 " Andrea: Should open all (almost) level

" Andrea: sane editing configuration:
set autoindent
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4   
set smarttab        "Tab insert blanks and backspace eat blanks
set laststatus=2    " show statusline always

" ============================================================================
" Searching
" ============================================================================

set showmatch
set incsearch
set hlsearch     " highlight found word after search

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase 
set smartcase

" Andrea: show tabs and spaces:
set listchars=tab:>-,trail:·

" GRB: clear the search buffer when hitting comma then return
nnoremap ,<CR> :nohlsearch<CR>

" ============================================================================
" Visualisation
" ============================================================================

colorscheme xoria256    " Andrea: my colorschme
set cursorline       " Andrea: highlight the line containing the cursor
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set number
set numberwidth=5
set scrolloff=3         " Keep more context when scrolling off the end of a 
                        " buffer
syntax on

if has("gui_running") | set go-=T | endif  " hide the toolbar in GUI mode

" ============================================================================
" Not understood
" ============================================================================
set switchbuf=useopen

" ============================================================================
" Completion
" ============================================================================
"
" Completion fall-back for non supported languages
set omnifunc=syntaxcomplete#Complete

" Configure completino for buffers
set completeopt=
set completeopt+=menu     " Show menu
set completeopt+=menuone  " Show menu also when there is only one item
set completeopt+=longest  " Complete with the longest match available
set completeopt+=preview  " Show extra information about the the current item

" Configure the command line completion
set wildchar=<Tab>        " Tab start the completion
set nowildmenu
set wildmode=list:longest
set wildignore+=*.pyc

" ============================================================================
" Specific file formats section
" ============================================================================

" Javascript files 
au BufRead,BufNewFile Jakefile setfiletype javascript
au BufRead,BufNewFile *.json setfiletype javascript

" Text files configuration
au BufRead,BufNewFile *.txt setfiletype text
au BufRead,BufNewFile README setfiletype text
autocmd FileType text setlocal formatoptions+=w textwidth=78  " wrap at col 78
                             \ formatoptions+=n               " numbered lists
                             \ shiftwidt=3
runtime macros/justify.vim  " format with _j

" Python configuration
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab 
                               \ textwidth=78 foldmethod=indent
                               \ omnifunc=pythoncomplete#Complete
                               \ formatoptions+=l formatoptions-=w

" Ruby files:
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab textwidth=78 foldmethod=syntax

" ============================================================================
" Syntastic
" ============================================================================

" Syntastic for python
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_enable_signs=0
let g:syntastic_auto_loc_list=0

" ============================================================================
" Key mappings
" ============================================================================

" NERDTree
nnoremap <leader>f :NERDTreeToggle<CR>

" ============================================================================

" Map ,e and ,v to open files in the same directory as the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%
" Map \n to rename file
map <leader>n :call RenameFile()<cr>
" Refactoring
vnoremap <leader>rv :call ExtractVariable()<cr>
nnoremap <leader>ri :call InlineVariable()<cr>
map <leader>rm :BikeExtract<cr>

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
