# dotfiles

macOS 개발 환경 설정 파일 모음.

## 구조

```
shell/       zshrc, profile
git/         gitconfig, ssh config
tools/       npmrc, gh CLI
macos/       AeroSpace, Karabiner, 키보드 단축키
iterm2/      컬러 프리셋 (Dracula)
```

### VSCode
https://github.com/khkim6040/vscode-settings

## 사전 설치

`install.sh` 실행 전에 아래 항목들을 먼저 설치해야 합니다.

- [Homebrew](https://brew.sh)
- [Oh My Zsh](https://ohmyz.sh)
- Oh My Zsh plugins
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh)
  - [you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use#installation)
- [Karabiner-Elements](https://karabiner-elements.pqrs.org)
- [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- [GitHub CLI](https://cli.github.com)
- [iTerm2](https://iterm2.com)
- [Node.js](https://nodejs.org) (npm 포함)

## 설치

```bash
git clone https://github.com/khkim6040/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

`install.sh`는 각 파일을 원래 위치에 symlink로 연결합니다.
기존 파일이 있으면 `.bak` 백업을 생성합니다.
macOS 키보드 단축키는 `defaults import`로 적용되며, 로그아웃 후 반영됩니다.
iTerm2 컬러 프리셋은 자동으로 임포트되며, Settings → Profiles → Colors → Color Presets에서 선택할 수 있습니다.
