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
    -- リンク文字 ([...] の中身など)。molokai 標準は暗い灰色で見づらいので水色に
    hi('Underlined guifg=#66D9EF ctermfg=81 gui=underline cterm=underline')
    -- Markdown の [ ] ( ) ` などの記号も、灰色を少し明るく
    for _, g in ipairs({
      'markdownLinkTextDelimiter', 'markdownLinkDelimiter', 'markdownCodeDelimiter',
      '@punctuation.bracket.markdown_inline', '@punctuation.delimiter.markdown_inline',
      '@punctuation.special.markdown',
    }) do
      hi(g .. ' guifg=#BCBCBC ctermfg=250')
    end
    -- 行番号・折りたたみ: molokai 標準の #465457 は透過背景だと沈むので明るい灰色に
    hi('LineNr guifg=#8A8A8A ctermfg=245')
    hi('FoldColumn guifg=#8A8A8A ctermfg=245 guibg=NONE ctermbg=NONE')
    hi('CursorLineFold guifg=#8A8A8A ctermfg=245 guibg=NONE ctermbg=NONE')
    hi('Folded guifg=#A8A8A8 ctermfg=248 guibg=#262626 ctermbg=235')
    -- 差分 (:Gdiff など): 文字は本来の構文色のまま、背景色だけで変更を示す
    -- 変更行と、その中で実際に変わった部分 (DiffText) を見分けられるよう濃さを変える
    hi('DiffAdd guifg=NONE ctermfg=NONE guibg=#13354A ctermbg=24')
    hi('DiffChange guifg=NONE ctermfg=NONE guibg=#33302E ctermbg=236')
    hi('DiffText guifg=NONE ctermfg=NONE guibg=#5C5650 ctermbg=240 gui=bold cterm=bold')
    hi('DiffDelete guifg=#C0396F ctermfg=161 guibg=#2A0016 ctermbg=52')
    -- ポップアップ (LSP の説明、gp の差分プレビューなど) を molokai 寄りの色に
    hi('NormalFloat guifg=#F8F8F2 ctermfg=252 guibg=#232526 ctermbg=235')
    hi('FloatBorder guifg=#808080 ctermfg=244 guibg=#232526 ctermbg=235')
    hi('FloatTitle guifg=#FD971F ctermfg=208 guibg=#232526 ctermbg=235 gui=bold cterm=bold')
    -- 背景透過
    for _, g in ipairs({ 'Normal', 'NonText', 'LineNr', 'Folded', 'EndOfBuffer', 'SignColumn', 'WinSeparator' }) do
      hi(g .. ' guibg=NONE ctermbg=NONE')
    end
  end,
})

if not pcall(vim.cmd.colorscheme, 'molokai') then
  vim.notify('colorscheme molokai が見つかりません', vim.log.levels.WARN)
end
