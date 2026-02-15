-- Load Vim configuration
vim.cmd("runtime! ./config.vim")

-- Check if vim-jetpack is installed
local jetpack_path = vim.fn.stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack'
if vim.fn.isdirectory(jetpack_path) == 0 then
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      vim.notify(
        'vim-jetpack がインストールされていません\n\n' ..
        'インストール:\n' ..
        '  git clone https://github.com/tani/vim-jetpack ' .. jetpack_path,
        vim.log.levels.ERROR
      )
    end,
  })
  require('keybindings')
  return
end

vim.cmd("runtime! ./plugins.vim")

-- Check if plugins are installed, show message if not
local missing = {}
local check_plugins = {
  { mod = 'neo-tree',  name = 'neo-tree.nvim' },
  { mod = 'telescope', name = 'telescope.nvim' },
  { mod = 'gitsigns',  name = 'gitsigns.nvim' },
  { mod = 'conform',   name = 'conform.nvim' },
  { mod = 'lualine',   name = 'lualine.nvim' },
  { mod = 'barbar',    name = 'barbar.nvim' },
  { mod = 'nvim-autopairs', name = 'nvim-autopairs' },
}

for _, plugin in ipairs(check_plugins) do
  local ok, _ = pcall(require, plugin.mod)
  if not ok then
    table.insert(missing, plugin.name)
  end
end

if #missing > 0 then
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      vim.notify(
        '未インストールのプラグインがあります:\n  ' ..
        table.concat(missing, '\n  ') ..
        '\n\n:JetpackSync を実行してください',
        vim.log.levels.WARN
      )
    end,
  })
end

-- Load Lua configurations (pcall to avoid errors if plugins missing)
local ok, err = pcall(require, 'plugin-config')
if not ok then
  vim.notify('plugin-config の読み込みに失敗: ' .. err, vim.log.levels.WARN)
end

require('keybindings')
