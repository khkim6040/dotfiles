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
link_file "$DOTFILES_DIR/shell/.profile"  "$HOME/.profile"

# Git
link_file "$DOTFILES_DIR/git/.gitconfig"  "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/git/ssh_config"  "$HOME/.ssh/config"

# Tools
link_file "$DOTFILES_DIR/tools/.npmrc"                    "$HOME/.npmrc"
link_file "$DOTFILES_DIR/tools/gh_config.yml"             "$HOME/.config/gh/config.yml"

# macOS
link_file "$DOTFILES_DIR/macos/.aerospace.toml"   "$HOME/.aerospace.toml"
link_file "$DOTFILES_DIR/macos/karabiner.json"    "$HOME/.config/karabiner/karabiner.json"

# iTerm2
if [ -d "$DOTFILES_DIR/iterm2" ]; then
  ITERM_PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"

  # Color presets
  echo ""
  echo "--- iTerm2 Color Presets ---"
  for preset in "$DOTFILES_DIR"/iterm2/*.itermcolors; do
    [ -f "$preset" ] || continue
    name="$(basename "$preset" .itermcolors)"
    open "$preset"
    echo "  IMPORT  $name"
  done
  echo "  NOTE: Select the preset in iTerm2 → Settings → Profiles → Colors → Color Presets..."

  # Key mappings
  if [ -f "$ITERM_PLIST" ]; then
    echo ""
    echo "--- iTerm2 Key Mappings ---"
    KB="New Bookmarks:0:Keyboard Map"

    # Left Option key → Esc+ (단어 단위 이동/삭제 활성화)
    /usr/libexec/PlistBuddy -c "Set :'New Bookmarks':0:'Option Key Sends' 2" "$ITERM_PLIST" 2>/dev/null
    echo "  SET     Left Option → Esc+"

    # 기존 매핑 제거 후 재등록 (멱등성 보장)
    declare -A KEYMAPS=(
      ["0xf702-0x100000"]="11:0x01"   # Cmd+Left     → 줄 처음 (Ctrl+A)
      ["0xf703-0x100000"]="11:0x05"   # Cmd+Right    → 줄 끝 (Ctrl+E)
      ["0x7f-0x100000"]="11:0x15"     # Cmd+Delete   → 줄 전체 삭제 (Ctrl+U)
      ["0x7f-0x80000"]="11:0x17"      # Opt+Delete   → 단어 삭제 (Ctrl+W)
    )

    for key in "${!KEYMAPS[@]}"; do
      IFS=':' read -r action text <<< "${KEYMAPS[$key]}"
      /usr/libexec/PlistBuddy -c "Delete :'$KB':'$key'" "$ITERM_PLIST" 2>/dev/null || true
      /usr/libexec/PlistBuddy \
        -c "Add :'$KB':'$key' dict" \
        -c "Add :'$KB':'$key':Action integer $action" \
        -c "Add :'$KB':'$key':Text string $text" \
        "$ITERM_PLIST"
    done
    echo "  SET     Cmd+Left/Right → Home/End"
    echo "  SET     Cmd+Delete → Clear line"
    echo "  SET     Opt+Delete → Delete word"
    echo "  NOTE: Restart iTerm2 for key mapping changes to take effect."
  fi
fi

# macOS keyboard shortcuts
if [ "$(uname)" = "Darwin" ]; then
  echo ""
  echo "--- macOS Keyboard Shortcuts ---"
  if [ -f "$DOTFILES_DIR/macos/symbolichotkeys.plist" ]; then
    defaults import com.apple.symbolichotkeys "$DOTFILES_DIR/macos/symbolichotkeys.plist"
    echo "  IMPORT  symbolichotkeys.plist"
  fi
  defaults write -g NSUserKeyEquivalents -dict-add "Minimize" '@~$9'
  echo "  SET     Minimize → Cmd+Option+Shift+9"
  echo ""
  echo "  NOTE: Log out and back in for keyboard shortcut changes to take effect."
fi

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
