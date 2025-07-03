return {
  -- 自動で括弧などを閉じる (nvim-autopairs)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- コメントアウト
  {
    "numToStr/Comment.nvim",
    -- VeryLazyイベントで読み込むことで、起動時のパフォーマンスを向上させます
    event = "VeryLazy",
    config = function()
      -- setup()は必要に応じて呼び出します（通常はデフォルトでOK）
      require("Comment").setup()

      -- ★ こちらが修正後の正しいキーマップ設定です
      local api = require("Comment.api")
      vim.keymap.set({ "n", "v" }, "<C-/>", api.toggle.linewise.current, {
        silent = true,
        noremap = true,
        desc = "Toggle comment",
      })
    end,
  },

  -- 整列
  {
    "junegunn/vim-easy-align",
    -- コマンド実行時、またはキーマップが押されたときに読み込む
    cmd = "EasyAlign",
    keys = { "ga" },
    init = function()
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { desc = "Easy Align" })
    end,
  },

  -- kanaさんのoperator/textobjプラグイン群
  { "kana/vim-operator-user" },
  {
    "kana/vim-operator-replace",
    dependencies = { "kana/vim-operator-user" },
    init = function()
      vim.api.nvim_set_keymap("n", "sr", "<Plug>(operator-replace)", {})
    end,
  },
  {
    "rhysd/vim-operator-surround",
    dependencies = { "kana/vim-operator-user" },
    init = function()
      local map = vim.keymap.set
      map("n", "sa", "<Plug>(operator-surround-append)", { silent = true })
      map("n", "sd", "<Plug>(operator-surround-delete)", { silent = true })
      map("n", "sr", "<Plug>(operator-surround-replace)", { silent = true })
    end,
  },
  { "kana/vim-textobj-user" },
  { "kana/vim-textobj-fold", dependencies = { "kana/vim-textobj-user" } },

  -- その他
  { "editorconfig/editorconfig-vim" },
  { "chrismccord/bclose.vim" },
}
