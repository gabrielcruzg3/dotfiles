#!/bin/bash

cd $HOME

sudo apt update
sudo apt upgrade -y

clear

### tools, basic utilities, neededs
    sudo apt install git ubuntu-restricted-extras htop wget curl gnome-keyring \
        ca-certificates \
        curl \
        gnupg \
        lsb-release -y
    
### other utilities
    # make sure flatpak and snap are installed
    sudo apt install snapd flatpak tlp tlp-rdw -y
    # sudo apt install synaptic -y
    cd /tmp && \
        wget -O stacer.deb 'https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb' && \
        sudo apt install ./stacer.deb -y && \
    cd $HOME
    # sudo add-apt-repository ppa:oguzhaninan/stacer -y && \
    # sudo apt update && \
    # sudo apt install stacer -y

### setting up tools
    sudo apt install plasma-discover-backend-flatpak -y
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    #sudo apt install gnome-software-plugin-flatpak -y

### every day to day used
    # i use deb cuz of user data, same goes for edge
        # flatpak install flathub com.google.Chrome
        # flatpak install flathub com.microsoft.Edge
    sudo snap install vlc
    flatpak install flathub com.spotify.Client
    cd /tmp && \
        echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list && \
        wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
        sudo apt update && \
        sudo apt install google-chrome-stable -y && \
    cd $HOME
    


### communication
    sudo snap install telegram-desktop
    flatpak install flathub com.discordapp.Discord

#
### dev tools
    # flatpak installed
    # sudo snap install code --classic
    # asdf installed
    # sudo snap install node --classic
    flatpak install flathub org.kde.kontrast
    flatpak install flathub com.getpostman.Postman
    flatpak install flathub io.dbeaver.DBeaverCommunity
    
    cd /tmp && \
        wget -O code.deb https://code.visualstudio.com/sha/download\?build\=stable\&os\=linux-deb-x64 && \
        sudo apt install ./code.deb -y
        
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt update && \
        sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

    cd $HOME

# thats not the way to install edge anymore (deb package can be downloaded from their website) or flatpak
# cd /tmp && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
# echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge-stable.list
# echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/23.10/prod stable main" | sudo tee /etc/apt/sources.list.d/microsoft-prod-stable.list

# sudo apt update && sudo apt install microsoft-edge-stable spotify-client -y

# otimizations
    # this too down here be bad cuz they kinda break snap apps
    # sudo systemctl disable snapd.service
    # sudo systemctl disable snapd.seeded.service
    sudo systemctl disable apt-daily-upgrade.service

    sudo systemctl disable NetworkManager-wait-online.service
    sudo systemctl mask NetworkManager-wait-online.service
        
    sudo systemctl disable networkd-dispatcher.service
    sudo systemctl disable systemd-networkd.service

    # no longer need all this steps (if cant find only by apt)
    #sudo add-apt-repository ppa:ernstp/mesarc && \
    #sudo apt update && \
    # sudo echo "# Never prefer packages from the ernstp repository
    #         Package: *
    #         Pin: release o=LP-PPA-ernstp-mesarc
    #         Pin-Priority: 1

    #         # Allow upgrading only corectrl from LP-PPA-ernstp-mesarc
    #         Package: corectrl
    #         Pin: release o=LP-PPA-ernstp-mesarc
    #         Pin-Priority: 500" > /etc/apt/preferences.d/corectrl
    sudo apt install corectrl -y


# sudo add-apt-repository ppa:webupd8team/java
# sudo add-apt-repository ppa:linuxuprising/java
#     echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu focal main" | tee /etc/apt/sources.list.d/linuxuprising-java.list
#         sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 73C3DB2A
#             sudo apt update
#                 echo oracle-java17-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections
#                     sudo apt install oracle-java17-installer --install-recommends -y
#                         java --version
# asdf plugin java

sudo apt autoclean
sudo apt autoremove

clear

#vm.swappiness=60
# sudo nano /etc/sysctl.conf

# extras
    git clone https://github.com/linuxdabbler/debian-dialog-install-script && \
    chmod +x dialog.sh && \
    sudo sh ~/debian-dialog-install-script/dialog.sh   

    sudo sh $HOME/zsh-tooler.sh
