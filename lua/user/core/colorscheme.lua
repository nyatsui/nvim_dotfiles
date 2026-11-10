-- カラースキーム: molokai (colors/molokai.vim)
-- 色の上書きは molokai を読み込むたびに当て直す（:colorscheme molokai をやり直しても消えないように）
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('UserMolokai', { clear = true }),
  pattern = 'molokai',
  callback = function()
    local hi = function(s) vim.cmd('highlight ' .. s) end
    -- コメントは見やすい緑に
    hi('Comment guifg=#008800 ctermfg=40')
    -- Visual選択・カーソル行・検索の色
    hi('Visual guibg=#303030 ctermbg=236 guifg=NONE ctermfg=NONE')
    hi('CursorLine guibg=#303030 ctermbg=236 gui=NONE cterm=NONE')
    hi('Search guibg=#767676 ctermbg=243 guifg=NONE ctermfg=NONE')
    -- 背景透過
    for _, g in ipairs({ 'Normal', 'NonText', 'LineNr', 'Folded', 'EndOfBuffer', 'SignColumn', 'WinSeparator' }) do
      hi(g .. ' guibg=NONE ctermbg=NONE')
    end
  end,
})

if not pcall(vim.cmd.colorscheme, 'molokai') then
  vim.notify('colorscheme molokai が見つかりません', vim.log.levels.WARN)
end
