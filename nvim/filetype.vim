if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au BufRead,BufNewFile *.py,*.pyx setfiletype py
  au BufRead,BufNewFile *.js,*.ts,*.jsx,*.tsx,*.json setfiletype node
  au BufRead,BufNewFile *.c,*.h,*.cpp,*.hpp,*.go setfiletype tab4
augroup END
