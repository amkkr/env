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

4つのブランチがそれぞれ別マシンの環境に対応する。差分欄は現時点の例で、各環境で変更すれば当然増減する。

| ブランチ | 対象環境 | ブランチ固有の差分（現時点） |
|---|---|---|
| `master` | メインmacOS / 全ブランチの統合元 | - |
| `release/office` | 業務用macOS | `warp/settings.toml`、`.zshrc`末尾のDocker Desktop補完、`.claude.md`の大幅書き換え |
| `gitbash` | Windows / Git Bash | `.bashrc`、`set.bash`、bash化した`set.zsh`、`.gitconfig`の`autocrlf = input`、`.claude/settings.local.json` |
| `wsl-ubuntu` | WSL2 (Ubuntu) | `.zshrc`のapt版`upd`エイリアス・nvmエイリアスチェーン解決・bun補完、`.claude.md`の独自セクション |

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

| ファイル | 状況 | 方針 |
|---|---|---|
| `.claude.md` | 3ブランチとも独自に再編しており、master側の更新頻度も高い。**現状唯一の実コンフリクト源**（`wsl-ubuntu`で発生） | 行単位マージに任せず、見出し・項目単位で手動マージする |
| `set.zsh` | `gitbash`のセットアップ実体は`set.bash`（`set.zsh`を参照しない自己完結スクリプト）で、`set.zsh`は呼ばれないデッドコード。ただしmaster側が更新するたび衝突し、雑な解決の結果**現在は壊れている**（`main`が存在しない`setup_neovim`を呼ぶ、`setup_nvim_config`が空、`$nvim_config_dir`未定義） | `gitbash`の`set.zsh`はmasterと同一に保つ（`git checkout master -- set.zsh`）。同一なら以後衝突しない。削除すると毎回modify/deleteコンフリクトになるので消さない。gitbash向けの変更は`set.bash`だけに入れる |
| `.zshrc` | 環境ごとに末尾追記（office=Docker補完、wsl=bun補完）と`linux*`ブロックの`upd`エイリアスが分岐。ブランチ同士は混ざらないため、masterが同じ箇所を触ったときのみ衝突する | 環境固有行はブランチ側を残し、共通部分だけmasterを取り込む |
| `.gitconfig` | `gitbash`のみ`[core]`に`autocrlf = input`を追加。衝突はしない | マージ時にこの行を消さない |
| `.claude/settings.local.json` | `gitbash`のみコミット済み。`.claude/`はmasterの`.gitignore`に未記載 | masterへ逆流させない。master側で同名ファイルが生まれると衝突する |

`nvim/`配下はOS非依存なので、NeoVim設定の変更はmasterで行い環境ブランチ側では直接触らない。環境ブランチで変更すると以後の同期で衝突源になる。