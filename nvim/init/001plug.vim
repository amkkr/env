call  plug#begin('~/.config/nvim/plug_modules')
    " html emmet
    Plug 'mattn/emmet-vim'

    " completion vim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " configuration LSP
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'

    " develop vim plugins for deno
    Plug 'vim-denops/denops.vim'

    " Auto complete
    Plug 'Shougo/ddc.vim'
    Plug 'shun/ddc-vim-lsp'
    Plug 'Shougo/pum.vim'
    Plug 'Shougo/ddc-around'
    Plug 'LumaKernel/ddc-file'
    Plug 'Shougo/ddc-matcher_head'
    Plug 'Shougo/ddc-sorter_rank'
    Plug 'Shougo/ddc-converter_remove_overlap'

    " paste space
    Plug 'ConradIrwin/vim-bracketed-paste'

    " enable editorconfig
    Plug 'editorconfig/editorconfig-vim'

    " comment out
    Plug 'scrooloose/nerdcommenter'

    " FileTree
    Plug 'scrooloose/nerdtree'
    Plug 'tani/ddc-fuzzy'

    " statusline color
    Plug 'itchyny/lightline.vim'

    " fuzzy finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Color scheme
    Plug 'morhetz/gruvbox'
    Plug 'shinchu/lightline-gruvbox.vim'

    " Typescript syntax
    Plug 'Quramy/tsuquyomi', { 'do': 'npm -g install typescript' }

   " Rust Syntax highlite
    Plug 'rust-lang/rust.vim'

    " Go support
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaies' }

    " syntax highlite
    Plug 'leafgarland/typescript-vim'
call plug#end()
