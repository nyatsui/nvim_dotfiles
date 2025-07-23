local opt = vim.opt -- 可読性のためのローカル変数

-- ファイルとバックアップ
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.backup = false
opt.swapfile = false
opt.undofile = true -- persistent undoを有効に
opt.undodir = vim.fn.stdpath('cache') .. '/undo'
opt.autoread = true -- ファイルが外部で変更されたら自動で読み込む
opt.hidden = true -- バッファを隠すのを許可

-- UI関連
opt.number = true -- 行番号
opt.relativenumber = false -- 相対行番号
opt.cursorline = true -- カーソル行をハイライト
opt.cursorcolumn = true -- カーソル列をハイライト
opt.scrolloff = 8 -- スクロール時に上下8行の余裕を保つ
opt.laststatus = 3 -- グローバルステータスラインを常に表示
opt.showcmd = true -- 入力中のコマンドを表示
opt.ruler = true -- ルーラーを表示
opt.splitbelow = true -- 水平分割時に新しいウィンドウを下に
opt.splitright = true -- 垂直分割時に新しいウィンドウを右に
opt.visualbell = true -- ビープ音の代わりに画面を点滅
opt.list = true -- 不可視文字を表示
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- タブとインデント
opt.expandtab = true -- タブをスペースに展開
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

-- 検索
opt.ignorecase = true -- 大文字小文字を無視
opt.smartcase = true -- 大文字が含まれていれば区別
opt.incsearch = true -- インクリメンタルサーチ
opt.hlsearch = true -- 検索結果をハイライト

-- その他
opt.mouse = 'a' -- マウスをすべてのモードで有効に
opt.clipboard = 'unnamedplus' -- OSのクリップボードと連携
opt.virtualedit = 'onemore,block'
opt.compatible = false -- Be iMproved!
opt.lazyredraw = true -- 描画を遅延させてパフォーマンス向上

-- ESCキーの連打で検索ハイライトを消す
vim.keymap.set('n', '<Esc><Esc>', '<Cmd>nohlsearch<CR>', { silent = true })
