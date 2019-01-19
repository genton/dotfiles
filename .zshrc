# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob nomatch notify
bindkey -v
bindkey "\e[3~" delete-char
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
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


alias ls="ls --color=auto"
bindkey '^R' history-incremental-search-backward

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.gem/ruby/2.3.0/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export VISUAL=vim

source /home/phate/.antigen/antigen.zsh

# syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

# fish-like auto suggestion
antigen bundle zsh-users/zsh-autosuggestions

# Tell antigen we're done
antigen apply
