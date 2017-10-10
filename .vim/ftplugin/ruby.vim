function! Automate()
    let line = getline('.')
    let word = expand("<cword>")
    if word =~ '[A-Z][a-zA-Z]*'
        call WriteClass(word)
    elseif word =~ 'new'
        call WriteInitialize()
    else
        echom "dont know what to do with: ". word . ", in ". line
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
nnoremap <leader>a :call Automate()<CR>

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
