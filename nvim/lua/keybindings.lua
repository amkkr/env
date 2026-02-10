-- ============================================
-- Keybindings Configuration
-- VSCode-like keybindings for Neovim
-- ============================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================
-- IME: InsertモードからNormalモードに戻る時にIMEをオフにする
-- ============================================
local ime_off
if vim.fn.executable('im-select') == 1 then
  ime_off = function()
    vim.fn.system('im-select com.apple.keylayout.ABC')
  end

  -- Insertモードから抜けた時
  vim.api.nvim_create_autocmd('InsertLeave', { callback = ime_off })
else
  ime_off = function() end
end

-- ============================================
-- Leader key
-- ============================================
vim.g.mapleader = ' '

-- ============================================
-- Buffer Navigation (VSCode Tab-like)
-- ============================================
-- Shift+L / Shift+H: Next/Previous buffer (LazyVim style)
map('n', '<S-l>', ':BufferNext<CR>', opts)
map('n', '<S-h>', ':BufferPrevious<CR>', opts)

-- Close buffer
map('n', '<D-w>', ':BufferClose<CR>', opts)
map('n', '<C-w>', ':BufferClose<CR>', opts)

-- Move buffer position
map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
map('n', '<A->>', ':BufferMoveNext<CR>', opts)

-- Go to buffer in position (like VSCode Cmd+1, Cmd+2, ...)
for i = 1, 9 do
  map('n', '<D-' .. i .. '>', ':BufferGoto ' .. i .. '<CR>', opts)
  map('n', '<A-' .. i .. '>', ':BufferGoto ' .. i .. '<CR>', opts)
end

-- Pin/unpin buffer
map('n', '<A-p>', ':BufferPin<CR>', opts)

-- ============================================
-- File Explorer (Neo-tree)
-- ============================================
-- Cmd+B or Ctrl+B: Toggle file explorer (like VSCode)
map('n', '<D-b>', function() ime_off(); vim.cmd('Neotree toggle') end, opts)
map('n', '<C-b>', function() ime_off(); vim.cmd('Neotree toggle') end, opts)

-- Cmd/Ctrl+Shift+E: Focus file explorer (open if closed)
map('n', '<D-S-e>', function() ime_off(); vim.cmd('Neotree focus') end, opts)
map('n', '<C-S-e>', function() ime_off(); vim.cmd('Neotree focus') end, opts)

-- Reveal current file in explorer
map('n', '<leader>e', ':Neotree reveal<CR>', opts)

-- ============================================
-- Fuzzy Finder (Telescope)
-- ============================================
-- Cmd+P: Find files (like VSCode)
map('n', '<D-p>', ':Telescope find_files<CR>', opts)
map('n', '<C-p>', ':Telescope find_files<CR>', opts)

-- Cmd+Shift+F: Global search (like VSCode)
map('n', '<D-S-f>', ':Telescope live_grep<CR>', opts)
map('n', '<C-S-f>', ':Telescope live_grep<CR>', opts)

-- Ctrl+Tab (alternative): Show buffer list
map('n', '<leader>b', ':Telescope buffers<CR>', opts)

-- Recent files
map('n', '<leader>r', ':Telescope oldfiles<CR>', opts)

-- Git files
map('n', '<leader>gf', ':Telescope git_files<CR>', opts)

-- Symbols
map('n', '<D-S-o>', ':Telescope lsp_document_symbols<CR>', opts)
map('n', '<C-S-o>', ':Telescope lsp_document_symbols<CR>', opts)

-- ============================================
-- Git Integration
-- ============================================
-- Cmd+Shift+G: Open LazyGit (like VSCode SCM view)
map('n', '<D-S-g>', ':LazyGit<CR>', opts)
map('n', '<C-S-g>', ':LazyGit<CR>', opts)

-- Git hunk navigation
map('n', ']c', ':Gitsigns next_hunk<CR>', opts)
map('n', '[c', ':Gitsigns prev_hunk<CR>', opts)

-- Git blame
map('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', opts)

-- Git status (Fugitive)
map('n', '<leader>gs', ':Git<CR>', opts)

-- ============================================
-- LSP Navigation
-- ============================================
-- Go to definition (Cmd+Click in VSCode)
map('n', 'gd', vim.lsp.buf.definition, opts)
map('n', '<D-]>', vim.lsp.buf.definition, opts)

-- Go back/forward (like VSCode)
map('n', '<C-->', '<C-o>', opts)  -- Back
map('n', '<C-=>', '<C-i>', opts)  -- Forward
map('n', '<C-S-->', '<C-i>', opts)
map('n', '<C-S-=>', '<C-i>', opts)

-- Hover documentation
map('n', 'K', vim.lsp.buf.hover, opts)
map('n', '<D-k>', vim.lsp.buf.hover, opts)

-- Show references
map('n', 'gr', vim.lsp.buf.references, opts)
map('n', '<D-S-r>', vim.lsp.buf.references, opts)

-- Rename symbol
map('n', '<F2>', vim.lsp.buf.rename, opts)
map('n', '<leader>rn', vim.lsp.buf.rename, opts)

-- Code actions
map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
map('n', '<D-.>', vim.lsp.buf.code_action, opts)

-- Diagnostics
map('n', '<leader>d', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)

-- ============================================
-- Formatting
-- ============================================
-- Cmd+Shift+I or Alt+Shift+F: Format document (like VSCode)
map('n', '<D-S-i>', function() require("conform").format({ async = true, lsp_fallback = true }) end, opts)
map('n', '<A-S-f>', function() require("conform").format({ async = true, lsp_fallback = true }) end, opts)
map('n', '<leader>f', function() require("conform").format({ async = true, lsp_fallback = true }) end, opts)

-- ============================================
-- Terminal
-- ============================================
-- Cmd+Shift+2: Toggle terminal (like VSCode Cmd+J)
map('n', '<D-S-2>', ':terminal<CR>', opts)
map('n', '<C-`>', ':terminal<CR>', opts)

-- Terminal mode escape
map('t', '<Esc>', '<C-\\><C-n>', opts)

-- ============================================
-- File Operations
-- ============================================
-- Cmd+T or Ctrl+T: New file (like VSCode)
map('n', '<D-t>', ':enew<CR>', opts)
map('n', '<C-t>', ':enew<CR>', opts)

-- Cmd+S: Save (like VSCode)
map('n', '<D-s>', ':w<CR>', opts)
map('n', '<C-s>', ':w<CR>', opts)

-- Cmd+Shift+C: Copy relative file path (like VSCode)
map('n', '<D-S-c>', ':let @+ = expand("%")<CR>', opts)
map('n', '<C-S-c>', ':let @+ = expand("%")<CR>', opts)

-- ============================================
-- Window Management
-- ============================================
-- Split windows
map('n', '<leader>sv', ':vsplit<CR>', opts)
map('n', '<leader>sh', ':split<CR>', opts)

-- Navigate between windows
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- ============================================
-- Quick Actions
-- ============================================
-- Clear search highlight
map('n', '<Esc>', ':noh<CR>', opts)

-- Select all
map('n', '<D-a>', 'ggVG', opts)
map('n', '<C-a>', 'ggVG', opts)

-- Comment toggle (Neovim 0.10+ built-in gc/gcc)
map('n', '<D-/>', 'gcc', { remap = true })
map('n', '<C-/>', 'gcc', { remap = true })
map('v', '<D-/>', 'gc', { remap = true })
map('v', '<C-/>', 'gc', { remap = true })

print("Keybindings loaded successfully")
