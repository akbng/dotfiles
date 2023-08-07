#!/bin/bash

setup_zshrc() {
	cat >$HOME/.zshrc <<EOF
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
bindkey -e

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

fpath=( "${ZDOTDIR:-$HOME}/.zfunctions" $fpath )
autoload -U promptinit; promptinit
prompt spaceship

alias ll="ls -lh --color=auto"
alias la="ls -ah --color=auto"
alias l="ls -CFh"
alias cls="clear"
alias open="xdg-open"
alias vscode="code -r"
alias gss="git status -s"
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue) %an%Creset' --abbrev-commit"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"

export CDPATH=".:$HOME"
export EDITOR="vim"
export GPG_TTY=$(tty)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
}

setup_vimrc() {
	cat >$HOME/.vimrc <<EOF
set nocompatible
set backspace=indent,eol,start
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set number
set ruler
set showmatch
set ignorecase
set incsearch
set hlsearch
set laststatus=2
set wildmenu
set mouse=a
EOF
}

init_zshrc() {
	mkdir "${ZDOTDIR:-$HOME}/.zfunctions"
	git clone https://github.com/spaceship-prompt/spaceship-prompt.git --depth=1
	ln -sf "$PWD/spaceship-prompt/spaceship.zsh" "${ZDOTDIR:-$HOME}/.zfunctions/prompt_spaceship_setup"
	echo "Setting up custom zshrc with spaceship prompt for user: $USER..."
	setup_zshrc
}

if [ $ZSH -a $ZSH_CUSTOM ]; then
	echo "OH-MY-ZSH already installed and configured"
	echo 'Installing spaceshipt Prompt (only)...'
	git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
else
	echo "OH-MY-ZSH is not set..."
	init_zshrc
fi

# TODO: setup vimrc, tmux config, samba server, ssh config, etc.
# TODO: also setup gpg keyring, and configure git to use gpg keys.

echo 'Finished Post Setup processes!'
echo 'Please restart your terminal session to apply changes'
echo 'Or run `source ~/.zshrc` to apply changes'
