sudo apt install zsh git -y

chsh -s $(which zsh)
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && exit

rm -rf $ZSH_CUSTOM/themes/spaceship-prompt/
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"

rm -f /home/g3/.oh-my-zsh/custom/themes/spaceship.zsh-theme     
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

rm -rf /home/g3/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting    
git clone -f https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


rm -rf /home/g3/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone -f https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
