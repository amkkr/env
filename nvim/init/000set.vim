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
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
    
