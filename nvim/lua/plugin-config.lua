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
    -- Markdown: deno fmt を使用 (CJK の表示幅を考慮してテーブルを整形できる)
    -- 注: stop_after_first は「deno が PATH に無い」場合のみ prettier に落ちる。
    -- 「deno が起動して失敗」した場合は落ちない
    markdown = { "deno_fmt", "prettier", stop_after_first = true },
    lua = { "stylua" },
    go = { "gofmt" },
    python = { "black" },
  },
  formatters = {
    deno_fmt = {
      -- deno fmt の既定は --prose-wrap=always で、英文を80桁で強制改行する
      -- (日本語は分割点が無いため折り返されない)。既存文書の全面書き換えを
      -- 避けるため preserve を渡すが、deno プロジェクト配下では deno.json の
      -- 設定を尊重してフラグを付けない (付けると deno fmt --check が CI で落ちる)。
      -- 引数は必ず append すること。prepend すると
      -- `deno --prose-wrap preserve fmt` となり deno が引数エラーで失敗する
      append_args = function(_, ctx)
        local deno_config = vim.fs.find(
          { "deno.json", "deno.jsonc" },
          { upward = true, path = ctx.dirname }
        )
        if deno_config[1] then
          return {}
        end
        return { "--prose-wrap", "preserve" }
      end,
    },
  },
  -- 保存時の自動フォーマット。
  -- 関数形式の契約: nil / false を返すとスキップ、テーブルを返すと実行。
  -- {} も Lua では truthy なので「無効化したい時は必ず nil を返す」こと。
  -- disable_autoformat は conform の組み込み機能ではなく、この関数で解釈している
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return nil
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})

-- 保存時フォーマットの一時無効化 / 再有効化
--   :FormatDisable   全体を無効化
--   :FormatDisable!  現在のバッファのみ無効化
--   :FormatEnable    再有効化
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { desc = "保存時の自動フォーマットを無効化", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { desc = "保存時の自動フォーマットを有効化" })

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

-- ============================================
-- Render Markdown (In-buffer Markdown Viewer)
-- ============================================
-- conceallevel / concealcursor はこのプラグインがウィンドウ単位で管理するため、
-- ftplugin 側では設定しないこと (rendered=3 / default=vim.o.conceallevel)
require("render-markdown").setup({})

-- ============================================
-- Treesitter (Syntax Highlighting)
-- ============================================
-- main ブランチの API (master の nvim-treesitter.configs は存在しない)。
-- c / lua / markdown / markdown_inline / query / vim / vimdoc は NeoVim 同梱の
-- ため列挙しない。これらの ftplugin は標準で vim.treesitter.start() を呼ぶ
require("nvim-treesitter").setup({})

-- パーサ名 (install 用)
local ts_parsers = {
  "typescript", "tsx", "javascript",
  "go", "gomod", "php", "python",
  "json", "jsonc", "yaml", "toml", "html", "css",
  "bash", "gitcommit", "diff",
}

-- filetype 名 (autocmd 用)。パーサ名と一致しないものがあるため別に持つ
-- 例: tsx パーサ ↔ typescriptreact、javascript パーサ ↔ javascriptreact
local ts_filetypes = {
  "typescript", "typescriptreact", "javascript", "javascriptreact",
  "go", "gomod", "php", "python",
  "json", "jsonc", "yaml", "toml", "html", "css",
  "sh", "bash", "gitcommit", "diff",
}

require("nvim-treesitter").install(ts_parsers)

-- main ブランチはハイライトを自動で有効化しないため FileType で明示する
vim.api.nvim_create_autocmd("FileType", {
  pattern = ts_filetypes,
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

print("Plugin configurations loaded successfully")
