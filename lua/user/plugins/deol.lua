return {
  {
    "Shougo/deol.nvim",
    commit = '51d2367d3373457327e583819c00381387b8c51e',
    config = function()
      vim.cmd("source " .. vim.fn.fnameescape(vim.fn.stdpath("config") .. "/vim_config/deol.vim"))
    end,
  },
}
