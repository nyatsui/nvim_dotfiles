local map = vim.keymap.set

-- noremap <silent> を行うためのヘルパー関数
local function noremap(mode, lhs, rhs, desc)
  map(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

vim.g.mapleader = ' '
vim.keymap.set('n', 's', '<Nop>', { noremap = true, silent = true, desc = 's-prefix' })
vim.keymap.set('n', '<leader>', '<Nop>', { noremap = true, silent = true, desc = 'leader-prefix' })

--======================================================================
-- 汎用キーマップ
--======================================================================
-- 基本操作
noremap('n', '<C-S>', '<Cmd>update<CR>', 'Save buffer')
noremap('i', '<C-S>', '<Esc><Cmd>update<CR>', 'Save buffer')

-- 行移動
noremap('n', '<C-Up>', '"zdd<Up>"zP', 'Move line up')
noremap('n', '<C-Down>', '"zdd"zp', 'Move line down')
noremap('v', '<C-Up>', '"zx<Up>"zP`[V`]', 'Move selection up')
noremap('v', '<C-Down>', '"zx"zp`[V`]', 'Move selection down')

-- Emacsライクなキーバインド
map('c', '<C-p>', '<Up>')
map('c', '<C-n>', '<Down>')
map('c', '<C-b>', '<Left>')
map('c', '<C-f>', '<Right>')
map('c', '<C-a>', '<Home>')
map('c', '<C-e>', '<End>')
map('c', '<C-d>', '<Del>')
map('i', '<C-h>', '<Left>')
map('i', '<C-j>', '<Down>')
map('i', '<C-k>', '<Up>')
map('i', '<C-l>', '<Right>')
map('i', '<C-y>', '<C-o>P')

-- ターミナルモード
map('t', '<Esc>', '<C-\\><C-n>')

-- タブ/インデント
noremap('v', '<Tab>', '>gv', 'Indent selection')
noremap('v', '<S-Tab>', '<gv', 'Un-indent selection')

-- ウィンドウ / タブ / バッファ操作
noremap('n', 'se', ':e<CR>', 'Edit file')
noremap('n', 'sq', ':Bclose<CR>', 'Close buffer (bclose)')
noremap('n', 'sQ', ':q<CR>', 'Quit window')
noremap('n', 'tc', ':tablast <bar> tabnew<CR>', 'New tab at last')
noremap('n', 'tq', ':tabclose<CR>', 'Close tab')
noremap('n', 'tl', ':tabnext<CR>', 'Next tab')
noremap('n', 'th', ':tabprevious<CR>', 'Previous tab')
noremap('n', 'sl', ':bnext<CR>', 'Next buffer')
noremap('n', 'sh', ':bprevious<CR>', 'Previous buffer')

-- テキスト操作
noremap('n', 'x', '"_x')
noremap('n', '<CR>', 'mzo<Esc>`z', 'New line below')
noremap('n', 's<CR>', 'mzO<Esc>`z', 'New line above')

-- ハイライトと置換
noremap('n', 'm', function()
  local word = vim.fn.expand('<cword>')
  if word == '' then return end
  vim.fn.setreg('/', '\\<' .. word .. '\\>')
  vim.opt.hlsearch = true
  vim.cmd('normal! nN')
end, 'Highlight word under cursor')

noremap('n', '#', function()
  local word = vim.fn.expand('<cword>')
  if word == '' then return end
  local cmd_str = string.format(":%%s/\\<%s\\>//gc", word)
  local final_keys = cmd_str .. "<Left><Left><Left>"
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(final_keys, true, false, true), 'n', false)
end, 'Replace word under cursor')

map('x', '#', function()
  vim.cmd('normal! gv"zy')
  local selection = vim.fn.getreg('z')
  local pattern = vim.fn.escape(selection, '/\\')
  local cmd_str = string.format(":'<,'>s/%s//gc", pattern)
  local final_keys = cmd_str .. "<Left><Left><Left>"
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>' .. final_keys, true, false, true), 'n', false)
end, { desc = 'Replace selection' })
