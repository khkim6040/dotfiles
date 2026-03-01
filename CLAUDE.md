# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS dotfiles repository managing shell, git, tool, and application configurations. Uses a custom symlink-based installer (`install.sh`), not GNU Stow.

## Installation

```bash
./install.sh
```

This creates symlinks from the repo to their target locations (e.g., `shell/.zshrc` → `~/.zshrc`). Existing files are backed up with `.bak` extension.

## Structure

- `shell/` — zsh config (Oh My Zsh with `robbyrussell` theme, plugins: git, zsh-autosuggestions, zsh-syntax-highlighting, you-should-use)
- `git/` — gitconfig and SSH config (GitHub SSH key, EC2 host)
- `tools/` — npm global prefix config, GitHub CLI config
- `macos/` — AeroSpace tiling WM config, Karabiner-Elements key remapping

## Key Details

- Shell uses Oh My Zsh — plugins must be installed separately (autosuggestions, syntax-highlighting)
- PATH includes: Homebrew, Android SDK, OpenJDK 17, Ruby, npm-global, ~/.local/bin, Conda, Deno, Cargo
- Karabiner swaps Command/Control on external keyboards
- AeroSpace uses Alt-based keybindings (hjkl navigation, 1-9/a-z workspaces)
- Git autocrlf set to `input` (Unix line endings)
