" Promote a variable to an rspec let statement.
"
" Convert lines that look like `x = y` to lines that look like
" `let(:x){ y }`.
"
" From: https://raw.githubusercontent.com/panthomakos/dotfiles/master/.vim/plugin/promote-to-let.vim

function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1){ \2 }/
  :normal ==
endfunction

command! PromoteToLet :call PromoteToLet()
map <leader>let :PromoteToLet<cr>

