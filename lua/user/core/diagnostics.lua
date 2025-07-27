-- Neovimの診断機能(Diagnostics)に関する設定

-- 診断メッセージの表示設定
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },

  underline = true,

  -- 行末にエラー内容をインライン表示 (virtual_text)
  -- source = "if_many" にすると、複数のLinter/LSPからメッセージがある場合のみソース名を表示
  virtual_text = {
    spacing = 4,
    source = "if_many",
  },

  -- カーソルを合わせたときに、ポップアップウィンドウで詳細を表示
  float = {
    source = "if_many", -- ソース名を表示
    border = "rounded",  -- ウィンドウの枠を角丸に
  },

  -- 入力中は診断を更新しない（パフォーマンス向上）
  update_in_insert = false,
})
