function! PromoteToDouble()
  let save_cursor = getpos('.')
  let param = expand("<cword>")
  :execute "normal O".param." = double :".param."\<esc>=="
  call setpos('.', save_cursor)
endfunction

command! PromoteToDouble :call PromoteToDouble()
map <leader>dou :PromoteToDouble<cr>

