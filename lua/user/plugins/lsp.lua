return {
  -- LSP管理のコア
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup({
        -- 自動でインストールしてほしいツールをここに列挙
        ensure_installed = {
          "pyright",  -- Python LSP
          "lua_ls",   -- Lua LSP
          "flake8",   -- Python Linter
        },
      })
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim', 'nvim-lspconfig' },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = { 'mason-lspconfig.nvim', "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities() -- nvim-cmpと連携

      -- on_attach関数 (LSPがバッファにアタッチされたときにキーマップを設定)
      local on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr, desc = 'LSP: ' .. desc })
        end
        map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
        map('n', 'K', vim.lsp.buf.hover, 'Hover')
        map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename')
      end

      -- mason-lspconfigにサーバー設定を任せる
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "lua_ls" },
        handlers = {
          -- デフォルトのハンドラ
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
        },
      })
    end,
  },

  -- 静的解析 (ALEの代替)
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        python = { 'flake8' },
      }
      -- ファイル保存時に自動でlintを実行
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
