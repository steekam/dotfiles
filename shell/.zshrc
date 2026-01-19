# =============================================================================
# Powerlevel10k Instant Prompt
# =============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# OS Detection (cached for performance)
# =============================================================================
_OS="$(uname)"

# =============================================================================
# Oh My Zsh Configuration
# =============================================================================
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-completions)
ZSH_CUSTOM=$ZSH/custom

source $ZSH/oh-my-zsh.sh

## disable Powerlevel10k when Cursor Agent runs
if [[ -n "$CURSOR_AGENT" ]]; then
  # Skip theme initialization for better compatibility
else
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh
fi

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
(( $+commands[npm] )) && path+=('./node_modules/.bin')

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
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Android SDK
if [[ "$_OS" == "Darwin" ]]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
else
  export ANDROID_HOME=$HOME/Android/Sdk
fi
export ANDROID_SDK_ROOT=$ANDROID_HOME
export ANDROID_NDK_ROOT=$ANDROID_SDK_ROOT/ndk/28.2.13676358
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

# SDKMAN (lazy-loaded for faster startup)
export SDKMAN_DIR="$HOME/.sdkman"
_sdk_lazy_load() {
  unfunction sdk java gradle kotlin groovy mvn 2>/dev/null
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
}
sdk() { _sdk_lazy_load && sdk "$@" }
java() { _sdk_lazy_load && java "$@" }
gradle() { _sdk_lazy_load && gradle "$@" }
kotlin() { _sdk_lazy_load && kotlin "$@" }
groovy() { _sdk_lazy_load && groovy "$@" }
mvn() { _sdk_lazy_load && mvn "$@" }

# pnpm
if [[ "$_OS" == "Darwin" ]]; then
  export PNPM_HOME="/Users/steekam/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi

# Herd PHP Configuration
export HERD_PHP_84_INI_SCAN_DIR="/Users/steekam/Library/Application Support/Herd/config/php/84/"
export PATH="/Users/steekam/Library/Application Support/Herd/bin/":$PATH

# Added by Windsurf
export PATH="$HOME/.codeium/windsurf/bin:$PATH"

# Go
if [ -d "$HOME/go" ]; then
  export GOPATH="$HOME/go"
  export PATH="$GOPATH/bin:$PATH"
fi

# Mise (asdf replacement)
eval "$(mise activate zsh)"

# opencode
[ -d "$HOME/.opencode/bin" ] && export PATH=$HOME/.opencode/bin:$PATH

export PATH=$PATH:$HOME/.maestro/bin

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# pnpm (Linux)
if [[ "$_OS" == "Linux" ]]; then
  export PNPM_HOME="/home/steekam/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi
# pnpm end
