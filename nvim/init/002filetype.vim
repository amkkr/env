augroup filetypedetect
  au BufRead, BufNewFile *.js *.ts setfiletype node
  au BufRead, BufNewFile *.c *,h *.cpp *.hpp *Makefile* *.go setfiletype tab4
  au BufRead, BufNewFile *.py *.pyx setfiletype py
augroup END
