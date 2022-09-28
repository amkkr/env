" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'jsx': ['eslint'],
      \ 'tsx': ['eslint'],
      \ 'vue': ['eslint']
      \ }
let g:ale_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1
