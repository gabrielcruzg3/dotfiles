#!/bin/bash

sudo apt install zsh git -y

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && exit

sudo rm -rf $ZSH_CUSTOM/themes/spaceship-prompt/
sudo rm -f $ZSH_CUSTOM/themes/spaceship.zsh-theme

git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" && \
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

sudo rm -rf  $ZSH_CUSTOM/plugins/zsh-syntax-highlighting    
sudo rm -rf  $ZSH_CUSTOM/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

chsh -s $(which zsh)

cd $HOME
git restore ./.zshrc
