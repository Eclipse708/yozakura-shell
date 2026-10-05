#!/usr/bin/env bash
# Apply the Yozakura zsh / tmux / Windows Terminal setup from this folder.
# Safe to re-run. Existing dotfiles are copied to *.bak-<timestamp> first.
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
stamp="$(date +%Y%m%d-%H%M%S)"

install_file() {
  local src="$HERE/$1" dst="$HOME/$2"
  if [[ -f "$dst" ]] && ! cmp -s "$src" "$dst"; then
    cp "$dst" "$dst.bak-$stamp"
  fi
  cp "$src" "$dst"
  chmod 644 "$dst"
  echo "installed ~/$2"
}

# Oh My Zsh custom plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
for repo in zsh-autosuggestions zsh-syntax-highlighting; do
  if [[ ! -d "$ZSH_CUSTOM/plugins/$repo" ]]; then
    git clone --depth 1 "https://github.com/zsh-users/$repo.git" "$ZSH_CUSTOM/plugins/$repo"
  fi
done

install_file zshrc     .zshrc
install_file p10k.zsh  .p10k.zsh
install_file tmux.conf .tmux.conf
install_file vim/vimrc  .vimrc
mkdir -p "$HOME/.vim/colors"
install_file vim/colors/yozakura.vim .vim/colors/yozakura.vim

# Windows Terminal (only when running under WSL with the settings file reachable)
if ls /mnt/c/Users/*/AppData/Local/Packages/Microsoft.WindowsTerminal_*/LocalState/settings.json >/dev/null 2>&1; then
  python3 "$HERE/windows-terminal/apply.py"
fi

# Drop the stale instant-prompt cache so the first new shell renders the new prompt.
rm -f "${XDG_CACHE_HOME:-$HOME/.cache}"/p10k-instant-prompt-*.zsh
echo "done. Open a new terminal tab, or run: exec zsh"
