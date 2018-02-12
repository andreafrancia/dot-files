" Key mappings
nnoremap <leader><leader> :wa \| :!clear && rspec<CR>
nnoremap <leader>a   :call Automate()<CR>
nnoremap <leader>xp  :call AddExpectTo()<CR>
nnoremap <leader>dou :call PromoteToDouble()<cr>
nnoremap <leader>eat :call EatArgument()<cr>
nnoremap <leader>let :call ExtractIntoRspecLet()<cr>
nnoremap <leader>mr  :call MakeRequire()<cr>
nnoremap <leader>gf  :call OpenRequire()<cr>
nnoremap <leader>rel  :RExtractLet<cr>
vnoremap <leader>rem  :RExtractMethod<cr>
nnoremap <leader>mm  :call MakeMethod()<cr>

" Tell ruby syntax to highlight trailing whitespaces (:help ruby_space_errors)
let ruby_space_errors = 1

" Make gf working for requires filenames
set path^=spec
set path^=lib


compiler rspec

setlocal shiftwidth=2 softtabstop=2 expandtab textwidth=78 foldmethod=syntax
autocmd BufRead,BufNewFile *_spec.rb compiler rspec
setlocal errorformat=
    \%f:%l:\ %tarning:\ %m,
    \%E%.%#:in\ `load':\ %f:%l:%m,
    \%E%f:%l:in\ `%*[^']':\ %m,
    \%E\ \ \ \ \ \#\ %f:%l:%.%#,
    \%E\ \ %\\d%\\+)%.%#,
    \%C\ \ \ \ \ %m,
    \%-G%.%#


