# --- ZSH Options & History ---
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob nomatch notify
bindkey -v

# --- Key Bindings ---
# Basics
bindkey "\e[3~" delete-char
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

# Arrow Keys, Home, End
bindkey '\e[H'  beginning-of-line
bindkey '\eOH'  beginning-of-line
bindkey '\e[F'  end-of-line
bindkey '\eOF'  end-of-line

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search

bindkey '\e[D' backward-char
bindkey '\eOD' backward-char
bindkey '\e[C' forward-char
bindkey '\eOC' forward-char

# More navigation
bindkey '\e[5~' up-line-or-history
bindkey '\e[6~' down-line-or-history
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
bindkey '\e[Z' reverse-menu-complete
bindkey '^R' history-incremental-search-backward

# --- Completion ---
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit && compinit
autoload -Uz colors && colors

# --- Environment ---
export VISUAL=vim
export NVM_DIR="$HOME/.nvm"

# PATH updates
typeset -U path # Keep unique paths

# macOS Homebrew
if [[ "$(uname)" == "Darwin" ]]; then
    path=(
        /opt/homebrew/bin
        /opt/homebrew/sbin
        $path
    )
fi

path=(
    $HOME/.local/bin
    $HOME/.cargo/bin
    $path
)

# Linux-specific paths
if [[ "$(uname)" == "Linux" ]]; then
    path=(
        $HOME/.gem/ruby/2.3.0/bin
        /snap/bin
        $path
    )
fi

export PATH

# --- Aliases ---
# ls with color: use GNU coreutils on macOS if available, otherwise BSD ls
if [[ "$(uname)" == "Darwin" ]]; then
    if command -v gls &>/dev/null; then
        alias ls="gls --hyperlink=auto --color=auto"
    else
        alias ls="ls -G"
    fi
else
    alias ls="ls --hyperlink=auto --color=auto"
fi

alias icat="kitty +kitten icat"

# 1Password SSH agent via Windows interop (WSL only)
if [[ -n "$WSL_DISTRO_NAME" ]]; then
    alias ssh=ssh.exe
    alias ssh-add=ssh-add.exe
fi

# --- Plugins (Antigen) ---
# Load antigen from the correct location for the current OS
if [[ "$(uname)" == "Darwin" ]]; then
    ANTIGEN_PATH="$(brew --prefix 2>/dev/null)/share/antigen/antigen.zsh"
else
    ANTIGEN_PATH="/usr/share/zsh-antigen/antigen.zsh"
fi

if [[ -f "$ANTIGEN_PATH" ]]; then
    source "$ANTIGEN_PATH"
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions
    antigen apply
fi

# --- Shell Prompt (Starship) ---
if command -v starship &>/dev/null; then
    if [ "$USER" = "root" ]; then
        export STARSHIP_CONFIG=~/.config/starship_root.toml
    else
        export STARSHIP_CONFIG=~/.config/starship.toml
    fi
    eval "$(starship init zsh)"
fi

# --- External Tool Init ---
# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Conda/Mamba (works on both macOS and Linux via $HOME path)
MAMBA_BASE="$HOME/mambaforge"
if [ -f "$MAMBA_BASE/etc/profile.d/conda.sh" ]; then
    . "$MAMBA_BASE/etc/profile.d/conda.sh"
    if [ -f "$MAMBA_BASE/etc/profile.d/mamba.sh" ]; then
        . "$MAMBA_BASE/etc/profile.d/mamba.sh"
    fi
else
    export PATH="$MAMBA_BASE/bin:$PATH"
fi
