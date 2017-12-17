" setting
 "文字コードをUFT-8に設定
 set fenc=utf-8
 " バックアップファイルを作らない
 set nobackup
 " スワップファイルを作らない
 set noswapfile
 " 編集中のファイルが変更されたら自動で読み直す
 set autoread
 " バッファが編集中でもその他のファイルを開けるように
 set hidden
 " 入力中のコマンドをステータスに表示する
 set showcmd

 " 見た目系
 " 行番号を表示
 set number

 set ruler " Show the line and column numbers of the cursor.

 " 現在の行を強調表示
 hi CursorLine   cterm=underline ctermbg=NONE ctermfg=NONE "guibg=lightgrey guifg=white
 set cursorline
 " 現在の行を強調表示（縦）
 hi CursorColumn cterm=NONE ctermbg=NONE ctermfg=NONE "guibg=lightgrey guifg=white
 set cursorcolumn
 " 行末の1文字先までカーソルを移動できるように
 set virtualedit=onemore
 " インデントはスマートインデント
 set smartindent
 " ビープ音を可視化
 set visualbell
 " 括弧入力時の対応する括弧を表示
 set showmatch
 " ステータスラインを常に表示
 set laststatus=2
 " コマンドラインの補完
 set wildmode=list:longest
 " 折り返し時に表示行単位での移動できるようにする
 nnoremap j gj
 nnoremap k gk

"
 " Tab系
 " 不可視文字を可視化(タブが「?-」と表示される)
 set list listchars=tab:\?\-
 " Tab文字を半角スペースにする
 set expandtab
 " 行頭以外のTab文字の表示幅（スペースいくつ分）
 set tabstop=2
 " 行頭でのTab文字の表示幅
 set shiftwidth=2


 " 検索系
 " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
 set ignorecase
 " 検索文字列に大文字が含まれている場合は区別して検索する
 set smartcase
 " 検索文字列入力時に順次対象文字列にヒットさせる
 set incsearch
 " 検索時に最後まで行ったら最初に戻る
 set wrapscan
 " 検索語をハイライト表示
 set hlsearch
 " ESC連打でハイライト解除
 nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 行を移動
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp
" 複数行を移動
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

" emacs key bind in command mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>


 ""
 " set clipboard=unnamedplus
set clipboard=unnamed

 if has("mouse") " Enable the use of the mouse in all modes
   set mouse=a
 endif

" code folding settings
" runtime! atom-style-folding.vim

set ttyfast                 " faster redrawing
set lazyredraw

if &compatible
  set nocompatible               " Be iMproved
endif

set backspace=indent,eol,start

xnoremap <expr> p 'pgv"'.v:register.'y`>'

" map <C-s> to :update
noremap <silent> <C-S>      :update<CR>
" noremap <silent> <C-S>     <Esc><C-C>:update<CR>
" inoremap <silent> <C-S>     <Esc><C-O>:update<CR>
inoremap <silent> <C-S>     <Esc>:update<CR>


"dein Scripts-----------------------------
" プラグインがインストールされるディレクトリ
if exists('g:nyaovim_version')
  let s:dein_cache_path = expand('~/.cache/nyaovim/dein')
elseif has('nvim')
  let s:dein_cache_path = expand('~/.cache/nvim/dein')
else
  let s:dein_cache_path = expand('~/.cache/vim/dein')
endif

" dein.vim 本体
let s:dein_dir = s:dein_cache_path .'/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . 'dein.toml'
  let s:lazy_toml = g:rc_dir . 'dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif


syntax on
filetype indent on
filetype plugin indent on
