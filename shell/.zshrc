for dir in \
  "${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/share/zsh-completions}" \
  "$HOME/.local/share/zsh-completions/src"; do
  if [[ -n "$dir" && -d "$dir" && ${fpath[(Ie)$dir]} -eq 0 ]]; then
    fpath=("$dir" $fpath)
  fi
done

autoload -Uz compinit
compinit -i
autoload -Uz zmv

for file in \
  "$HOME/.dotfiles/shell/.exports" \
  "$HOME/.dotfiles/shell/.aliases" \
  "$HOME/.dotfiles/shell/.functions" \
  "$HOME/.dotfiles/shell/.directories" \
  "$HOME/.dotfiles-custom/shell/.exports" \
  "$HOME/.dotfiles-custom/shell/.aliases" \
  "$HOME/.dotfiles-custom/shell/.functions"; do
  [[ -r "$file" ]] && source "$file"
done

[[ -r "$HOME/.dotfiles-custom/shell/local.zsh" ]] && source "$HOME/.dotfiles-custom/shell/local.zsh"

path+=(./node_modules/.bin)

if [[ -d "$HOME/.local/bin" ]]; then
  path=("$HOME/.local/bin" $path)
fi

if [[ -d "$HOME/go/bin" ]]; then
  export GOPATH="$HOME/go"
  path=("$GOPATH/bin" $path)
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
  eval "$(mise completion zsh)"
fi

setopt APPEND_HISTORY INC_APPEND_HISTORY HIST_IGNORE_DUPS HIST_SAVE_NO_DUPS

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
  FZF_CTRL_R_COMMAND= source <(fzf --zsh)
fi

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

if [[ "${TERM:-}" != dumb ]] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

for file in \
  "${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh}" \
  /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  if [[ -r "$file" ]]; then
    source "$file"
    break
  fi
done

# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/steekam/Library/Application Support/Herd/config/php/84"


# Herd injected PHP 8.6 configuration.
export HERD_PHP_86_INI_SCAN_DIR="/Users/steekam/Library/Application Support/Herd/config/php/86"


# Herd injected PHP 8.5 configuration.
export HERD_PHP_85_INI_SCAN_DIR="/Users/steekam/Library/Application Support/Herd/config/php/85"
