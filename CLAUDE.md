# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

個人の環境設定リポジトリ(dotfiles)。macOS・Linux(zsh)とWindows(Git Bash)のシェル、ターミナル、エディタ設定を管理する。

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

Windows(Git Bash)では`set.zsh`ではなく`set.bash`を使う:

```bash
./set.bash
```

このスクリプトは以下を行う(`set.zsh`を参照しない自己完結スクリプト):
- `.bashrc` → `~/.bashrc`、`.inputrc` → `~/.inputrc` のシンボリンク
- `git config --global include.path`をWindows形式のパス(`D:/repos/env/.gitconfig`形式、`cygpath -m`で変換)で設定
- `nvim/` → `~/AppData/Local/nvim` のシンボリンク

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
- `.gitconfig`の`core.autocrlf=input`はWindows(Git Bash)向け。コミット時にCRLFをLFへ変換し、チェックアウト時は変換しない。macOSでも共有される
- Gitエイリアス: `a`=add, `b`=branch, `c`=commit, `cm`=commit --message, `sw`=switch, `sc`=switch -c, `ps`/`pu`=push, `pl`=pull

## ブランチ運用

### ブランチ構成

| ブランチ | 対象環境 |
|---|---|
| `master` | メインmacOS + Windows(Git Bash)の共通設定 / 同期元 |
| `release/office` | 業務用macOS。仕事用プロファイルを含む |

### 同期ルール

- 共通設定の変更(シェル設定、NeoVim設定など)は必ずmasterで行う。`release/office`で直接変更しない
- 同期は`master`→`release/office`の一方向のみ。masterの変更をローカルで`release/office`にmergeしてpushする
- `release/office`の変更(仕事用プロファイルなど)はmasterへ戻さない
- **`release/office`への同期にPRは不要**。ローカルで`git merge`して直接pushしてよい
- グローバルルールとの関係: **PR必須**はこの同期マージのみ例外。**masterへの直接コミット禁止 / ブランチ作成必須 / rebase禁止**は例外ではない。直接pushしてよいのは`release/office`のみ

### 同期時の注意

- ローカルrefは古いままのことが多い。必ず`git fetch --all --prune`から始める
- `pull`・`merge`には`--no-rebase`を明示する。`pull.rebase`の設定値に左右されずrebase禁止を担保するため
- コンフリクトしたらそこで止める。未解決のままpushしない
- 同期漏れの確認は`origin/release/office..origin/master`のコミット数で見る。ローカルref同士の比較はローカルが古いだけで無意味な値が出る

### 同期時の注意箇所

| ファイル | 方針 |
|---|---|
| `.claude.md` | `release/office`側で業務向けに再編されていると衝突しやすい。行単位の自動マージに任せず、見出し・項目単位で手動マージする |
| `.zshrc` | `release/office`固有の追記(仕事用の設定)はブランチ側を残し、共通部分だけmasterを取り込む |
| `.claude/settings.local.json` | ローカル専用設定。masterへ持ち込まない |

`nvim/`配下はOS非依存なので、NeoVim設定の変更はmasterで行い`release/office`側では直接触らない。ブランチ側で変更すると以後の同期で衝突源になる。
