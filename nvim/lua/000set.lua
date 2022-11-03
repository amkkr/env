local global_option = vim.o
local window_local_option = vim.wo
local buffer_local_option = vim.bo

global_option.autoread = true
global_option.hlsearch = true
global_option.incsearch = true
global_option.cmdheight = 2
global_option.laststatus = 2
global_option.clipboard = "unnamedplus"

global_option.encoding = "utf-8"
global_option.fileencodings = "utf-8"
global_option.termguicolors = true
global_option.completeopt = "menuone,noinsert"

window_local_option.number = true

buffer_local_option.syntax = "enable"
buffer_local_option.tabstop = 4
buffer_local_option.expandtab = true
buffer_local_option.smartindent = true
buffer_local_option.shiftwidth = 2

vim.cmd("filetype plugin indent on")
