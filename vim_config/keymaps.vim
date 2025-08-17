xnoremap <expr> p 'pgv"'.v:register.'y`>'
nmap <Esc><Esc> :nohlsearch<CR><Esc>

if exists(':tnoremap')
  tnoremap   <ESC>      <C-\><C-n>
  tnoremap   <C-w>         <C-\><C-n><C-w>p
  tnoremap   <C-j>         <C-\><C-n><C-^>
endif

inoremap <C-y> <C-o>P
cnoremap <C-y> <C-r>+
