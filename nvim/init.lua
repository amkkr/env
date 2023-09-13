vim.cmd("runtime! ./config.vim")
vim.cmd("runtime! ./plugins.vim")
vim.cmd("runtime! ./ddc/config.vim")

local capabilities = require("ddc_nvim_lsp").make_client_capabilities()
local lspconfig = require'lspconfig'.denols.setup({
  capabilities = capabilities,
})


