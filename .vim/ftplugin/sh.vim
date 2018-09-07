nnoremap ,mf :call MakeFunction()<CR>
vnoremap ,rec :call ExtractCommandInVariable()<CR>
vnoremap ,rea :call ExtractArgumentInVariable()<CR>
nnoremap ,ri :call InlineVariableBash()<CR>

function! MakeFunction()
  let name = expand('<cword>')
  execute "normal O".name."() {\<cr>:\<cr>}"
endfunction

" adding . to iskeyword make CTRL-N complete file names
set iskeyword+=.

function! ExtractArgumentInVariable()
    let name = input("Variable name (BASH): ")
    if name == ''
        return
    endif

    let expression = GetVisualSelection()
    echom expression
    " Replace selected text with the variable name
    exec "normal! gvc" . '"$' . name . '"'
    " Define the variable on the line above
    exec "normal! O" . name . "=" . '"' . expression . '"'
    " Paste the original selected text to be the variable value
endfunction

function! ExtractCommandInVariable()
    let name = input("Variable name (BASH): ")
    if name == ''
        return
    endif

    let expression = GetVisualSelection()
    echom expression
    " Replace selected text with the variable name
    exec "normal! gvc" . "echo " . '"$' . name . '"'
    " Define the variable on the line above
    exec "normal! O" . name . "=" . '"$(' . expression . ')"'
    " Paste the original selected text to be the variable value
endfunction
function! ExtractCommandInVariableBash()
    let name = input("Variable name (BASH): ")
    if name == ''
        return
    endif

    let expression = GetVisualSelection()
    echom expression
    " Replace selected text with the variable name
    exec "normal! gvc" . "echo " . '"$' . name . '"'
    " Define the variable on the line above
    exec "normal! O" . name . "=" . '"$(' . expression . ')"'
    " Paste the original selected text to be the variable value
endfunction

function! InlineVariableBash()
    " Copy the variable under the cursor into the 'a' register
    :let l:tmp_a = @a
    :normal "ayiw
    " Delete variable and equals sign
    exec ':.s/' . @a . '=//'
    " Delete the expression into the 'b' register
    :let l:tmp_b = @b
    :normal "bd$
    let expression = @b
    " Remove the first quote
    let expression = substitute(expression, '^"', '', '')
    " Remove the last quote
    let expression = substitute(expression, '"$', '', '')
    " Delete the remnants of the line
    :normal dd
    " Go to the end of the previous line so we can start our search for the
    " usage of the variable to replace. Doing '0' instead of 'k$' doesn't
    " work; I'm not sure why.
    normal k$
    " Find the next occurence of the variable
    exec '/$\<' . @a . '\>'
    " Replace that occurence with the text we yanked
    exec ':.s/$\<' . @a . '\>/' . escape(expression, "/")
    :let @a = l:tmp_a
    :let @b = l:tmp_b
endfunction

" Synopsis:
"   Param: Optional parameter of '1' dictates cut, rather than copy
"   Returns the text that was selected when the function was invoked
"   without clobbering any registers
function! GetVisualSelection(...) 
  try
    let a_save = @a
    if a:0 >= 1 && a:1 == 1
      normal! gv"ad
    else
      normal! gv"ay
    endif
    return @a
  finally
    let @a = a_save
  endtry
endfunction
