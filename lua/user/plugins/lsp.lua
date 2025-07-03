return {
  -- LSPのインストーラー (Mason)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- MasonとLSP設定を繋ぐプラグイン
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      -- require('user.lsp.setup') で共通設定を読み込む
      local lsp_setup = require("user.lsp.setup")

      require("mason-lspconfig").setup({
        -- ここにインストールしたいLSPサーバー名を記述すると自動でインストールされる
        ensure_installed = { "pyright", "lua_ls" },

        -- LSPサーバーごとのセットアップ
        handlers = {
          -- デフォルトのハンドラ。大半のLSPはこれでOK。
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = lsp_setup.on_attach,
              capabilities = lsp_setup.capabilities,
            })
          end,

          -- Python (pyright) 用に特別な設定を上書き
          ["pyright"] = function()
            require("lspconfig").pyright.setup({
              on_attach = lsp_setup.on_attach,
              capabilities = lsp_setup.capabilities,
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic",
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },

  -- LSP設定の本体
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      require("user.lsp.setup")
    end,
  },

  -- 静的解析 (nvim-lint)
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "flake8" },
      }
      -- ファイル保存時に自動でlintを実行
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
