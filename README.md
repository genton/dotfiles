# Antoine's dotfiles

A collection of configuration files managed with **GNU Stow**.

## 🛠️ Configured Software

- **Zsh**: Tidied configuration with [Antigen](https://github.com/zsh-users/antigen) for plugin management.
- **Tmux**: Productivity-focused config using [TPM](https://github.com/tmux-plugins/tpm) and Catppuccin theme.
- **Neovim**: Lua-based configuration using [Lazy.nvim](https://github.com/folke/lazy.nvim).
- **Starship**: Modern, cross-shell prompt.
- **Git**: Global configuration with 1Password SSH signing.

## 🚀 Quick Start

### 1. Prerequisites

Ensure `stow` is installed on your system:

```bash
sudo apt update && sudo apt install stow
```

### 2. Installation

Clone the repository and use `stow` to link the configurations to your home directory:

```bash
git clone https://github.com/phate/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow base
```

## 📂 Structure

- `base/`: Core configurations (linked to `~`).
  - `.zshrc`: Shell setup.
  - `.tmux.conf`: Terminal multiplexer.
  - `.gitconfig`: Git settings.
  - `.config/`: Application-specific configs (Neovim, Starship).

## 🔄 Management

To apply changes or add new configurations:

- **Add new files**: Place them in `base/` following the home directory structure.
- **Update links**: Run `stow base` from the repository root.
- **Remove links**: Run `stow -D base`.
