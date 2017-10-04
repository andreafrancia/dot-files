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

