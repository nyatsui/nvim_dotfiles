nnoremap <silent> sN :<C-u>call deol#new({'command': 'bash'})<CR>
nnoremap <silent> <Space>s :<C-u>Deol <CR>
nnoremap <silent> sD  :<C-u>call deol#kill_editor()<CR>

let g:deol#prompt_pattern = '\w*%'

autocmd FileType deol call s:on_deol()
function! s:on_deol() abort
    nnoremap <silent><buffer> sq sq
endfunction
