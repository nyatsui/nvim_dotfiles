
nnoremap [Space]s  <Cmd>call ddt#start(#{
      \   name: 'terminal-' .. win_getid(),
      \   ui: 'terminal',
      \ })<CR>

call ddt#custom#patch_global(#{
      \   uiParams: #{
      \     terminal: #{
      \       nvimServer: '~/.cache/nvim/server.pipe',
      \       command: ['bash'],
      \       promptPattern: has('win32') ? '\f\+>' : '\w*% \?',
      \     },
      \   },
      \ })
