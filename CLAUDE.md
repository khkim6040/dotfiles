# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS dotfiles for Gwanho Kim (khkim6040). Config files are symlinked from this repo to their target locations via `install.sh`.

## Installation

```bash
./install.sh
```

This creates symlinks from repo files to their home directory locations (e.g., `shell/.zshrc` -> `~/.zshrc`). Existing files are backed up as `.bak`.

## Architecture

The repo is organized by concern, each directory maps to a set of symlink targets:

- **`shell/`** -> `~/.zshrc`, `~/.zshenv`, `~/.profile` — Oh My Zsh (robbyrussell theme), zsh-autosuggestions, zsh-syntax-highlighting. Tab key accepts autosuggestions or falls back to completion. PATH setup for Homebrew, Android SDK, npm-global, OpenJDK 17, Ruby, Cargo, Deno.
- **`git/`** -> `~/.gitconfig`, `~/.ssh/config` — Git aliases (st, co, cb, br, ci, ca, cane, d, ds, a, ap, p, ps, psf, lo, lg, last, unstage, discard). SSH keys for GitHub (khkim6040).
- **`tools/`** -> `~/.npmrc`, `~/.testcontainers.properties`, `~/.config/gh/config.yml` — npm global prefix at `~/.npm-global`, gh CLI with HTTPS protocol.
- **`macos/`** -> `~/.aerospace.toml`, `~/.config/karabiner/karabiner.json` — AeroSpace tiling WM with alt-hjkl navigation and alt-{1-9,a-z} workspaces. Karabiner swaps left Cmd/Ctrl and maps right Option to F18.

## Conventions

- All config files live in their category directory, never at repo root
- `install.sh` uses a `link_file` helper that handles backup/overwrite — add new files by adding `link_file` calls
- README is in Korean
