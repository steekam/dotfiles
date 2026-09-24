# Dotfiles

Shared shell, tool, and application settings for macOS and Linux. Machine-only
shell paths and commands belong in `~/.dotfiles-custom/shell/`.

## First machine

1. Install mise using its [official instructions](https://mise.jdx.dev/getting-started.html).
   On macOS, install Xcode Command Line Tools with `xcode-select --install`;
   the PostgreSQL mise plugin builds from source.
2. Ensure Git and curl are available before cloning. For example:
   - Fedora: `sudo dnf install git curl`
   - Debian/Ubuntu: `sudo apt-get install git curl`
3. Clone this repository to `~/.dotfiles`:

   ```sh
   git clone git@github.com:steekam/dotfiles.git ~/.dotfiles
   ```
4. Review the setup and links:

   ```sh
   cd ~/.dotfiles
   mise trust mise.toml
   mise bootstrap --dry-run
   mise dot apply --dry-run
   ```

5. Apply the setup:

   ```sh
   ./setup
   ```

The bootstrap manages mise tools, supported native packages, and the shared
dotfiles listed in `mise.toml`. Review package and tool actions in the first
dry run; use `mise dot apply --dry-run` to preview exact links. It does not
change your login shell, SSH configuration, credentials, or server services.
The package entries cover Apple Silicon macOS, Debian/Ubuntu Linux, and Fedora.
Mise uses OS selectors, not distribution-name selectors. The `apt:` and `dnf:`
entries select Linux and run when their package manager is available; their
package names target Debian/Ubuntu and Fedora respectively. Other Linux systems
skip unavailable managers; add matching package entries or install dependencies
manually. Review package names before using this setup on a different RPM-based
distribution.
The `brew:` entries are restricted to macOS arm64 because mise's built-in brew
manager does not support Intel macOS. On an Intel Mac with Homebrew, install the
same packages manually:

```sh
brew install git fd bat zoxide jq ripgrep fzf tmux openssl@3 readline autoconf bison libffi libyaml
```

The extra Intel Mac packages support Ruby's source-build fallback; the standard
Apple Silicon setup uses mise's prebuilt Ruby. On Debian or Ubuntu, mise installs
the listed `apt` packages, including PostgreSQL build prerequisites. Ruby uses
prebuilt binaries on glibc Linux. Alpine or other Linux distributions may need
Ruby build dependencies such as `autoconf`, `bison`, `libffi`, `libyaml`, and
the equivalent compiler, OpenSSL, readline, and zlib development packages.
For Arch, Alpine, or other Linux distributions, add matching package-manager
entries to `mise.toml` or install the equivalents manually. mise's package
bootstrap supports several managers, including `dnf` for Fedora.

The default CLI set also includes `fd-find`, `bat`, and `zoxide`. Zoxide is
initialized in Zsh (`z`/`zi`); on Debian and older Ubuntu releases, aliases map
`fdfind` to `fd` and `batcat` to `bat` when needed. Starship uses its built-in
prompt and context-aware language modules. Meslo Nerd Font files in `misc/`
are linked into the user's font directory on macOS or Linux by the dotfile
setup. Select `MesloLGS NF` in the terminal's profile to render prompt icons.
Zsh loads fzf's key
bindings and completions when available, while Atuin keeps `Ctrl-R`; the
`zsh-autosuggestions` package adds inline history suggestions, accepted with
Right Arrow. The built-in `zmv` command is available for batch renames.

`setup` also creates Claude's platform-specific settings only when the target
does not exist. If settings already exist and differ, it reports that and leaves
them alone. The OpenCode JSON config remains machine-local because
the current host has a customized version.
If you pass flags to `setup`, it only forwards them to mise; run `./setup-apps`
separately to create missing Claude settings.

On Linux, set Zsh as your login shell separately if you want:

```sh
chsh -s "$(command -v zsh)"
```

## Daily use

- Put project runtime versions in each project's `mise.toml`; project entries
  override the personal defaults in this repository.
- Use `mise install` after changing a project's tool declarations.
- Atuin stores shell history locally. Sync and update checks are disabled.
- Gradle 7.6.4 runs on the configured Java 17; projects should use their Gradle
  wrapper to select a project-specific version.
- PostgreSQL does not start with each shell. Run `pg-start` and `pg-stop` on
  machines that define them in `.dotfiles-custom/shell/local.zsh`.
- Add local paths and machine aliases to `.dotfiles-custom/shell/local.zsh` or
  `.dotfiles-custom/shell/.aliases`. The shared shell loads these only when
  present.
- Put machine-specific variables needed by non-interactive Zsh in
  `.dotfiles-custom/shell/local.env.zsh`; `.zshenv` sources it only when present.

## Verify changes

```sh
git diff --check
zsh -n shell/.zshrc
zsh -n shell/.zshenv
zsh -n shell/.aliases
zsh -n shell/.exports
zsh -n shell/.functions
if [ -f ~/.dotfiles-custom/shell/local.zsh ]; then zsh -n ~/.dotfiles-custom/shell/local.zsh; fi
if [ -f ~/.dotfiles-custom/shell/local.env.zsh ]; then zsh -n ~/.dotfiles-custom/shell/local.env.zsh; fi
mise bootstrap --dry-run
mise dot apply --dry-run
```

Then open a fresh interactive shell and check `mise doctor`, `mise ls --current`,
the Starship prompt, Atuin `Ctrl-R`, project overrides, and the custom config
both present and absent. Run the bootstrap twice on clean macOS and Linux
machines before removing the backups or retired tool installations.
