nnoremap ,mf :call MakeFunction()<CR>
function! MakeFunction()
  let name = expand('<cword>')
  execute "normal O".name."() {\<cr>:\<cr>}"
endfunction
