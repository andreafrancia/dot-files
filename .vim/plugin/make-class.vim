function! MakeClass()
    :normal! yy
    :normal! P
    :execute "normal Iclass "
    :s/.new/\rdef initialize/
    :normal ==
    :execute "normal oend"
    :execute "normal oend"
endfunction
command! MakeClass :call MakeClass()
map <leader>make :MakeClass<cr>
