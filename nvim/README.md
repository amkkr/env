# Neovim Configuration

VSCodeライクな操作性を持つ、モダンなNeovim設定です。

## 🚀 セットアップ手順

### 1. プラグインのインストール

```bash
# Neovimを開く
nvim

# Vimコマンドでプラグインをインストール
:JetpackSync
```

### 2. 外部ツールのインストール

#### macOS (Homebrew)

```bash
# Telescope用のツール
brew install ripgrep fd

# LazyGit
brew install lazygit

# IME自動切替 (macOS、日本語入力用)
brew tap daipeihust/tap && brew install im-select

# フォーマッター (グローバルインストール)
brew install stylua

# TypeScript/JavaScript フォーマッター (どちらか、または両方)
npm install -g prettier        # 従来の標準
npm install -g @biomejs/biome  # 高速・モダン (推奨)

# Python用
pip install black

# Go用 (goが既にインストールされている場合)
go install golang.org/x/tools/cmd/gofmt@latest
```

### 3. LSPサーバーのインストール

Neovimを開いて、以下のコマンドを実行:

```vim
:Mason
```

Masonが開いたら、以下をインストール:
- `typescript-language-server` (TypeScript/JavaScript)
- `lua-language-server` (Lua)
- `gopls` (Go)
- `intelephense` (PHP)

## 📦 インストールされるプラグイン

### ファイル管理
- **neo-tree.nvim** - ファイルエクスプローラ
- **telescope.nvim** - ファジーファインダー (ファイル検索、grep等)
- **barbar.nvim** - バッファ/タブライン

### Git統合
- **gitsigns.nvim** - Git変更表示
- **vim-fugitive** - Git操作
- **lazygit.nvim** - LazyGitインターフェース

### コード編集
- **conform.nvim** - 自動フォーマッター (保存時実行)
- **editorconfig-vim** - EditorConfig対応

### LSP & 補完
- **mason.nvim** - LSPインストーラー
- **nvim-lspconfig** - LSP設定
- **nvim-cmp** - 自動補完

### UI
- **lualine.nvim** - ステータスライン
- **gruvbox** - カラーテーマ

## ⌨️ キーバインド

### バッファ/タブ操作
| キー | 動作 |
|------|------|
| `Shift+L` | 次のバッファ |
| `Shift+H` | 前のバッファ |
| `Cmd/Ctrl+W` | バッファを閉じる |
| `Cmd/Alt+1~9` | バッファ1~9に移動 |

### ファイル操作
| キー | 動作 |
|------|------|
| `Cmd/Ctrl+P` | ファイル検索 |
| `Cmd/Ctrl+Shift+F` | プロジェクト内検索 |
| `Cmd/Ctrl+B` | ファイルエクスプローラ表示/非表示 (閉じると元のファイルに戻る) |
| `Cmd/Ctrl+Shift+E` | ファイルエクスプローラにフォーカス |
| `Ctrl+L` | エクスプローラから元のファイルに戻る (右ウィンドウへ移動) |
| `Cmd/Ctrl+T` | 新規ファイル |
| `Cmd/Ctrl+S` | 保存 |

### Git操作
| キー | 動作 |
|------|------|
| `Cmd/Ctrl+Shift+G` | LazyGitを開く |
| `]c` / `[c` | 次/前の変更箇所に移動 |
| `<leader>gb` | Git blameの表示切替 |

### LSP操作
| キー | 動作 |
|------|------|
| `gd` | 定義にジャンプ |
| `gr` | 参照を表示 |
| `K` | ホバー情報表示 |
| `<F2>` | シンボル名変更 |
| `<leader>ca` | コードアクション |
| `[d` / `]d` | 次/前の診断に移動 |

### ナビゲーション
| キー | 動作 |
|------|------|
| `Ctrl+-` | 戻る |
| `Ctrl+=` | 進む |

### フォーマット
| キー | 動作 |
|------|------|
| `Cmd+Shift+I` | コードフォーマット |
| `<leader>f` | コードフォーマット |

### ターミナル
| キー | 動作 |
|------|------|
| `Cmd+Shift+2` | ターミナルを開く |
| `Ctrl+\`` | ターミナルを開く |
| `Esc` (ターミナル内) | ノーマルモードに戻る |

> `<leader>`キーはデフォルトで`Space`に設定されています

## 🔧 設定ファイル構成

```
nvim/
├── init.lua              # エントリーポイント
├── config.vim            # 基本設定
├── plugins.vim           # プラグイン定義
└── lua/
    ├── plugin-config.lua # プラグイン設定
    └── keybindings.lua   # キーバインド設定
```

## 📝 カスタマイズ

### フォーマッターの自動選択

TypeScript/JavaScriptのフォーマッターは**プロジェクトに応じて自動選択**されます:

1. **Biome** がプロジェクトにあれば → Biomeを使用
2. なければ **Prettier** を使用 → Prettierを使用
3. どちらもなければ → LSPフォーマッターを使用

#### プロジェクトごとの設定例

```bash
# Biomeを使うプロジェクト
npm install --save-dev @biomejs/biome
# または
pnpm add -D @biomejs/biome

# Prettierを使うプロジェクト
npm install --save-dev prettier
# または
pnpm add -D prettier
```

グローバルにインストールしておけば、プロジェクトに設定がない場合も自動フォーマットされます。

### フォーマッターの設定変更

`lua/plugin-config.lua`の`conform.setup`セクションで変更:

```lua
require("conform").setup({
  formatters_by_ft = {
    javascript = { "biome", "prettier", stop_after_first = true },
    typescript = { "biome", "prettier", stop_after_first = true },
    -- 言語を追加...
  },
})
```

### キーバインドの変更

`lua/keybindings.lua`で任意のキーバインドを追加・変更できます。

## 🐛 トラブルシューティング

### プラグインが読み込まれない

```vim
:JetpackSync
:checkhealth
```

### LSPが動作しない

```vim
:LspInfo
:Mason
```

### フォーマッターが動作しない

1. フォーマッターがインストールされているか確認
2. `:ConformInfo`でステータス確認

## 📚 参考リンク

- [Neovim Documentation](https://neovim.io/doc/)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [Conform.nvim](https://github.com/stevearc/conform.nvim)
