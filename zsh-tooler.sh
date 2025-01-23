#!/bin/bash

echo "Installing zsh and git..."
sudo apt install zsh git -y

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

echo "Installing Oh My Zsh..."
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && exit

echo "Removing existing spaceship-prompt theme..."
sudo rm -rf $ZSH_CUSTOM/themes/spaceship-prompt/
sudo rm -f $ZSH_CUSTOM/themes/spaceship.zsh-theme

echo "Cloning spaceship-prompt theme..."
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" && \
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "Removing existing zsh-syntax-highlighting and zsh-autosuggestions plugins..."
sudo rm -rf $ZSH_CUSTOM/plugins/zsh-syntax-highlighting    
sudo rm -rf $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo "Cloning zsh-syntax-highlighting plugin..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "Cloning zsh-autosuggestions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo "Changing default shell to zsh..."
chsh -s $(which zsh)

echo "Restoring .zshrc..."
cd $HOME

git restore ~/.zshrc

echo "zsh-tooler.sh script completed."

zsh -c "source ~/.zshrc"

exit
