# dotfiles

Install ZSH on ubuntu - Follow Steps:

1. Run `sudo apt update && sudo apt upgrade -y`
2. Run `sudo apt install build-essential curl file git fonts-powerline`
3. Run `sudo apt install zsh`
4. Check if zsh is intalled by running `zsh --version`
5. (OPTIONAL|RECOMMENDED) Now install OH-MY-ZSH by running `sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`. For info on the usage of omz head over to the [official documentation](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet). To update mannually run: `omz update` and to uninstall: `sudo uninstall oh_my_zsh`
6. Clone Space-Ship Prompt: `git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 `
7. Symlink spaceship.zsh-theme to your oh-my-zsh custom themes directory: `ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" `
8. (INSTALL) nvm through zsh-nvm.
   - Clone the repo: `git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm`
9. clone the **.zshrc** file from the repo and move it to `$HOME/.zshrc`
