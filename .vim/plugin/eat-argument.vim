function! EatArgument()
  let save_cursor = getpos('.')
  let param = expand("<cword>")
  :execute "normal o"."@".param." = ".param."\<esc>=="
  call setpos('.', save_cursor)
endfunction

command! EatArgument :call EatArgument()
map <leader>eat :EatArgument<cr>
