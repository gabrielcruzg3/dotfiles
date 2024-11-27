#!/bin/bash

cd $HOME

sudo apt update && sudo apt upgrade -y

clear

### tools, basic utilities, neededs
    sudo apt install -y \
        # everytime needed:
        git wget curl gnupg openssh-server xrdp \
        # ubuntu desktop needed:
        ubuntu-restricted-extras htop lsb-release ca-certificates \
        # kde 18.04 and before needed:
        #gnome-keyring
### other utilities
    # make sure flatpak and snap are installed
    sudo apt install flatpak plasma-discover-backend-flatpak -y
        # when running on laptop:
    #sudo apt install tlp tlp-rdw -y
    #   just cuz i sometimes brake apt then gotta solve it:
    sudo apt install synaptic -y

    # sudo add-apt-repository ppa:oguzhaninan/stacer -y && \
    # sudo apt update && \
    # sdstacer -y
    cd /tmp && \
        wget -O stacer.deb 'https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb' && \
        sudo apt install ./stacer.deb -y && \
    cd $HOME

### setting up tools
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    #sudo apt install gnome-software-plugin-flatpak -y

### every day to day used
    # i use deb cuz of user data, same goes for edge
        # flatpak install flathub com.google.Chrome
        # flatpak install flathub com.microsoft.Edge
    sudo snap install vlc telegram-desktop
    flatpak install flathub com.spotify.Client com.discordapp.Discord
    cd /tmp && \
        echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list && \
        wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
        sudo apt update && \
        sudo apt install google-chrome-stable -y

###setup remote access
    sudo systemctl enable ssh
    sudo ufw allow ssh
    #sudo nano /etc/xrdp/xrdp.ini
    #port=3389
    sudo ufw allow 3389/tcp
    sudo ufw allow 3389/udp
    curl -fsSL https://tailscale.com/install.sh | sh
    cd $HOME
    

### dev tools
    # flatpak installed
    # sudo snap install code --classic
        # TODO asdf installer, shall create yet another sh to setup node, java and dotnet (for now)
        # git clone https://github.com/asdf-vm/asdf.git ~/.asdf
        # ? done:
    sh $HOME/asdf.sh
    # sudo snap install node --classic
    flatpak install flathub org.kde.kontrast com.getpostman.Postman io.dbeaver.DBeaverCommunity
    
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

        sudo groupadd docker
        sudo usermod -aG docker $USER      
        #just in case
        sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
        sudo chmod g+rwx "$HOME/.docker" -R

        sudo systemctl enable docker.service
        sudo systemctl enable containerd.service

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

### gaming aka minecraft
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
sudo apt autoremove -y

#vm.swappiness=60
# sudo nano /etc/sysctl.conf

# extras
    #git clone https://github.com/linuxdabbler/debian-dialog-install-script && \
    #chmod +x dialog.sh && \
    #sudo sh ~/debian-dialog-install-script/dialog.sh   

    sudo sh $HOME/zsh-tooler.sh
