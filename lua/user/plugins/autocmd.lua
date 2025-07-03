local group = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 背景透過設定
local transparent_group = group('TransparentBG', { clear = true })
autocmd({ 'VimEnter', 'ColorScheme' }, {
  group = transparent_group,
  pattern = '*',
  callback = function()
    local highlights = {
      Normal = { guibg = 'NONE' },
      NonText = { guibg = 'NONE' },
      LineNr = { guibg = 'NONE' },
      Folded = { guibg = 'NONE' },
      EndOfBuffer = { guibg = 'NONE' },
      SignColumn = { guibg = 'NONE' },
      VertSplit = { guibg = 'NONE' },
    }
    for hl, val in pairs(highlights) do
      vim.api.nvim_set_hl(0, hl, val)
    end
  end,
})

-- バイナリファイル設定
-- local binary_group = group('Binary', { clear = true })
-- autocmd('BufReadPre', {
--   group = binary_group,
--   pattern = '*.bin',
--   command = 'let &bin=1',
-- })
-- autocmd('BufReadPost', {
--   group = binary_group,
--   pattern = '*.bin',
--   command = 'if &bin | %!xxd | endif',
-- })
-- autocmd('BufReadPost', {
--   group = binary_group,
--   pattern = '*.bin',
--   command = 'set ft=xxd',
-- })
-- autocmd('BufWritePre', {
--   group = binary_group,
--   pattern = '*.bin',
--   command = 'if &bin | %!xxd -r | endif',
-- })
-- autocmd('BufWritePost', {
--   group = binary_group,
--   pattern = '*.bin',
--   command = 'if &bin | %!xxd | set nomod | endif',
-- })

-- プレビューウィンドウを自動で閉じる
-- local preview_close_group = group('PreviewClose', { clear = true })
-- autocmd('InsertLeave', {
--   group = preview_close_group,
--   pattern = '*',
--   command = 'if pumvisible() == 0 | pclose | endif',
-- })

-- Quickfixを自動で閉じる
-- local qf_auto_close_group = group('QfAutoCommands', { clear = true })
-- autocmd('WinEnter', {
--   group = qf_auto_close_group,
--   pattern = '*',
--   command = 'if winnr("$") == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix" | q | endif',
-- })
