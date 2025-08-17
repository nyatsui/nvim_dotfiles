return {
  {
    "Shougo/defx.nvim",
    enabled = vim.g.use_defx or false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.cmd("source ~/.config/nvim/vim_config/defx.vim")
    end,
  },
}
