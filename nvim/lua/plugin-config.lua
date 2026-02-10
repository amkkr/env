-- ============================================
-- Neo-tree (File Explorer)
-- ============================================
require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1,
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "󰜌",
      default = "*",
    },
  },
  window = {
    position = "left",
    width = 30,
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    follow_current_file = {
      enabled = true,
    },
  },
})

-- ============================================
-- Telescope (Fuzzy Finder)
-- ============================================
require('telescope').setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/" },
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        preview_width = 0.5,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
})
-- Load fzf native extension
pcall(require('telescope').load_extension, 'fzf')

-- ============================================
-- Gitsigns (Git Integration)
-- ============================================
require('gitsigns').setup({
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 1000,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
  end
})

-- ============================================
-- Conform (Auto Formatter)
-- ============================================
require("conform").setup({
  formatters_by_ft = {
    -- TypeScript/JavaScript: プロジェクトに応じて自動選択
    -- Biome → Prettier の順で試行 (最初に見つかったものを使用)
    javascript = { "biome", "prettier", stop_after_first = true },
    typescript = { "biome", "prettier", stop_after_first = true },
    javascriptreact = { "biome", "prettier", stop_after_first = true },
    typescriptreact = { "biome", "prettier", stop_after_first = true },
    json = { "biome", "prettier", stop_after_first = true },

    -- その他の言語
    css = { "prettier" },
    html = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    lua = { "stylua" },
    go = { "gofmt" },
    python = { "black" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- ============================================
-- Lualine (Status Line)
-- ============================================
require('lualine').setup({
  options = {
    theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})

-- ============================================
-- Barbar (Buffer/Tab Line)
-- ============================================
require('barbar').setup({
  animation = true,
  auto_hide = false,
  tabpages = true,
  clickable = true,
  icons = {
    buffer_index = false,
    buffer_number = false,
    button = '',
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'E'},
      [vim.diagnostic.severity.WARN] = {enabled = true, icon = 'W'},
      [vim.diagnostic.severity.INFO] = {enabled = false},
      [vim.diagnostic.severity.HINT] = {enabled = false},
    },
    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '~'},
      deleted = {enabled = true, icon = '-'},
    },
    filetype = {
      enabled = true,
    },
    separator = {left = '▎', right = ''},
    modified = {button = '●'},
    pinned = {button = '', filename = true},
    preset = 'default',
    alternate = {filetype = {enabled = false}},
    current = {buffer_index = false},
    inactive = {button = '×'},
    visible = {modified = {buffer_number = false}},
  },
})

print("Plugin configurations loaded successfully")
