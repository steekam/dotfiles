autoload -Uz compinit
compinit -i

for file in \
  "$HOME/.dotfiles/shell/.exports" \
  "$HOME/.dotfiles/shell/.aliases" \
  "$HOME/.dotfiles/shell/.functions" \
  "$HOME/.dotfiles-custom/shell/.exports" \
  "$HOME/.dotfiles-custom/shell/.aliases" \
  "$HOME/.dotfiles-custom/shell/.functions"; do
  [[ -r "$file" ]] && source "$file"
done

[[ -r "$HOME/.dotfiles-custom/shell/local.zsh" ]] && source "$HOME/.dotfiles-custom/shell/local.zsh"

if [[ -d "$HOME/.local/bin" ]]; then
  path=("$HOME/.local/bin" $path)
fi

if [[ -d "$HOME/go/bin" ]]; then
  export GOPATH="$HOME/go"
  path=("$GOPATH/bin" $path)
fi

setopt APPEND_HISTORY INC_APPEND_HISTORY HIST_IGNORE_DUPS HIST_SAVE_NO_DUPS

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
  eval "$(mise completion zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

if [[ "${TERM:-}" != dumb ]] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
