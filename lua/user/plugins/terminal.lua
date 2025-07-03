return {
  {
    "Shougo/ddt.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddu.vim",
    },
    config = function()
      -- ★ ddt.vim を起動するためのキーマップをここで定義
      local noremap = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
      end

      -- 新しいターミナルを開く
      noremap("sN", "<Cmd>Ddt<CR>", "New terminal (ddt)")
      -- 既存のターミナルを再表示/フォーカス
      noremap("ss", "<Cmd>Ddt -resume<CR>", "Resume terminal (ddt)")
    end,
  },
}
