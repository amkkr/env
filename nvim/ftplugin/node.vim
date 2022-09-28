set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" In ~/.vim/ftplugin/javascript.vim, or somewhere similar.

" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['prettier', 'eslint']
