-- LSPと補完に関するすべての設定をこのファイルに集約

return {
  --------------------------------------------------------------------
  -- LSP関連 (Mason, lspconfig)
  --------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ensure_installed = { "pyright", "lua_ls" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- 依存関係を明記
    },
    config = function()
      -- 1. nvim-cmpと連携するためのcapabilities（機能宣言）
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 2. LSPがアタッチされたときの共通設定 (キーマップなど)
      local on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr, desc = "LSP: " .. desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      end

      -- 3. mason-lspconfigを使ってサーバーをセットアップ
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "lua_ls" },
        handlers = {
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

  --------------------------------------------------------------------
  -- 補完関連 (nvim-cmp)
  --------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  --------------------------------------------------------------------
  -- Linter関連 (nvim-lint)
  --------------------------------------------------------------------
  --{ "mfussenegger/nvim-lint",
  --  config = function()
  --      require("lint").linters_by_ft.python = {}
  --  end
  --},
  --{
  -- "rshkarin/mason-nvim-lint",
  -- dependencies = { "mason.nvim", "nvim-lint" },
  --},
}
