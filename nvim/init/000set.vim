" autoreload setting
set autoread 
set number "line number
syntax enable "syntax color enable
set tabstop=4 "tab size

set expandtab
set smartindent
set shiftwidth=4

set hlsearch
set incsearch

set cmdheight=2
set laststatus=2
set clipboard+=unnamedplus

set encoding=utf-8
set fileencodings=utf-8
set termguicolors
set completeopt=menuone,noinsert

filetype plugin indent on

let mapleader = ","
:tnoremap <Esc> <C-\><C-n>
command! -nargs=* T split | wincmd j | resize 20 | terminal <args>
autocmd TermOpen * startinsert
