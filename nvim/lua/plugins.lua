vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()
  -- Packer can manage itself
  -- @see https://github.com/wbthomason/packer.nvim
  use { "wbthomason/packer.nvim", opt = true }

  -- gruvbox color scheme
  -- @see https://github.com/ellisonleao/gruvbox.nvim
  use { "ellisonleao/gruvbox.nvim" }

end)

