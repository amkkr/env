if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.pyx setfiletype py
  au! BufRead,BufNewFile *.js,*.ts,*.jsx,*.tsx setfiletype node
  au! BufRead,BufNewFile *.c,*.h,*.cpp,*.hpp,*.Makefile*,*.go setfiletype tab4
augroup END
