# dotfiles

macOS 개발 환경 설정 파일 모음.

## 구조

```
shell/       zshrc, zshenv, profile
git/         gitconfig, ssh config
tools/       npmrc, testcontainers, gh CLI
macos/       AeroSpace, Karabiner
```

### VSCode
https://github.com/khkim6040/vscode-settings

## 설치

```bash
git clone https://github.com/khkim6040/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

`install.sh`는 각 파일을 원래 위치에 symlink로 연결합니다.
기존 파일이 있으면 `.bak` 백업을 생성합니다.
