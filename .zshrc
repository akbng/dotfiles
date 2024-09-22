if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:plugins:nvm' lazy yes

plugins=(git nvm cp bgnotify dotenv sudo tmux last-working-dir ubuntu)

source $ZSH/oh-my-zsh.sh

alias ls="colorls"
alias cls="clear"
alias vim="nvim"

export CDPATH=".:$HOME"
export CHROME_EXECUTABLE="$(which chromium)"
export GPG_TTY=$(tty)
export PATH=$PATH:$HOME/.local/bin
export PATH=$HOME/Android/Sdk/platform-tools:$PATH
export PATH=$HOME/flutter/bin:$PATH
export PATH=$HOME/.nvm/versions/node/v18.17.0/bin:$PATH
export EDITOR=/usr/bin/nvim
export LANG=en_US.UTF-8

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $(dirname $(gem which colorls))/tab_complete.sh

eval "$(zoxide init zsh)"

eval "$(flutter zsh-completion)"
