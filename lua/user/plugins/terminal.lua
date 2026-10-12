return {
  {
    "Shougo/ddt.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddu.vim",
      "Shougo/ddt-ui-terminal"
    },
    config = function()
        vim.cmd("source " .. vim.fn.fnameescape(vim.fn.stdpath("config") .. "/vim_config/ddt.vim"))
    end,
  },
}
