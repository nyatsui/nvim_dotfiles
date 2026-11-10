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
  -- j / k を押し続けると加速 (表示行単位の gj / gk)
  { 'rhysd/accelerated-jk',
    config = function()
      vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', { silent = true, desc = 'Down (accelerated)' })
      vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', { silent = true, desc = 'Up (accelerated)' })
    end,
  },

  -- easymotion: ss で2文字検索ジャンプ、f で行内の単語へ、sj で行へ
  {
    'easymotion/vim-easymotion',
    keys = {
      { 'ss', '<Plug>(easymotion-s2)', desc = 'EasyMotion: 2-char jump' },
      { 'f', '<Plug>(easymotion-lineanywhere)', mode = { 'n', 'x' }, desc = 'EasyMotion: line anywhere' },
      { 'sj', '<Plug>(easymotion-bd-jk)', desc = 'EasyMotion: jump to line' },
    },
    init = function()
      vim.g.EasyMotion_do_mapping = 0
      vim.g.EasyMotion_smartcase = 1
      vim.g.EasyMotion_use_upper = 1
      vim.g.EasyMotion_keys = 'FJDKSLA;YUITREOPWQVBNCMXZ'
      vim.g.EasyMotion_startofline = 0
      -- f で飛べる位置: 単語の頭と末尾、camelCase の切れ目、_ や # の次
      vim.g.EasyMotion_re_line_anywhere = [[\v(<.|^$)|(.>|^$)|(\l)\zs(\u)|(_\zs.)|(#\zs.)|\|]]
    end,
  },

  -- ファイルを開くとプロジェクトのルート (.git など) へ自動で移動 (そのウィンドウだけ lcd)
  {
    'airblade/vim-rooter',
    lazy = false,
    init = function()
      vim.g.rooter_cd_cmd = 'lcd'
      vim.g.rooter_silent_chdir = 1
    end,
  },
}
