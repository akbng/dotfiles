# dotfiles

## Install ZSH on ubuntu - Follow Steps:

1. Run `sudo apt update && sudo apt upgrade -y`
2. Run `sudo apt install build-essential curl file git fonts-powerline`
3. Run `sudo apt install zsh`
4. Check if zsh is intalled by running `zsh --version`
5. (OPTIONAL|RECOMMENDED) Now install OH-MY-ZSH by running `sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`. For info on the usage of omz head over to the [official documentation](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet). To update mannually run: `omz update` and to uninstall: `sudo uninstall oh_my_zsh`
6. Clone Space-Ship Prompt: `git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 `
7. Symlink spaceship.zsh-theme to your oh-my-zsh custom themes directory: `ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" `
8. (INSTALL) nvm through zsh-nvm.
   - Clone the repo: `git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm`
9. Clone the **.zshrc** file from the repo and move it to `$HOME/.zshrc`
10. Change the default shell to zsh by running `chsh -s $(which zsh)`

## Setting up git commit signature with gpg

1. Generate a key: `gpg --default-new-key-algo rsa4096 --gen-key`
2. Enter user's real name and email (associated with GitHub) address at the prompt and verify the information.
3. Enter a passphrase for the key.
4. Check if the key is generated successfully by running `gpg --list-keys --keyid-format=long`
5. Export the public key: `gpg --armor --export <email>` or `gpg --armor --export <keyid>`
6. Copy the public key and open [GitHub gpg settings](https://github.com/settings/keys) (login if not already).
7. Click on the <kbd>new GPG key</kbd> and paste the public key and add it.
8. Now configure the git commit signature with gpg:
   - `git config --global commit.gpgsign true`
   - `git config --global user.signingkey <keyid>` (replace <keyid> with the key id) <br>
     Example: `git config --global user.signingkey 4A08EDDA28552B0D`
9. Now export GPG\*TTY to the environment variable: `export GPG_TTY=$(tty)` in the \*\*\_zshrc**\* or **_bashrc_\*\* file.
10. Now all the commits from the terminal will be signed with gpg by default. For more info or troubleshooting see [GitHub Managing commit signature verification](https://docs.github.com/en/authentication/managing-commit-signature-verification).
