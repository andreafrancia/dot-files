" Syntastic for python
let g:syntastic_enable_signs=1

" Error list automatic opening:
" 0 - manual
" 1 - auto open and close
" 2 - auto open manual close
let g:syntastic_auto_loc_list=2
let python_space_error_highlight = 1

setlocal shiftwidth=4 softtabstop=4 expandtab
setlocal textwidth=78 foldmethod=indent
setlocal omnifunc=pythoncomplete#Complete
setlocal formatoptions+=l " Do not broke long line
setlocal formatoptions-=t " Do not autowrap
setlocal indentkeys-=:
