#!/bin/bash

# SDB2
# cd /mnt/
# sudo mkdir hd1sdb2 && /
#     sudo chmod 777 ./hd1sdb2/ && /
#         sudo mount /dev/sdb2 /mnt/hd1sdb2
# SDA1
# cd /mnt/
# sudo mkdir hd2sda1 && /
#     sudo chmod 777 ./hd2sda1/ && /
#         sudo mount /dev/sdb2 /mnt/hd2sda1
#
cd $HOME
#
#clear
# 
sudo apt-get update
sudo apt-get upgrade -y
#
#
clear

### tools, basic utilities, neededs
    sudo apt install git  ubuntu-restricted-extras htop wget curl gnome-keyring  -y
    
### other utilities
    # make sure flatpak and snap are installed
    sudo apt install snapd flatpak tlp tlp-rdw -y
    # sudo apt install synaptic -y

### setting up tools
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    #sudo apt install gnome-software-plugin-flatpak -y

### every day to day used
sudo snap install vlc

### communication
sudo snap install telegram-desktop

#
### dev tools
    # flatpak installed
    # sudo snap install code --classic
    # asdf installed
    # sudo snap install node --classic
#
#
cd /tmp && \
    wget -O stacer.deb 'https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb' && \
        sudo apt install ./stacer*.deb -y
# sudo add-apt-repository ppa:oguzhaninan/stacer -y && \
# sudo apt-get update && \
# sudo apt-get install stacer -y
#
#clear
#
# BEGIN SECTION
# dead, use flatpak or snap
# wget -O discord.deb 'https://discord.com/api/download?platform=linux&format=deb' && \
#     sudo apt install ./discord*.deb  -y
        #sudo apt install libappindicator1 libatomic1 libc++1 libc++abi1 libdbusmenu-gtk4 libindicator7 -y
# wget -O discord.flatpakref https://dl.flathub.org/repo/appstream/com.discordapp.Discord.flatpakref && \
#     flatpak install ./discord.flatpakref
    flatpak install flathub com.discordapp.Discord
#
# wget -O kontrast.flatpakref https://dl.flathub.org/repo/appstream/org.kde.kontrast.flatpakref && \
#     flatpak install ./kontrast.flatpakref
    flatpak install flathub org.kde.kontrast
#
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
        sudo apt update && \
            sudo apt install google-chrome-stable -y
    #sudo apt install ./google-chrome-stable_current_amd64.deb 
    # /usr/bin/google-chrome-stable --enable-crashpad --flag-switches-begin --top-chrome-touch-ui=disabled --enable-features=SidePanelDragAndDrop --flag-switches-end
#
# END SECTION
#clear
#
wget -O code.deb https://code.visualstudio.com/sha/download\?build\=stable\&os\=linux-deb-x64 && \
    sudo apt install ./code.deb
#
#clear
#
cd $HOME

# thats now the way to install edge anymore (deb package can be downloaded from their website)
# cd /tmp && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
# echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge-stable.list
# echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/23.10/prod stable main" | sudo tee /etc/apt/sources.list.d/microsoft-prod-stable.list

# i dont think spotify is working this way (kubuntu 23.04)
# cd /tmp && curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
# echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
#shall install as flatpak
flatpak install flathub com.spotify.Client

# sudo apt update && sudo apt install microsoft-edge-stable spotify-client -y
flatpak install flathub com.microsoft.Edge

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
cd /tmp && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

cd $HOME
#
# sudo systemctl disable snapd.service
# sudo systemctl disable snapd.seeded.service
sudo systemctl disable apt-daily-upgrade.service

sudo systemctl disable NetworkManager-wait-online.service
    sudo systemctl mask NetworkManager-wait-online.service
    
sudo systemctl disable networkd-dispatcher.service
sudo systemctl disable systemd-networkd.service
#
#clear
#
#sudo add-apt-repository ppa:ernstp/mesarc && \
    #sudo apt-get update && \
        #sudo apt install corectrl -y
#
#clear
#
sudo apt install ubuntu-restricted-extras -y
#
#clear
#
# sudo add-apt-repository ppa:webupd8team/java
# sudo add-apt-repository ppa:linuxuprising/java
#     echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu focal main" | tee /etc/apt/sources.list.d/linuxuprising-java.list
#         sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 73C3DB2A
#             sudo apt-get update
#                 echo oracle-java17-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections
#                     sudo apt-get install oracle-java17-installer --install-recommends -y
#                         java --version
# asdf plugin java
#
#clear
#
git clone https://github.com/linuxdabbler/debian-dialog-install-script && \
    chmod +x dialog.sh && \
        sudo sh ~/debian-dialog-install-script/dialog.sh   
#
#clear
#
sudo apt autoclean
sudo apt autoremove
#
#clear
#
#clear
#vm.swappiness=60
# sudo nano /etc/sysctl.conf

sudo sh $HOME/zsh-tooler.sh
