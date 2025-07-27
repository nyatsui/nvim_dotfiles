return {
  -- カラースキーム
  {
    'loctvl842/monokai-pro.nvim',
    priority = 1000,
    config = function()
      require('monokai-pro').setup({
        transparent_background = true, -- 背景透過
        filter = 'pro',
        terminal_colors = true,
        devicons = true, -- highlight the icons of `nvim-web-devicons`
        -- カーソル行やVisual選択、検索の色をここで設定
        custom_highlights = {
          Visual = { bg = '#303030' },
          CursorLine = { bg = '#303030' },
          Search = { bg = '#767676' },
        },
        -- コメントの色
        custom_colors = {
          comment = '#008800',
        },
      })
      vim.cmd.colorscheme('monokai-pro')
    end,
  },

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
