"-------------------------
" 初期設定
"-------------------------

set number             "行番号を表示
set autoindent         "改行時に自動でインデントする
set tabstop=4          "タブを何文字の空白に変換するか
set shiftwidth=4       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set whichwrap=b,s,h,l,<,>,[,],~ "行頭、行末で行のカーソル移動を可能にする
set backspace=indent,eol,start "バックスペースでの行移動を可能にする
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮ "不可視文字の指定
set virtualedit=onemore "カーソルを行末の一つ先まで移動可能にする
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set smartindent        "改行入力行の末尾にあわせてインデントを増減する
set pumheight=10       "補完メニューの高さ
set mouse=a            "mouseスクロールONに
set ttymouse=xterm2    "mouseスクロールONに


"検索設定
set ignorecase         "大文字、小文字の区別をしない
set smartcase          "大文字が含まれている場合は区別する
set wrapscan           "検索時に最後まで行ったら最初に戻る
set hlsearch           "検索した文字を強調
set incsearch          "インクリメンタルサーチを有効にする


" 日本語文字化けへの対応
set fenc=utf-8
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
lang en_US.UTF-8

" カッコの自動補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

" カーソルの位置の記憶
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif
augroup END

"-------------------------
" keymap
"-------------------------

"===== キー入力 =====
"方向キーの無効化 
"noremap <Up> <Nop>
"noremap <Down> <Nop>
"noremap <Left> <Nop>
"noremap <Right> <Nop>
"inoremap <Up> <Nop>
"inoremap <Down> <Nop>
"inoremap <Left> <Nop>
"inoremap <Right> <Nop>

"入力モード時にcontrolキーを押しながら、h,j,k,lでカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"jキーを二度押しでESCキー
inoremap <silent> jj <Esc>
inoremap <silent> jj <ESC>

"===== その他 =====
set history=100         "履歴を100件保存
set clipboard+=unnamed  "コピーしたときはクリップボードを使用
set nobackup            "バックアップファイルを作らない
set noswapfile          "スワップファイルを作らない
set autoread    "編集中のファイルが変更されたら、自動的に読み込み直す

"モードによってカーソルを変更
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"-------------------------
" Vim plugin
"-------------------------

call plug#begin('~/.vim/plugged')
  Plug 'rust-lang/rust.vim'

  " Language Servers for vim-lsp.
  " 対応したいファイルをvimで開いて"LspInstallServer をコマンドするだけ
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'itchyny/lightline.vim'
  Plug 'morhetz/gruvbox'

  Plug 'lambdalisue/fern.vim'
  Plug 'yuki-yano/fern-preview.vim'
call plug#end()

"=========================
" Plugin の設定
"=========================

set laststatus=2
set noshowmode

"カラースキームの設定
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
set background=dark


filetype plugin indent on

" 保存時に自動でrustfmt
let g:rustfmt_autosave = 1

"-------------------------
"fernの設定
"-------------------------
" Ctrl+nでファイルツリーを表示/非表示する
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>

" fern-preview.vim 公式リポジトリを参考にキーマップを追加
" pでファイルプレビュー、Ctrl+pでカーソル合うだけで自動プレビュー
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

