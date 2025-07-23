" defx.nvim 専用の設定ファイル

" キーマップと設定
nnoremap <silent> <Space>f :<C-u>Defx -listed -resume -winwidth=200 -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <Space>t :<C-u>Defx -split=vertical -direction=topleft -resume -columns=mark:indent:icon:filename -winwidth=35 -buffer-name=tab`tabpagenr()`<CR>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR> defx#async_action('open')
  nnoremap <silent><buffer><expr> c defx#do_action('copy')
  nnoremap <silent><buffer><expr> m defx#do_action('move')
  nnoremap <silent><buffer><expr> p defx#do_action('paste')
  nnoremap <silent><buffer><expr> l defx#async_action('open_directory')
  nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N defx#do_action('new_file')
  nnoremap <silent><buffer><expr> dd defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> r defx#do_action('rename')
  nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> > defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> yy defx#do_action('yank_path', ":t")
  nnoremap <silent><buffer><expr> ya defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
  nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
endfunction

call defx#custom#column('filename', {
    \ 'min_width': 80,
    \ 'max_width': 300,
    \ })
