local M = {}

M.is_windows = function()
  return vim.fn.has('win32') == 1
end

M.is_mac = function()
  return vim.fn.has('macunix') == 1
end

M.is_linux = function()
  return vim.fn.has('unix') == 1 and not M.is_mac()
end

return M
