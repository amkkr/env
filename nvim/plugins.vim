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

" 
call jetpack#end()

colorscheme gruvbox

