return {
  -- Git差分表示
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        -- preview_hunkをgpにマッピング
        on_attach = function(bufnr)
          vim.keymap.set('n', 'gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
        end,
      })
    end,
  },

  -- fugitive.vim
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', '<cmd>Git<CR>', { desc = 'Git status' })
    end,
  },
}
