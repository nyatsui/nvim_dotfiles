return {
  -- Git差分表示
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = require('gitsigns')
          -- preview_hunkをgpにマッピング
          vim.keymap.set('n', 'gp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
          -- ]c / [c で次 / 前の変更箇所へ (以前の vim-gitgutter と同じキー)
          -- :Gdiff などの差分表示中は Vim 本来の ]c / [c (差分の移動) をそのまま使う
          local function jump(key, dir)
            return function()
              if vim.wo.diff then
                vim.cmd.normal({ vim.v.count1 .. key, bang = true })
              else
                gs.nav_hunk(dir)
              end
            end
          end
          vim.keymap.set({ 'n', 'x' }, ']c', jump(']c', 'next'), { buffer = bufnr, desc = 'Next git hunk' })
          vim.keymap.set({ 'n', 'x' }, '[c', jump('[c', 'prev'), { buffer = bufnr, desc = 'Prev git hunk' })
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
