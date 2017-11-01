" Tell ruby syntax to highlight trailing whitespaces (:help ruby_space_errors)
let ruby_space_errors = 1

" Make gf working for requires filenames

set path^=spec
set path^=lib
compiler rspec


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
