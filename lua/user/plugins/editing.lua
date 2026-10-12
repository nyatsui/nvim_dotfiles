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
      require("Comment").setup()
      -- Toggle in Op-pending mode
      vim.keymap.set('n', '<C-/>', '<Plug>(comment_toggle_linewise_current)')
      vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)')
      -- Toggle in VISUAL mode
      vim.keymap.set('x', '<C-/>', '<Plug>(comment_toggle_linewise_visual)')
      vim.keymap.set('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)')
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

  -- 整形 (conform.nvim)。保存時の自動整形はしない（会社のコードで無関係な差分を出さないため）。
  -- <leader>cf / :Format で手動整形。選択範囲だけの整形にも対応（ruff_format など範囲対応の整形ツールのみ）。
  -- 整形ツールは :MasonInstall ruff stylua で入れる。プロジェクトの pyproject.toml の設定が使われる。
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "x" },
        desc = "Format buffer / selection",
      },
    },
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
        lua = { "stylua" },
      },
      default_format_opts = { lsp_format = "fallback" },
    },
    init = function()
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local last = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = { start = { args.line1, 0 }, ["end"] = { args.line2, last:len() } }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true, desc = "Format buffer (or range) with conform.nvim" })
    end,
  },

  -- その他
  { "editorconfig/editorconfig-vim" },
  { "chrismccord/bclose.vim" },
}
