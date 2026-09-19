# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

個人の環境設定リポジトリ(dotfiles)。macOSとLinuxのシェル、ターミナル、エディタ設定を管理する。

## Setup

```bash
./set.zsh
```

このスクリプトは以下を行う:
- 既存のシェル設定ファイル(`.bash*`, `.zshrc`等)を削除し、シンボリンクを作成
- `.gitconfig`を`[include]`方式で取り込み(ユーザー設定を上書きしない)
- `nvim/` → `~/.config/nvim` のシンボリンク
- `.claude.md` → `~/.claude/CLAUDE.md` のシンボリンク
- Warp/Ghosttyターミナル設定(macOSのみ)
- git completion/promptスクリプトのダウンロード
- vim-jetpack、nvm、dvmのインストール

## Architecture

### シンボリンク管理方式

すべての設定はこのリポジトリからシンボリンクで管理される。`set.zsh`内の`create_symlink`関数が既存ファイルの削除→シンボリンク作成を行う。`.gitconfig`のみ例外で、`[include]`ディレクティブ経由で読み込む。

### NeoVim設定の構造

読み込み順序: `init.lua` → `config.vim`(基本設定) → `plugins.vim`(プラグイン定義 + LSP/補完設定) → `plugin-config.lua` → `keybindings.lua`

- **プラグインマネージャ**: vim-jetpack。プラグイン追加・更新は `:JetpackSync`
- **LSP**: Mason経由。`plugins.vim`内で`vim.lsp.config`/`vim.lsp.enable` APIを使用(nvim 0.11+)
  - `denols`: `deno.json`/`deno.jsonc`がルートにある場合に有効化
  - `ts_ls`: `package.json`がルートにある場合に有効化（single_file_support=false）
  - `gopls`, `intelephense`: 常に有効
- **フォーマッター**: conform.nvim。保存時自動フォーマット。JS/TSはBiome→Prettierの順で試行
- **キーバインド**: VSCode風。Leader=Space。`<D-*>`(Cmd)と`<C-*>`(Ctrl)の両方を設定

### .zshrc クロスプラットフォーム対応

`${OSTYPE}`で`darwin*`/`linux*`を判定し、パッケージマネージャやPATHを切り替える。nvmはlazy-loading方式でシェル起動を高速化（stub関数で初回呼び出し時にロード）。ディレクトリ変更時に`.nvmrc`を検出して自動バージョン切り替え。

## System Dependencies (NeoVim)

| Package | Used by | Purpose |
|---------|---------|---------|
| `ripgrep` | Telescope | Live grep / content search |
| `fd` | Telescope | File finder |
| `lazygit` | lazygit.nvim | Terminal Git UI |
| `im-select` | keybindings.lua | IME auto-switch on InsertLeave (macOS only) |

## Important Notes

- `set.zsh`は既存のbash/zsh設定ファイルをすべて削除する（バックアップなし）
- テーマは全体的にgruvbox-dark-soft統一（NeoVim、Warp、Ghostty、bat）
- Git設定で`push.default=current`、`fetch.prune=true`、`init.defaultBranch=master`
- Gitエイリアス: `a`=add, `b`=branch, `c`=commit, `cm`=commit --message, `sw`=switch, `sc`=switch -c, `ps`/`pu`=push, `pl`=pull

## ブランチ運用

### マシン別ブランチ

4つのブランチがそれぞれ別マシンの環境に対応する。

| ブランチ | 対象環境 |
|---|---|
| `master` | メインmacOS / 全ブランチの統合元 |
| `release/office` | 業務用macOS |
| `gitbash` | Windows / Git Bash |
| `wsl-ubuntu` | WSL2 (Ubuntu) |

### 同期ルール

- 設定の修正やNeoVim設定の追加などを行ったら、その変更を4ブランチすべてにローカルでmergeしてpushする
- **ブランチ間の同期にPRは不要**。ローカルで`git merge`して直接pushしてよい
- グローバルルールとの関係: **PR必須**はこの同期マージのみ例外。**masterへの直接コミット禁止 / ブランチ作成必須 / rebase禁止**は例外ではない。直接pushしてよいのは`release/office`、`gitbash`、`wsl-ubuntu`の3ブランチのみ

### 同期時の注意

- ローカルrefは各ブランチとも数十コミット古いままのことが多い。必ず`git fetch --all --prune`から始める
- `pull`・`merge`には`--no-rebase`を明示する。`pull.rebase`の設定値に左右されずrebase禁止を担保するため
- コンフリクトしたらそのブランチで止める。未解決のまま次のブランチへ進まない
- 同期漏れの確認は`origin/<branch>..origin/master`のコミット数で見る。ローカルref同士の比較はローカルが古いだけで無意味な値が出る

### 同期時の注意箇所

| ファイル | 方針 |
|---|---|
| `.claude.md` | 各ブランチが独自に再編しがちで衝突しやすい。行単位の自動マージに任せず、見出し・項目単位で手動マージする |
| `set.zsh` | `gitbash`のセットアップ実体は`set.bash`（`set.zsh`を参照しない自己完結スクリプト）。`set.zsh`はmasterと同一に保てば衝突しない。削除するとmodify/deleteコンフリクトになるので消さない。gitbash向けの変更は`set.bash`だけに入れる |
| `.zshrc` | 環境固有の末尾追記や`linux*`ブロックのエイリアスはブランチ側を残し、共通部分だけmasterを取り込む |
| `.gitconfig` | `gitbash`の`autocrlf`など環境固有行をマージ時に消さない |
| `.claude/settings.local.json` | ローカル専用設定。masterへ逆流させない |

`nvim/`配下はOS非依存なので、NeoVim設定の変更はmasterで行い環境ブランチ側では直接触らない。環境ブランチで変更すると以後の同期で衝突源になる。