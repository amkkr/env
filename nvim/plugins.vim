packadd vim-jetpack
call jetpack#begin()
" bootstrap
Jetpack 'tani/vim-jetpack', {'opt': 1}

" On-demand loading
Jetpack 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Jetpack 'junegunn/fzf.vim'

" color  theme
Jetpack 'morhetz/gruvbox'

" editorconfig plugin
Jetpack 'editorconfig/editorconfig-vim'

" jsx tsx syntax highlight
Jetpack 'leafgarland/typescript-vim'
Jetpack 'peitalin/vim-jsx-typescript'

Jetpack 'neovim/nvim-lspconfig'

" nvim lsp
Jetpack 'mattn/vim-lsp-settings'
Jetpack 'prabirshrestha/vim-lsp'
Jetpack 'Shougo/ddc.vim'
Jetpack 'vim-denops/denops.vim'
Jetpack 'Shougo/ddc-source-around'
Jetpack 'Shougo/ddc-source-nvim-lsp'
Jetpack 'Shougo/ddc-filter-matcher_head'
Jetpack 'Shougo/ddc-filter-sorter_rank'
Jetpack 'Shougo/ddc-filter-converter_remove_overlap'
Jetpack 'uga-rosa/ddc-nvim-lsp-setup'
Jetpack 'Shougo/ddc-ui-native'
Jetpack 'Shougo/pum.vim'
Jetpack 'Shougo/ddc-ui-pum'

call jetpack#end()

colorscheme gruvbox
