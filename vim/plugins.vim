packadd vim-jetpack
call jetpack#begin()
" bootstrap
Jetpack 'tani/vim-jetpack', {'opt': 1}

" On-demand loading
Jetpack 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Jetpack 'tpope/vim-fireplace', { 'for': 'clojure' }
call jetpack#end()

