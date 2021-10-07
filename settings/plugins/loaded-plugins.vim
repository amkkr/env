call plug#begin('~/.local/share/nvim/plugged')
" カラースキーム
Plug 'tomasr/molokai'

" ステータスラインを色付け
Plug 'itchyny/lightline.vim'

" LSP設定集と自動保管
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" LSインストール周り自動化
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" シンタックス、色付け、インデント等
Plug 'sheerun/vim-polyglot'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()
