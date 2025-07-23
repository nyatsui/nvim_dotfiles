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
-- return {
--   {
--     'Shougo/defx.nvim',
--     dependencies = { 'nvim-tree/nvim-web-devicons' }, -- アイコン表示に
--     config = function()
--       vim.g.defx_icons_enable_nerd_font = 1
-- 
--       -- キーマップ
--       local map = vim.keymap.set
--       map(
--         'n',
--         '<leader>f',
--         '<Cmd>Defx -listed -resume -winwidth=200 -buffer-name=tab`tabpagenr()`<CR>',
--         { desc = 'Defx' }
--       )
--       map(
--         'n',
--         '<leader>t',
--         '<Cmd>Defx -split=vertical -direction=topleft -resume -columns=mark:indent:icon:filename -winwidth=35 -buffer-name=tab`tabpagenr()`<CR>',
--         { desc = 'Defx tree' }
--       )
-- 
--       -- defxバッファ用の設定
--       local defx_group = vim.api.nvim_create_augroup('DefxSettings', { clear = true })
--       vim.api.nvim_create_autocmd('FileType', {
--         group = defx_group,
--         pattern = 'defx',
--         callback = function()
--           local nmap = function(lhs, rhs)
--             vim.keymap.set('n', lhs, rhs, { silent = true, buffer = true, expr = true })
--           end
--           nmap('<CR>', "defx#async_action('open')")
--           nmap('l', "defx#async_action('open_directory')")
--           nmap('h', "defx#do_action('cd', {'..'})")
--           nmap('~', "defx#do_action('cd')")
--           nmap('c', "defx#do_action('copy')")
--           nmap('m', "defx#do_action('move')")
--           nmap('p', "defx#do_action('paste')")
--           nmap('r', "defx#do_action('rename')")
--           nmap('dd', "defx#do_action('remove_trash')")
--           nmap('K', "defx#do_action('new_directory')")
--           nmap('N', "defx#do_action('new_file')")
--           nmap('x', "defx#do_action('execute_system')")
--           nmap('<Space>', "defx#do_action('toggle_select') . 'j'")
--           nmap('*', "defx#do_action('toggle_select_all')")
--           nmap('q', "defx#do_action('quit')")
--           -- 他のキーマップも同様に追加...
--         end,
--       })
--     end,
--   },
-- }
