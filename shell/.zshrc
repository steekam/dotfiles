# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-completions systemd asdf)

ZSH_CUSTOM=$ZSH/custom

source $ZSH/oh-my-zsh.sh

# Enable autocompletion
autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load the shell dotfiles, and then some:
# * ~/.dotfiles-custom can be used for other settings you don’t want to commit.
for file in ~/.dotfiles/shell/.{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

for file in ~/.dotfiles-custom/shell/.{exports,aliases,functions,zshrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Add ./node_modules/bin of current project to path
# Check if npm is installed first
[ -x "$(command -v npm)" ] && path+=('./node_modules/.bin')

# Composer
if [ -d "$HOME/.composer/vendor/bin" ]
	then
		# Add global composer bin
		path+=("$HOME/.composer/vendor/bin")

		# Add vendor/bin of php project in current directory
		path+=('./vendor/bin')
fi


if [ -d "$HOME/.config/composer/vendor/bin" ]
	then
		# Add global composer bin
		path+=("$HOME/.config/composer/vendor/bin")

		# Add vendor/bin of php project in current directory
		path+=('./vendor/bin')
fi
# END Composer

[ -d "$HOME/.local/bin" ]  && path+=("$HOME/.local/bin")

# Install venv environment in project directory
export PIPENV_VENV_IN_PROJECT=1

# Disable Homebrew auto-update
export HOMEBREW_NO_AUTO_UPDATE=1

# Wrapify subshells in Warp -- should always be the last thing
printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh" }}\x9c'
