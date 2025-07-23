-- ======================================================================
-- Neovim専用Python仮想環境の設定
-- ======================================================================
local function set_python_host()
  local venv_path = vim.fn.stdpath("config") .. "/.venv"
  local python_executable

  if vim.fn.has("win32") == 1 then
    python_executable = venv_path .. "/Scripts/python.exe"
  else
    python_executable = venv_path .. "/bin/python"
  end

  if vim.fn.executable(python_executable) == 1 then
    vim.g.python3_host_prog = python_executable
  end
end
set_python_host()

-- ======================================================================
--- ★★★ ファイラの切り替えスイッチ ★★★
-- defx.nvim を使いたい場合は true
-- ddu-ui-filer を使いたい場合は false-
vim.g.use_defx = true

-- 他のすべての設定ファイルを読み込む
require('user.core.options')
require('user.core.keymaps')
require('user.plugins') -- lazy.nvimのセットアップとプラグイン読み込み
