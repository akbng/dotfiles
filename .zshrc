export ZSH="$HOME/.oh-my-zsh"
export CDPATH=".:$HOME:$HOME/web_dev"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim')
export GPG_TTY=$(tty)

ZSH_THEME="spaceship"
HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7

ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git zsh-nvm)

source $ZSH/oh-my-zsh.sh

#Custom aliases
alias cls="clear"
alias open="xdg-open"
alias vscode="code -r ."
alias pss="ps -aux | grep"
