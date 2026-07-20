-- ============================================
-- Markdown (Buffer-local Settings)
-- ============================================
-- after/ftplugin に置く理由:
-- $VIMRUNTIME/ftplugin/markdown.vim より後に読み込ませるため。
-- 下記の設定項目は現時点では同ファイルと衝突しないが、将来 formatoptions や
-- shiftwidth を追加した場合、通常の ftplugin/ では後勝ちで無効化される。
-- なお同ファイルの expandtab/ts/sts/sw=4 は CommonMark の推奨値であり、
-- 本設定では変更しない (変更したい場合は vim.g.markdown_recommended_style = 0)

-- 表示上の折り返しのみ行う。textwidth は 0 のまま (ハードラップはしない)
-- 注: ランタイム側が formatoptions+=t を設定済みのため、textwidth を立てると
-- 入力中に自動改行が始まり deno fmt の --prose-wrap=preserve と方針が矛盾する
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- 散文では縦線が視覚的に邪魔になるため無効化 (config.vim でグローバル ON)
vim.opt_local.cursorcolumn = false

-- スペルチェック。cjk を付けないと日本語がすべて綴り誤り扱いになる。
-- コードブロック・インラインコード・リンク URL は treesitter の @nospell で
-- 除外されるが、裸の URL とバッククォート無しの技術用語には波線が出る。
-- 邪魔なときは <leader>ms で切り替える
vim.opt_local.spelllang = { "en_us", "cjk" }
vim.opt_local.spell = true

-- ============================================
-- Markdown Keymaps (buffer-local)
-- ============================================
-- TOC は gO、見出し移動は ]] / [[ が NeoVim 標準で提供されるため定義しない
local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = true }

-- レンダリング表示の切替
map("n", "<leader>mp", "<Cmd>RenderMarkdown toggle<CR>", opts)

-- スペルチェックの切替
map("n", "<leader>ms", "<Cmd>setlocal spell!<CR>", opts)

-- このバッファの保存時フォーマットを切替 (他人のリポジトリを開いた時の退避弁)
map("n", "<leader>mf", function()
  vim.b.disable_autoformat = not vim.b.disable_autoformat
  vim.notify(
    "markdown autoformat: " .. (vim.b.disable_autoformat and "OFF" or "ON"),
    vim.log.levels.INFO
  )
end, opts)

-- ============================================
-- Formatter Availability Check
-- ============================================
-- deno も prettier も無い場合、保存しても無言で何も起きない
-- (markdown には LSP が付かないため lsp_format = "fallback" も機能しない)。
-- notify_once で同一メッセージはセッション中1回だけ表示する
if vim.fn.executable("deno") == 0 and vim.fn.executable("prettier") == 0 then
  vim.notify_once(
    "markdown のフォーマッタが見つかりません (deno / prettier)\n" ..
    "  deno のインストール: dvm install\n" ..
    "  GUI 版 NeoVim では PATH に ~/.dvm/bin が入らない場合があります",
    vim.log.levels.WARN
  )
end
