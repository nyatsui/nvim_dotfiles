local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 最終的にlazy.nvimに渡す、空のプラグインリストを作成
local plugins = {}

-- 読み込むプラグイン設定ファイルのリスト
local plugin_config_files = {
  "user.plugins.ui",
  "user.plugins.lsp",
  "user.plugins.cmp",
  "user.plugins.ddu",
  "user.plugins.terminal",
  "user.plugins.ai",
  "user.plugins.git",
  "user.plugins.editing",
}

-- 各ファイルを読み込み、メインのpluginsリストに内容を結合していく
for _, file in ipairs(plugin_config_files) do
  local loaded_plugins = require(file)
  vim.list_extend(plugins, loaded_plugins)
end

require("lazy").setup(plugins, {
  checker = {
    enabled = true,
    notify = true,
  },
  change_detection = {
    enabled = true,
    notify = true,
  },
})
