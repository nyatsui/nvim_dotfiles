Guifont! Noto Sans Mono CJK JP Regular:h11
" Guifont! Myrica MM:h11

set linespace=1
let s:fontsize = 11
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "Guifont! Noto Sans Mono CJK JP Regular:h" . s:fontsize
  :echo "Font size:" . s:fontsize
endfunction
noremap<silent> + :call AdjustFontSize(1)<CR>
noremap<silent> - :call AdjustFontSize(-1)<CR>
