#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

link_file() {
  local src="$1"
  local dst="$2"

  if [ ! -f "$src" ]; then
    echo "  SKIP  $src (not found)"
    return
  fi

  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -f "$dst" ]; then
    echo "  BACKUP  $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi

  ln -sf "$src" "$dst"
  echo "  LINK  $dst → $src"
}

echo "=== Dotfiles Installer ==="
echo ""

# Shell
link_file "$DOTFILES_DIR/shell/.zshrc"    "$HOME/.zshrc"
link_file "$DOTFILES_DIR/shell/.zshenv"   "$HOME/.zshenv"
link_file "$DOTFILES_DIR/shell/.profile"  "$HOME/.profile"

# Git
link_file "$DOTFILES_DIR/git/.gitconfig"  "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/git/ssh_config"  "$HOME/.ssh/config"

# Tools
link_file "$DOTFILES_DIR/tools/.npmrc"                    "$HOME/.npmrc"
link_file "$DOTFILES_DIR/tools/.testcontainers.properties" "$HOME/.testcontainers.properties"
link_file "$DOTFILES_DIR/tools/gh_config.yml"             "$HOME/.config/gh/config.yml"

# macOS
link_file "$DOTFILES_DIR/macos/.aerospace.toml"   "$HOME/.aerospace.toml"
link_file "$DOTFILES_DIR/macos/karabiner.json"    "$HOME/.config/karabiner/karabiner.json"

echo ""
echo "=== Done ==="
echo ""

# Oh My Zsh plugins reminder
if [ -d "$HOME/.oh-my-zsh" ]; then
  ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  echo "Oh My Zsh detected. Install recommended plugins:"
  echo ""
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions"
  fi
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "  git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  fi
  if [ ! -d "$ZSH_CUSTOM/plugins/you-should-use" ]; then
    echo "  git clone https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use"
  fi
  echo ""
fi
