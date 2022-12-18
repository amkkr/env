vim.o.background = "dark" -- or "light" for light mode

require("gruvbox").setup({
    contrast = "soft",
    invert_signs = true,
    invert_tabline = true,
    invert_intend_guids = true,
})

vim.cmd([[colorscheme gruvbox]])
