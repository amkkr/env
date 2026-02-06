# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal environment configuration repository (dotfiles) that manages shell, terminal, and editor configurations across macOS and Linux systems. The repository contains:

- **Shell Configuration**: `.zshrc` with custom prompt, aliases, and cross-platform settings
- **NeoVim Configuration**: Complete NeoVim setup with plugins and custom configurations
- **Terminal Configuration**: Warp terminal settings and keybindings
- **Environment Setup**: Installation and symlink management script

## Setup and Installation

The primary setup command is:
```bash
./set.sh
```

This script:
- Removes existing shell configuration files and creates symlinks
- Sets up NeoVim configuration by symlinking the `nvim/` directory
- Configures Warp terminal settings based on the operating system
- Downloads git completion and prompt scripts
- Installs vim-jetpack plugin manager
- Installs Deno Version Manager (dvm)

## File Structure

- **set.sh**: Main setup script that creates symlinks and installs dependencies
- **.zshrc**: Zsh shell configuration with cross-platform support
- **nvim/**: Complete NeoVim configuration directory
  - `init.lua`: Main NeoVim initialization file
  - `config.vim`: Core Vim configuration
  - `plugins.vim`: Plugin definitions
  - `ftdetect/`: File type detection rules
- **warp-terminal/**: Warp terminal configuration files
- **darwin-mac.yaml**: macOS-specific keybindings for Warp terminal

## Cross-Platform Support

The configuration supports both macOS (darwin) and Linux systems:
- **macOS**: Uses Homebrew for updates, specific PATH configurations
- **Linux**: Supports multiple package managers (apt, dnf, zypper), Flatpak, and Snap

## Key Features

- Git integration with custom prompt showing repository status
- Comprehensive alias collection for common operations
- Node.js version management with NVM
- Deno version management with DVM
- Go development environment setup
- Docker convenience aliases
- Cross-platform update commands (`upd` alias)

## Environment Variables and Paths

The configuration sets up various development environments:
- Go: `GOPATH` and `GOBIN` configuration
- Node.js: NVM integration with automatic version switching
- Deno: DVM path configuration  
- Java: OpenJDK path on macOS
- Google Cloud SDK integration
- Cargo (Rust) environment

## Important Notes

- The setup script removes existing bash and zsh configuration files
- All configurations are managed through symlinks to this repository
- The `.zshrc` uses lazy-loading for nvm to improve shell startup time (1.9s → 0.02s)
- Automatically detects `.nvmrc` files when changing directories and switches Node versions
- nvm is loaded on-demand when first used (nvm, node, npm, or npx commands)
- Git completion and prompt functionality requires internet connection during setup