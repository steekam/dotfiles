# =============================================================================
# Powerlevel10k Instant Prompt
# =============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# Oh My Zsh Configuration
# =============================================================================
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-completions asdf)
ZSH_CUSTOM=$ZSH/custom

source $ZSH/oh-my-zsh.sh

# Enable autocompletion
autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =============================================================================
# Dotfiles Loading
# =============================================================================
# Load the shell dotfiles, and then some:
# * ~/.dotfiles-custom can be used for other settings you don't want to commit.
for file in ~/.dotfiles/shell/.{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

for file in ~/.dotfiles-custom/shell/.{exports,aliases,functions,zshrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# =============================================================================
# Path Configuration
# =============================================================================
# Add ./node_modules/bin of current project to path
[ -x "$(command -v npm)" ] && path+=('./node_modules/.bin')

# Composer Configuration
if [ -d "$HOME/.composer/vendor/bin" ]; then
    # Add global composer bin
    path+=("$HOME/.composer/vendor/bin")
    # Add vendor/bin of php project in current directory
    path+=('./vendor/bin')
fi

if [ -d "$HOME/.config/composer/vendor/bin" ]; then
    # Add global composer bin
    path+=("$HOME/.config/composer/vendor/bin")
    # Add vendor/bin of php project in current directory
    path+=('./vendor/bin')
fi

[ -d "$HOME/.local/bin" ] && path+=("$HOME/.local/bin")

# poetry bin
[ -d "$HOME/.local/poetry/bin" ] && path+=("$HOME/.local/poetry/bin")

# =============================================================================
# Environment Variables
# =============================================================================
# Python
export PIPENV_VENV_IN_PROJECT=1

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

# =============================================================================
# Tool-specific Configurations
# =============================================================================
# Bun
[ -s "/Users/steekam/.bun/_bun" ] && source "/Users/steekam/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Android SDK
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_NDK_ROOT=$ANDROID_SDK_ROOT/ndk/27.1.12297006
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# pnpm
export PNPM_HOME="/Users/steekam/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Herd PHP Configuration
export HERD_PHP_84_INI_SCAN_DIR="/Users/steekam/Library/Application Support/Herd/config/php/84/"
export PATH="/Users/steekam/Library/Application Support/Herd/bin/":$PATH

# Added by Windsurf
export PATH="/Users/steekam/.codeium/windsurf/bin:$PATH"

# Go
if [ -d "$HOME/go" ]; then
  export GOPATH="$HOME/go"
  export PATH="$GOPATH/bin:$PATH"
fi

# Asdf configuration
export ASDF_DIR="$HOME/.asdf"
# Asdf shims path has to be first in path
export PATH="$ASDF_DIR/shims:$PATH"

# opencode
export PATH=/Users/steekam/.opencode/bin:$PATH
export PATH=$PATH:$HOME/.maestro/bin
