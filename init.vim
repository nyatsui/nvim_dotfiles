
" Init
let s:is_windows = has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction

function! IsMac() abort
  return !s:is_windows && !has('win32unix')
      \ && (has('mac') || has('macunix') || has('gui_macvim')
      \     || (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction

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
 set cursorline
 " 現在の行を強調表示（縦）
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
 set wildignore=*.o,*.obj,*.pyc,*.so,*.dll
 " 折り返し時に表示行単位での移動できるようにする
 noremap j gj
 noremap k gk

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

" Key mapping setttigs
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

" Smart space mapping.
nmap  <Space>   [Space]
nnoremap  [Space]   <Nop>

" The prefix key.
nnoremap    [Window]   <Nop>
nmap    s [Window]

xnoremap <expr> p 'pgv"'.v:register.'y`>'

" map <C-s> to :update
noremap <silent> <C-S>      :update<CR>
inoremap <silent> <C-S>     <Esc>:update<CR>

if exists(':tnoremap')
  tnoremap   <ESC>      <C-\><C-n>
  tnoremap   <C-j>         <C-\><C-n>
  " tnoremap   j<Space>   j
  tnoremap <expr> ;  vimrc#sticky_func()
endif

imap <Nul> <Nop>

" TAB indent
" nnoremap <TAB> >>
" nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv

" Tab
" 新しいタブを一番右に作る
nnoremap <silent> tc :tablast <bar> tabnew<CR>
" タブを閉じる
nnoremap <silent> tq :tabclose<CR>
" 次のタブ
nnoremap <silent> tl :tabnext<CR>
" 前のタブ
nnoremap <silent> th :tabprevious<CR>

" Buffer
noremap <silent> [Window]l :bnext<CR>
noremap <silent> [Window]h :bprevious<CR>

" =============================

" auto group
augroup MyAutoCmd
  autocmd!
  autocmd CursorHold *.toml syntax sync minlines=300
augroup END


" Terminal Setting
if(has('nvim'))
  " Modifiable terminal
  autocmd MyAutoCmd TermOpen * setlocal modifiable
  autocmd MyAutoCmd TermClose * buffer #
endif

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

""
set clipboard=unnamedplus
" set clipboard=unnamed

 if has("mouse") " Enable the use of the mouse in all modes
   set mouse=a
 endif

" code folding settings
" set foldcolumn=0
" set foldmethod=indent       " fold based on indent
" set foldnestmax=10          " deepest fold is 10 levels
" set nofoldenable            " don't fold by default
" set foldlevel=1
" runtime! atom-style-folding.vim

set ttyfast                 " faster redrawing
set lazyredraw

if &compatible
  set nocompatible               " Be iMproved
endif

set backspace=indent,eol,start

command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" python path
let g:python3_host_prog = expand('~/.pyenv/versions/3.5.2/bin/python')
" let g:python_host_prog = expand('~/.pyenv/versions/anaconda-2.4.0/bin/python')
" let g:python_host_prog = expand('/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Resources/Python')
" let g:python3_host_prog = expand('/Library/Frameworks/Python.framework/Versions/3.6/bin/python3')

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
  call dein#call_hook('source')
  call dein#save_state()
endif

autocmd VimEnter * call dein#call_hook('post_source')

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"""
hi Cursor guifg=#121212 guibg=#afd700

colorscheme molokai
syntax on "コードの色分け
" 256色
set t_Co=256
" 背景色
set background=dark

filetype indent on
filetype plugin indent on

" Transparent setting
augroup TransparentBG
  autocmd!
  autocmd VimEnter,Colorscheme * highlight Normal ctermbg=none
  autocmd VimEnter,Colorscheme * highlight NonText ctermbg=none
  autocmd VimEnter,Colorscheme * highlight LineNr ctermbg=none
  autocmd VimEnter,Colorscheme * highlight Folded ctermbg=none
  autocmd VimEnter,Colorscheme * highlight EndOfBuffer ctermbg=none
  autocmd VimEnter,ColorScheme * highlight SignColumn ctermbg=none
  autocmd VimEnter,ColorScheme * highlight VertSplit ctermbg=none
augroup END


augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

" Auto close preview window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

