" Tell ruby syntax to highlight trailing whitespaces (:help ruby_space_errors)
let ruby_space_errors = 1

" Make gf working for requires filenames

set path^=spec
set path^=lib
compiler rspec

function! Automate()
    let line = getline('.')
    let word = expand("<cword>")
    if word =~ '[A-Z][a-zA-Z]*'
        call WriteClass(word)
    elseif word =~ 'new'
        call WriteInitialize()
    else
        echomsg 'make method'
        call MakeMethod()
    endif
endfunction

function! WriteClass(class_name)
    execute "normal! Oclass ".a:class_name."\<cr>end"
endfunction

function! WriteInitialize()
    normal yy
    normal P
    s/.\{-}new/def initialize
    normal ==
    normal oend
endfunction

function! MakeMethod()
    normal yyPidef 
    normal oend
endfunction

function! AddExpectTo()
  let word = expand('<cword>')
  execute 'normal ciwexpect('.word.').to'
endfunction

setlocal shiftwidth=2 softtabstop=2 expandtab
                               \ textwidth=78 foldmethod=syntax
autocmd BufRead,BufNewFile *_spec.rb compiler rspec
setlocal errorformat=
    \%f:%l:\ %tarning:\ %m,
    \%E%.%#:in\ `load':\ %f:%l:%m,
    \%E%f:%l:in\ `%*[^']':\ %m,
    \%E\ \ \ \ \ \#\ %f:%l:%.%#,
    \%E\ \ %\\d%\\+)%.%#,
    \%C\ \ \ \ \ %m,
    \%-G%.%#
