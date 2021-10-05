call plug#begin('~/.local/share/nvim/plugged')

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/completion-nvim'
set completeopt=menuone,noinsert,noselect
set shortmess+=c

Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'mattn/vim-lsp-settings'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()
