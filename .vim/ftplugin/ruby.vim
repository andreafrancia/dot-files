function! Automate()
    let line = getline('.')
    let class_name = expand("<cword>")
    if line =~ 'describe.*'
        call WriteClass(class_name)
    elseif class_name =~ '[A-Z][a-zA-Z]*'
        call WriteClass(class_name)
    else
        echom "dont know: ".line
    endif
endfunction
function! WriteClass(class_name)
    execute "normal! Oclass ".a:class_name."\<cr>end"
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
