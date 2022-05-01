call  plug#begin('~/.vim/plug_modules')
    " html emmet
    Plug 'mattn/emmet-vim'	
    
    " configuration LSP
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'	
    
    " Auto complete
    Plug 'Shougo/ddc.vim'
    Plug 'shun/ddc-vim-lsp'	
    Plug 'Shougo/pum.vim'

    " paste space
    Plug 'ConradIrwin/vim-bracketed-paste'

    " enable editorconfig 
    Plug 'editorconfig/editorconfig-vim'
    
    " comment out
    Plug 'scrooloose/nerdcommenter'
    " FileTree
    Plug 'scrooloose/nerdtree'
    Plug 'tani/ddc-fuzzy'
    
    " syntax highlite
    Plug 'leafgarland/typescript-vim'
    
    " statusline color 
    Plug 'itchyny/lightline.vim'

    " fuzzy finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " completion vim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    "Color scheme
    Plug 'morhetz/gruvbox'
    Plug 'shinchu/lightline-gruvbox.vim'

call plug#end()
