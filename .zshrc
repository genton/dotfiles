# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob nomatch notify
bindkey -v
bindkey "\e[3~" delete-char
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

# Setup bindings for both smkx and rmkx key variants
# Home
bindkey '\e[H'  beginning-of-line
bindkey '\eOH'  beginning-of-line
# End
bindkey '\e[F'  end-of-line
bindkey '\eOF'  end-of-line
# Up
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
# Down
bindkey '\e[B' down-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
# Left
bindkey '\e[D' backward-char
bindkey '\eOD' backward-char
# Right
bindkey '\e[C' forward-char
bindkey '\eOC' forward-char
# Delete
bindkey '\e[3~' delete-char
# Backspace
bindkey '\e?' backward-delete-char
# PageUp
bindkey '\e[5~' up-line-or-history
# PageDown
bindkey '\e[6~' down-line-or-history
# Ctrl+Left
bindkey '\e[1;5D' backward-word
# Ctrl+Right
bindkey '\e[1;5C' forward-word
# Shift+Tab
bindkey '\e[Z' reverse-menu-complete


# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/phate/.zshrc'

autoload -Uz compinit
compinit

autoload -Uz colors && colors
PROMPT="%{$fg_bold[red]%}%n%{$fg_bold[yellow]%}@%{$fg_bold[white]%}%m %{$fg_bold[green]%}%~ %{$fg_bold[yellow]%}%# %{$reset_color%}"
# RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"
# End of lines added by compinstall

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

autoload -Uz promptinit
promptinit


alias ls="ls --hyperlink=auto --color=auto"
alias icat="kitty +kitten icat"
bindkey '^R' history-incremental-search-backward

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.gem/ruby/2.3.0/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export VISUAL=vim

source /usr/share/zsh/share/antigen.zsh

# syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

# fish-like auto suggestion
antigen bundle zsh-users/zsh-autosuggestions

# Tell antigen we're done
antigen apply

eval "$(starship init zsh)"
