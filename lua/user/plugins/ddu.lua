return {
  {
    "Shougo/ddu.vim",
    -- ddu.tomlに記載されていたプラグインをすべて依存関係に追加
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddu-commands.vim",
      -- UI
      "Shougo/ddu-ui-ff",
      "Shougo/ddu-ui-filer",
      -- Kind
      "Shougo/ddu-kind-file",
      "Shougo/ddu-kind-word",
      -- Source
      "shun/ddu-source-buffer",
      "Shougo/ddu-source-file",
      "Shougo/ddu-source-file_rec",
      "Shougo/ddu-source-file_old",
      "Shougo/ddu-source-file_point",
      "Shougo/ddu-source-line",
      "Shougo/ddu-source-register",
      "Shougo/ddu-source-action",
      "matsui54/ddu-source-file_external",
      "matsui54/ddu-source-command_history",
      "shun/ddu-source-rg",
      "mikanIchinose/ddu-source-markdown",
      "kuuote/ddu-source-mr",
      "lambdalisue/mr.vim", -- ddu-source-mrの依存関係
      -- Filter
      "Shougo/ddu-filter-matcher_substring",
      "Shougo/ddu-filter-matcher_relative",
      "Shougo/ddu-filter-matcher_hidden",
      "Shougo/ddu-filter-sorter_alpha",
      "Shougo/ddu-filter-converter_display_word",
      -- Column
      "Shougo/ddu-column-filename",
    },
    config = function()
      local map = vim.keymap.set
      local cmd = vim.api.nvim_create_user_command
      local group = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd
      local fn = vim.fn

      --======================================================================
      -- ddu グローバル設定
      --======================================================================
      fn["ddu#custom#patch_global"]({
        ui = "ff", -- デフォルトUI
        sourceOptions = {
          _ = {
            ignoreCase = true,
            matchers = { "matcher_substring" },
          },
          file_rec = {
            matchers = { "matcher_substring", "matcher_hidden" },
          },
        },
        kindOptions = {
          file = {
            defaultAction = "open",
          },
        },
        filterParams = {
          matcher_substring = {
            highlightMatched = "Search",
          },
        },

        uiParams = {
          ff = {
            split = "floating",
            autoResize = false,
            winHeight = 20,
            winWidth = 80,
            previewSplit = "vertical",
            previewWidth = 60,
          },
          filer = {
            split = "no",
            toggle = true,
          },
        },
        sourceParams = {
          rg = {
            args = { "--ignore-case", "--column", "--no-heading", "--color", "never" },
          },
        },
      })

      --======================================================================
      -- カスタムコマンド
      --======================================================================
      cmd("DduRgLive", function()
        fn["ddu#start"]({
          volatile = true,
          sources = { { name = "rg", options = { matchers = {} } } },
          uiParams = { ff = { ignoreEmpty = false } },
        })
      end, {})

      --======================================================================
      -- グローバルキーマップ (ddu起動)
      --======================================================================
      --======================================================================
      ---@param name string
      ---@return boolean
      local function toggle_hidden(name)
        local current_options = fn["ddu#custom#get_current"](vim.b.ddu_ui_name)
        local source_options = current_options.sourceOptions or {}
        local source_options_name = source_options[name] or {}
        local matchers = source_options_name.matchers or {}
        return #matchers == 0
      end

      ---@param ui_name string
      ---@param param_name string
      ---@return boolean
      local function toggle_ui_param(ui_name, param_name)
        local current_options = fn["ddu#custom#get_current"](vim.b.ddu_ui_name)
        local ui_params = current_options.uiParams or {}
        local ui_params_name = ui_params[ui_name] or {}
        local param_value = ui_params_name[param_name] or false
        return not param_value
      end

      --======================================================================
      -- ddu 起動キーマップ
      --======================================================================
      local function launch_filer(options)
        options = options or {}
        local launch_options = {
          ui = "filer",
          name = "filer-" .. fn.win_getid(),
          resume = true,
          sync = options.sync or false,
          sources = {
            {
              name = "file",
              params = {
                path = vim.t.ddu_ui_filer_path or fn.getcwd(),
              },
              options = {
                columns = { "filename" },
              },
            },
          },
          uiParams = {
            filer = {
              autoResize = options.autoResize or false,
              split = options.split or "no",
            },
          },
        }
        fn["ddu#start"](launch_options)
      end

      map("n", "<leader>f", function() launch_filer() end, { silent = true, noremap = true, desc = "Launch filer" })
      map("n", "<leader>v", function()
        launch_filer({ sync = true, autoResize = true, split = "vertical" })
      end, { silent = true, noremap = true, desc = "Launch vertical filer" })

      map("n", "sp", "<Cmd>Ddu buffer file_rec<CR>", { silent = true, desc = "DDU: Buffer & FileRec" })
      map("n", "sm", "<Cmd>Ddu mr<CR>", { silent = true, desc = "DDU: Most Recently Used" })
      map("n", "sg", function()
        local input = fn.input("Grep pattern: ")
        if input ~= "" then
          fn["ddu#start"]({ name = "search-rg", sources = { { name = "rg", params = { input = input } } } })
        end
      end, { desc = "DDU: Live Grep" })
      map("n", "s/", "<Cmd>Ddu -name=search line -resume=v:false<CR>", { desc = "DDU: Search current buffer" })
      map("n", "s*", "<Cmd>Ddu -name=search line -resume=v:false -input=`expand('<cword>')`<CR>", { desc = "DDU: Search word under cursor" })
      map("n", "sn", "<Cmd>Ddu -name=search -resume<CR>", { desc = "DDU: Resume search" })

      --======================================================================
      -- dduウィンドウ内でのキーマップ
      --======================================================================
      local ddu_keymaps_group = group("DduKeymaps", { clear = true })

      autocmd("User", {
        group = ddu_keymaps_group,
        pattern = "Ddu:uiReady",
        callback = function(ctx)
          if ctx.data and (ctx.data.name == "ff" or ctx.data.name == "filer") then
            -- UIの準備ができたら、入力のためのコマンドラインを開くアクションを実行
            vim.cmd("call ddu#ui#do_action('openFilterWindow')")
          end
        end,
      })

      -- 2. コマンドライン入力中のキーマップを設定
      autocmd("User", {
        group = ddu_keymaps_group,
        -- ドキュメントで推奨されている新しいautocmdパターン
        pattern = "Ddu:uiOpenFilterWindow",
        callback = function()
          -- 'c'はコマンドラインモードのマッピング
          -- <Cmd>を使うことで、コマンドラインモードを抜けずにdduのアクションを実行できる
          map("c", "<C-g>", "<Cmd>call ddu#ui#do_action('cursorNext')<CR>", { silent = true, buffer = true, noremap = true })
          map("c", "<C-t>", "<Cmd>call ddu#ui#do_action('cursorPrevious')<CR>", { silent = true, buffer = true, noremap = true })
          map("c", "<CR>", "<Cmd>call ddu#ui#do_action('itemAction')<CR><Esc>", { silent = true, buffer = true, noremap = true })
        end,
      })

      -- ddu-ff (Floating Filter) UI用
      autocmd("FileType", {
        group = ddu_keymaps_group,
        pattern = "ddu-ff",
        callback = function()
          map("n", "<CR>", "<Cmd>call ddu#ui#do_action('itemAction')<CR>", { silent = true, buffer = true, noremap = true})
          map("n", "<Space>", "<Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>", { silent = true, buffer = true, noremap = true })
          map("n", "i", "<Cmd>call ddu#ui#do_action('openFilterWindow')<CR>", { silent = true, buffer = true, noremap = true })
          map("n", "q", "<Cmd>call ddu#ui#do_action('quit')<CR>", { silent = true, buffer = true, noremap = true })
        end,
      })

     -- autocmd("User", {
     --    group = ddu_keymaps_group,
     --    pattern = "Ddu:uiDone",
     --    nested = true, -- autocmdの中から他のautocmdをトリガーできるようにする
     --    callback = function()
     --        fn["ddu#ui#async_action"]("openFilterWindow")
     --    end,
     --  })

      -- ファイルの自動更新チェック
      autocmd({ "TabEnter", "WinEnter", "CursorHold", "FocusGained" }, {
        group = ddu_keymaps_group,
        pattern = "*",
        callback = function()
          fn["ddu#ui#do_action"]("checkItems")
        end,
      })

      -- ddu-filer (ファイラ) UI用
      autocmd("FileType", {
        group = ddu_keymaps_group,
        pattern = "ddu-filer",
        callback = function()
          -- local nmap_buf = function(lhs, rhs, desc)
          --   map("n", lhs, rhs, { silent = true, buffer = true, noremap = true, desc = desc })
          -- end
          -- local do_action = function(name, params)
          --   fn["ddu#ui#do_action"]("itemAction", vim.tbl_extend("force", { name = name }, params or {}))
          -- end
          --
          -- nmap_buf("h", function() do_action("narrow", { path = ".." }) end, "Parent directory")
          -- nmap_buf("l", function() do_action("narrow") end, "Narrow into directory")
          -- nmap_buf("<CR>", function()
          --   local item = fn["ddu#ui#get_item"]()
          --   if item and item.isTree then
          --     do_action("expand_tree", { mode = "toggle" })
          --   else
          --     do_action("open")
          --   end
          -- end, "Open or Expand")
          --
          -- nmap_buf("c", function() do_action("copy") end, "Copy")
          -- nmap_buf("m", function() do_action("move") end, "Move")
          -- nmap_buf("p", function() do_action("paste") end, "Paste")
          -- nmap_buf("dd", function() do_action("delete", { trash = true }) end, "Trash item")
          -- nmap_buf("r", function() do_action("rename") end, "Rename")
          -- nmap_buf("K", function() do_action("newDirectory") end, "New directory")
          -- nmap_buf("N", function() do_action("newFile") end, "New file")
          -- nmap_buf("x", function() do_action("executeSystem") end, "Execute")
          -- nmap_buf("q", function() fn["ddu#ui#do_action"]("quit") end, "Quit")
          -- nmap_buf("<Space>", function() fn["ddu#ui#do_action"]("toggleSelectItem") end, "Toggle select")
          -- nmap_buf("*", function() fn["ddu#ui#do_action"]("toggleSelectAllItems") end, "Toggle select all")
          -- nmap_buf(">", function() fn["ddu#ui#do_action"]("toggleHidden") end, "Toggle hidden files")
          -- nmap_buf("yy", function() do_action("yank", { reg = '"' }) end, "Yank relative path")
          -- nmap_buf("ya", function() do_action("yank", { reg = '"', full = true }) end, "Yank absolute path")

          local nmap_buf = function(lhs, rhs, desc) map("n", lhs, rhs, { silent = true, buffer = true, noremap = true, desc = desc }) end
          local item_action = function(name, params) fn["ddu#ui#do_action"]("itemAction", vim.tbl_extend("force", { name = name }, params or {})) end
          local multi_actions = function(actions) fn["ddu#ui#multi_actions"](actions) end

          map("n", "<CR>", function() local item = fn["ddu#ui#get_item"]() if item and item.isTree then item_action("narrow") else item_action("open") end end, { silent = true, buffer = true, noremap = true, expr = false, desc = "Open or narrow" })
          map("n", "l", function() local item = fn["ddu#ui#get_item"]() if item and item.isTree then item_action("narrow") else item_action("open") end end, { silent = true, buffer = true, noremap = true, expr = false, desc = "Open or narrow" })
          nmap_buf(
            "h",
            "<Cmd>call ddu#ui#do_action('itemAction', #{ name: 'narrow', params: #{ path: '..' } })<CR>",
            "Parent directory"
          )
          nmap_buf("c", function() multi_actions({ { "itemAction", { name = "copy" } }, { "clearSelectAllItems" } }) end, "Copy")
          nmap_buf("m", function() item_action("move") end, "Move")
          nmap_buf("p", function() item_action("paste") end, "Paste")
          -- nmap_buf("dd", function() item_action("delete") end, "Delete")
          nmap_buf("dd", function() item_action("delete", { trash = true }) end, "Trash")
          nmap_buf("r", function() item_action("rename") end, "Rename")
          nmap_buf("K", function() item_action("newDirectory") end, "New directory")
          nmap_buf("N", function() item_action("newFile") end, "New file")
          nmap_buf("x", function() item_action("executeSystem") end, "Execute system command")
          nmap_buf("q", function() fn["ddu#ui#do_action"]("quit") end, "Quit")
          nmap_buf("<Space>", function() fn["ddu#ui#do_action"]("toggleSelectItem") end, "Toggle select")
          nmap_buf("*", function() fn["ddu#ui#do_action"]("toggleSelectAllItems") end, "Toggle select all")
          nmap_buf(">", function() multi_actions({ { "updateOptions", { uiParams = { filer = { displayRoot = toggle_ui_param("filer", "displayRoot") } } } }, { "redraw" } }) end, "Toggle display root")
          nmap_buf("u", function() item_action("undo") end, "Undo file operation")
          nmap_buf("o", function() item_action("expand_tree", { mode = "toggle" }) end, "Toggle expand")

          -- nmap_buf("P", function() fn["ddu#ui#do_action"]("togglePreview") end, "Toggle preview")
          -- nmap_buf("i", function() fn["ddu#ui#do_action"]("openFilterWindow") end, "Input filter")
          -- nmap_buf("a", function() fn["ddu#ui#do_action"]("chooseAction") end, "Choose action")
          -- nmap_buf("A", function() fn["ddu#ui#do_action"]("inputAction") end, "Input action")
          -- nmap_buf("O", function() item_action("expand_tree", { maxLevel = -1 }) end, "Expand all")
          -- nmap_buf("D", function() item_action("delete", { trash = true }) end, "Trash")
          nmap_buf("L", function() item_action("link") end, "Create link")
          nmap_buf("~", function() item_action("narrow", { path = fn.expand("~") }) end, "Go to home directory")
          nmap_buf("=", function() item_action("narrow", { path = fn.getcwd() }) end, "Go to current directory")
          nmap_buf("H", function() fn["ddu#start"]({ sources = { { name = "path_history" } } }) end, "Show path history")
          nmap_buf("I", function() item_action("narrow", { path = fn.input("cwd: ", vim.b.ddu_ui_filer_path, "dir") }) end, "Input path to narrow")
          nmap_buf(".", function() multi_actions({ { "updateOptions", { sourceOptions = { file = { matchers = toggle_hidden("file") } } } }, { "redraw", { method = "refreshItems" } } }) end, "Toggle hidden files")
          -- nmap_buf("<C-l>", function() fn["ddu#ui#do_action"]("redraw") end, "Redraw")
          -- nmap_buf("gr", function() item_action("grep") end, "Grep in directory")
          -- nmap_buf("t", function() item_action("open", { command = "tabedit" }) end, "Open in new tab")
          -- nmap_buf("T", function() fn["ddu#ui#do_action"]("cursorTreeTop") end, "Go to tree top")
          -- nmap_buf("B", function() fn["ddu#ui#do_action"]("cursorTreeBottom") end, "Go to tree bottom")
        end,
      })
    end,
  },
}
