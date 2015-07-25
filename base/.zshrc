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
zstyle :compinstall filename '/home/phate/.zshrc'
autoload -Uz compinit && compinit
autoload -Uz colors && colors

# --- Environment ---
export VISUAL=vim
export NVM_DIR="$HOME/.nvm"

# PATH updates
typeset -U path # Keep unique paths
path=(
  $HOME/.local/bin
  $HOME/.cargo/bin
  $HOME/.gem/ruby/2.3.0/bin
  /snap/bin
  $path
)
export PATH

# --- Aliases ---
alias ls="ls --hyperlink=auto --color=auto"
alias icat="kitty +kitten icat"

# 1Password SSH agent via Windows interop (WSL only)
if [[ -n "$WSL_DISTRO_NAME" ]]; then
    alias ssh=ssh.exe
    alias ssh-add=ssh-add.exe
fi

# --- Plugins (Antigen) ---
source /usr/share/zsh-antigen/antigen.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# --- Shell Prompt (Starship) ---
if [ "$USER" = "root" ]; then
    export STARSHIP_CONFIG=~/.config/starship_root.toml
else
    export STARSHIP_CONFIG=~/.config/starship.toml
fi
eval "$(starship init zsh)"

# --- External Tool Init ---
# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Conda/Mamba
if [ -f "/home/phate/mambaforge/etc/profile.d/conda.sh" ]; then
    . "/home/phate/mambaforge/etc/profile.d/conda.sh"
    if [ -f "/home/phate/mambaforge/etc/profile.d/mamba.sh" ]; then
        . "/home/phate/mambaforge/etc/profile.d/mamba.sh"
    fi
else
    export PATH="/home/phate/mambaforge/bin:$PATH"
fi
