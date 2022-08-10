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

path_to_zshrc="$(which zsh)"

change_shell () {
    echo 'Changing shell to zsh...'
    if [ "$EUID" -eq 0 ]; then # If root, don't change shell
        echo 'Script is running as root. Skipping shell change.'
        echo 'Skipping...'
        return 1
    fi

        chsh -s $path_to_zshrc
}

if [ "$SHELL" != "$path_to_zshrc" ]; then
echo "Do you want to change your default shell to zsh?"
select yn in "Yes" "No"; do
    case $yn in 
        Yes ) change_shell; break;;
        No ) break;;
    esac
done
fi

install_omz () {
echo 'Installing Oh-My-Zsh...'
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" << EndOfCommand
n
EndOfCommand
    
#! Fail if the system doesn't reboot properly or logout and login
# REASON: $ZSH_CUSTOM is not set
# echo 'Installing spaceship prompt...'
# git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    
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
    #! There is no .zfunctions/prompt_spaceshipt_setup
    # echo 'Installing ZSH manually...'
    # echo 'fpath=( "${ZDOTDIR:-$HOME}/.zfunctions" $fpath )' >> ~/.zshrc
    # ln -sf "$PWD/spaceship.zsh" "${ZDOTDIR:-$HOME}/.zfunctions/prompt_spaceship_setup"
    # echo 'autoload -U promptinit; promptinit' >> ~/.zshrc
    # echo 'prompt spaceship' >> ~/.zshrc
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
else
    echo 'NVM is already installed.'
    echo 'Skipping NVM installation...'
fi


if ! [ -x "$(command -v node)" ]
then
    echo "Installing NodeJS..."
echo "Do you wish to install LTS version of NodeJS?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) nvm install --lts; break;;
        No ) nvm install node; break;;
    esac
done
else
    echo "NodeJS is already installed."
    echo 'Skipping NodeJS installation...'
fi

if ! [ -x "$(command -v yarn)" ]
then
    echo 'Installing yarn...'
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install yarn
else
    echo 'Yarn is already installed.'
    echo 'Skipping yarn installation...'
fi

if ! [ -x "$(command -v code)" ]
then
    echo 'Installing VSCode...'
    wget https://go.microsoft.com/fwlink/?LinkID=760868 -O /tmp/code.deb
    $SUDO dpkg -i /tmp/code.deb
else
    echo 'VSCode is already installed.'
    echo 'Skipping VSCode installation...'
fi

if ! [ -x "$(command -v droidcam)" ]
then
    echo 'Installing Droidcam...'
    $SUDO wget -O /tmp/droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.8.2.zip
    unzip /tmp/droidcam_latest.zip -d /tmp/droidcam
    cd /tmp/droidcam/
    $SUDO ./install-client
    $SUDO ./install-video
else
    echo 'Droidcam is already installed!'
    echo 'Skipping...'
fi

if ! [ -d /usr/share/themes/gtk-master ]; then
    echo 'Downloading Dracula gtk theme...'
    $SUDO wget https://github.com/dracula/gtk/archive/master.zip -P /tmp/
echo 'Extracting Dracula gtk theme to /usr/share/themes/...'
    $SUDO unzip -q /tmp/master.zip -d /usr/share/themes/
fi

if ! [ -d /usr/share/icons/Dracula ]; then
echo 'Downloading Dracula Icon theme for gtk...'
    $SUDO wget https://github.com/dracula/gtk/files/5214870/Dracula.zip -P /tmp/
echo 'Extracting Dracula Icon theme to /usr/share/icons/...'
    $SUDO unzip -q /tmp/Dracula.zip -d /usr/share/icons/
fi

echo 'Customising the dock...'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 40
gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode DYNAMIC

echo 'Changing the DESKTOP theme to Dracula...'
echo '[REMEMBER] You can always customize the theme manually using Gnome Tweaks.'
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

echo 'Changing the ICON theme to Dracula...'
gsettings set org.gnome.desktop.interface icon-theme "Dracula"


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