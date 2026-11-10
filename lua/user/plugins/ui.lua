return {
  -- ステータスライン
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto', -- カラースキームに合わせる
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
      })
    end,
  },

  -- ファイルエクスプローラー
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({})
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle NvimTree' })
    end,
  },

  { 'tpope/vim-repeat' },
  { 'rhysd/accelerated-jk',
    config = function()
        vim.keymap.set("n", "<silent>j", "<Plug>(accelerated_jk_gj)")
        vim.keymap.set("n", "<silent>k", "<Plug>(accelerated_jk_gk)")
    end,
  },
}
