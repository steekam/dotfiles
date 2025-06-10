# AGENT.md - Dotfiles Repository

## Build/Setup Commands
- `./setup` - Main setup script for new machine installation
- `source ~/.zshrc` - Reload shell configuration after changes

## Code Style & Conventions
- **Shell Scripts**: Use bash with `#!/bin/bash` shebang
- **Indentation**: 2 spaces for most files (zsh/vim configs)
- **File Structure**: Organize configs in `shell/` directory, utilities in `misc/`
- **Comments**: Use `# ` for shell comments, organize sections with header blocks
- **Symlinks**: Use absolute paths with `$HOME/.dotfiles/` prefix for linking configs

## File Organization
- `shell/` - All shell configuration files (.zshrc, .aliases, .vimrc, etc.)
- `misc/` - Fonts and miscellaneous resources
- `setup` - Main installation script
- Individual dotfiles are symlinked from `shell/` to home directory

## Git Configuration
- Default branch: `main`
- Uses histogram diff algorithm and zdiff3 merge style
- Auto-prune branches and tags on fetch
- Verbose commits enabled

## Testing/Validation
- No formal test suite - validation is manual after running `./setup`
- Test by creating fresh shell session: `zsh -l`
