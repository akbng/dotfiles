#!/bin/bash

SUDO=''
declare -a REPOS=('universe' 'multiverse' 'restricted')
declare -a DEPENDENCIES=('git' 'build-essential' 'wget' 'curl' 'tmux' 'vim' 'htop' 'file' 'fonts-powerline' 'vlc' 'gnome-tweaks' 'zsh')
declare -a SNAP_PACKAGES=('chromium' 'spotify' 'zoom' 'bitwarden')

if [ "$EUID" -ne 0 ]; then
  SUDO='sudo'
fi

for REPO in "${REPOS[@]}"
do
    if ! grep -q "$REPO" /etc/apt/sources.list; then
        echo "Adding $REPO to apt source list..."
        $SUDO add-apt-repository $REPO
    fi
done

echo 'Updating Repositories...'
$SUDO apt update
echo 'Upgrading System...'
$SUDO apt upgrade

echo 'Installing Dependencies...'
for DEPENDENCY in "${DEPENDENCIES[@]}"
do
    if ! dpkg -s $DEPENDENCY > /dev/null 2>&1; then
        echo "Installing $DEPENDENCY..."
        $SUDO apt install $DEPENDENCY -y
    fi
done

# If zsh is not installed properly
if ! [ -x "$(command -v zsh)" ]; then
    echo 'Installing ZSH separately...'
    $SUDO apt install zsh && $SUDO dpkg-reconfigure dash && $SUDO reboot
fi

change_shell () {
    echo 'Changing shell to zsh...'
    if [ "$EUID" -eq 0 ]; then # If root, don't change shell
        echo 'Script is running as root. Skipping shell change.'
        echo 'Skipping...'
        return 1
    fi

    path_to_zshrc="$(which zsh)"
    if [ "$SHELL" != "$path_to_zshrc" ]; then
        chsh -s $path_to_zshrc
    else
        echo 'Shell already set to zsh!'
    fi
}

echo "Do you want to change your default shell to zsh?"
select yn in "Yes" "No"; do
    case $yn in 
        Yes ) change_shell; break;;
        No ) break;;
    esac
done

install_omz () {
echo 'Installing Oh-My-Zsh...'
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" << EndOfCommand
n
EndOfCommand
    
echo 'Installing spaceship prompt...'
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    
echo 'Installing zsh-nvm plugin...'
git clone https://github.com/lukechilds/zsh-nvm "$HOME/oh-my-zsh/custom/plugins/zsh-nvm"

echo 'Copying zshrc...'
cp -ub ./.zshrc ~
}

skip_omz () {
    echo 'Skipping Oh-My-Zsh...'
    echo 'Adding custom aliases to ~/.zshrc ...'
    echo 'alias ll="ls -l"' >> ~/.zshrc
    echo 'alias la="ls -a"' >> ~/.zshrc
    echo 'alias l="ls -CF"' >> ~/.zshrc
    echo 'alias cls="clear"' >> ~/.zshrc
    echo 'alias open="xdg-open"' >> ~/.zshrc
    echo 'alias code="code -r"' >> ~/.zshrc
    echo 'alias gss="git status -s"' >> ~/.zshrc
    echo 'alias glg="git log --graph --pretty=format:'"'"'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue) %an%Creset'"'"' --abbrev-commit"' >> ~/.zshrc
    echo 'alias glols="git log --graph --pretty='"'"'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"'"' --stat"' >> ~/.zshrc
    echo 'Exporting Environment Variables...'
    echo 'export CDPATH=".:$HOME"' >> ~/.zshrc
    echo 'export EDITOR="vim"' >> ~/.zshrc
    echo 'Installing ZSH manually...'
    echo 'fpath=( "${ZDOTDIR:-$HOME}/.zfunctions" $fpath )' >> ~/.zshrc
    ln -sf "$PWD/spaceship.zsh" "${ZDOTDIR:-$HOME}/.zfunctions/prompt_spaceship_setup"
    echo 'autoload -U promptinit; promptinit' >> ~/.zshrc
    echo 'prompt spaceship' >> ~/.zshrc
    echo 'Finished editing ~/.zshrc'
    echo 'Please check your ~/.zshrc file in case of ERRORS!'
}

echo "Do you wish to install OH-MY-ZSH?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) install_omz; break;;
        No ) skip_omz; break;;
    esac
done

if ! [ -x "$(command -v nvm)" ]; then
    echo 'Installing nvm manually...'
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

echo "Do you wish to install LTS version of NodeJS?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) nvm install --lts; break;;
        No ) nvm install node; break;;
    esac
done

echo 'Downloading Dracula gtk theme...'
wget https://github.com/dracula/gtk/archive/master.zip

echo 'Extracting Dracula gtk theme to /usr/share/themes/...'
$SUDO unzip -q master.zip -d /usr/share/themes/
$SUDO mv /usr/share/themes/master /usr/share/themes/Dracula

echo 'Downloading Dracula Icon theme for gtk...'
wget https://github.com/dracula/gtk/files/5214870/Dracula.zip

echo 'Extracting Dracula Icon theme to /usr/share/icons/...'
$SUDO unzip -q Dracula.zip -d /usr/share/icons/

# TODO: Customise the dock (center, no-extend, auto-hide) and set Dracula as the default theme

echo 'Installing Snap packages...'
for SNAP_PACKAGE in "${SNAP_PACKAGES[@]}"
do
    if ! [ -x "$(command -v $SNAP_PACKAGE ]
    then
        echo "Installing $SNAP_PACKAGE..."
        $SUDO snap install $SNAP_PACKAGE
    else
        echo "$SNAP_PACKAGE is already installed."
        echo 'Skipping...'
    fi
done

echo 'Finished the setup procudure!'
echo 'Your system might need to reboot for changes to take effect!'
# TODO - Add a reboot prompt
echo 'Please check your ~/.zshrc file in case of ERRORS!'