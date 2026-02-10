packadd vim-jetpack
call jetpack#begin()
" bootstrap
Jetpack 'tani/vim-jetpack', {'opt': 1}

" ============================================
" File Explorer & Navigation
" ============================================
" File explorer
Jetpack 'nvim-neo-tree/neo-tree.nvim'
Jetpack 'nvim-lua/plenary.nvim'
Jetpack 'nvim-tree/nvim-web-devicons'
Jetpack 'MunifTanjim/nui.nvim'

" Fuzzy finder (keeping fzf for compatibility)
Jetpack 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Jetpack 'junegunn/fzf.vim'
Jetpack 'nvim-telescope/telescope.nvim'
Jetpack 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}

" Buffer/Tab line
Jetpack 'romgrk/barbar.nvim'

" ============================================
" Git Integration
" ============================================
Jetpack 'lewis6991/gitsigns.nvim'
Jetpack 'tpope/vim-fugitive'
Jetpack 'kdheepak/lazygit.nvim'

" ============================================
" UI & Appearance
" ============================================
" Color theme
Jetpack 'morhetz/gruvbox'

" Status line
Jetpack 'nvim-lualine/lualine.nvim'

" ============================================
" Code Formatting & Editing
" ============================================
" Auto formatter
Jetpack 'stevearc/conform.nvim'

" Editorconfig plugin
Jetpack 'editorconfig/editorconfig-vim'

" ============================================
" Language Support
" ============================================
" jsx tsx syntax highlight
Jetpack 'leafgarland/typescript-vim'
Jetpack 'peitalin/vim-jsx-typescript'

" ============================================
" LSP & Completion
" ============================================
" nvim lsp
Jetpack 'williamboman/mason.nvim'
Jetpack 'williamboman/mason-lspconfig.nvim'
Jetpack 'neovim/nvim-lspconfig'

" auto complete
Jetpack 'hrsh7th/cmp-nvim-lsp'
Jetpack 'hrsh7th/cmp-buffer'
Jetpack 'hrsh7th/cmp-path'
Jetpack 'hrsh7th/cmp-cmdline'
Jetpack 'hrsh7th/nvim-cmp'

" For vsnip users.
Jetpack 'hrsh7th/cmp-vsnip'
Jetpack 'hrsh7th/vim-vsnip'
call jetpack#end()

let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) 
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up LSP (vim.lsp.config API for nvim 0.11+)
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  vim.lsp.config('denols', {
    capabilities = capabilities,
    root_markers = { 'deno.json', 'deno.jsonc' },
  })

  vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    root_markers = { 'package.json' },
    workspace = {
      single_file_support = false,
    },
  })

  vim.lsp.config('gopls', {
    capabilities = capabilities,
  })

  vim.lsp.config('intelephense', {
    capabilities = capabilities,
  })

  vim.lsp.enable({ 'denols', 'ts_ls', 'gopls', 'intelephense' })

EOF
