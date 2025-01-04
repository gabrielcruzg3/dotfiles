#!/bin/bash

DEBIAN_FRONTEND=noninteractive
LOG_FILE="$HOME/builder.log"
STACER_URL="https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb"
CHROME_URL="https://dl.google.com/linux/linux_signing_key.pub"
CHROME_LIST="/etc/apt/sources.list.d/google-chrome.list"

cd $HOME

log_and_run() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') Running: $@" | tee -a "$LOG_FILE"
    "$@" >> "$LOG_FILE" 2>&1
    local status=$?

    if [ $status -ne 0 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') Error executing: $@" | tee -a "$LOG_FILE"
        echo "$(date '+%Y-%m-%d %H:%M:%S') Check the log file for more details: $LOG_FILE" | tee -a "$LOG_FILE"
        exit 1
    fi
}

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --all                Run all steps"
    echo "  --update             Update and upgrade system"
    echo "  --install-tools      Install essential tools"
    echo "  --install-stacer     Install Stacer"
    echo "  --setup-flatpak      Setup Flatpak"
    echo "  --install-apps       Install everyday applications"
    echo "  --setup-remote       Setup remote access"
    echo "  --install-dev-tools  Install development tools"
    echo "  --install-docker     Install Docker"
    echo "  --optimize-system    Apply system optimizations"
    echo "  --install-corectrl   Install CoreCtrl"
    echo "  --cleanup            Cleanup system"
    echo "  --extras             Run extra steps"
    echo "  --help               Display this help message"
}

check_root() {
    if [ "$EUID" == 0 ]; then
        echo "Please do not run as root"
        exit 1
    fi
}

update_and_upgrade() {
    echo "Updating and upgrading system..."
    log_and_run sudo apt update -y
    log_and_run sudo apt upgrade -y
}

install_essential_tools() {
    echo "Installing essential tools..."
    log_and_run sudo apt install -y \
        git wget curl gnupg openssh-server xrdp \
        htop lsb-release ca-certificates synaptic \
        snapd flatpak plasma-discover-backend-flatpak 

    sudo apt install ubuntu-restricted-extras -y
}

install_stacer() {
    echo "Installing Stacer..."
    cd /tmp
    log_and_run wget -O stacer.deb "$STACER_URL"
    log_and_run sudo apt install ./stacer.deb -y
    cd $HOME
}

setup_flatpak() {
    echo "Setting up Flatpak..."
    log_and_run flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    log_and_run flatpak install flathub
}

install_everyday_apps() {
    echo "Installing everyday applications..."
    log_and_run sudo snap install vlc
    log_and_run sudo snap install telegram-desktop
    log_and_run sudo snap install discord
    log_and_run sudo snap install spotify
    log_and_run flatpak install com.microsoft.Edge -y
    # log_and_run flatpak install com.spotify.Client com.discordapp.Discord -y
    cd /tmp
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee "$CHROME_LIST"
    log_and_run wget -q -O - "$CHROME_URL" | sudo apt-key add -
    log_and_run sudo apt update
    log_and_run sudo apt install google-chrome-stable -y
    cd $HOME
}

setup_remote_access() {
    echo "Setting up remote access..."
    log_and_run sudo systemctl enable ssh
    log_and_run sudo ufw allow ssh
    log_and_run sudo ufw allow 3389/tcp
    log_and_run sudo ufw allow 3389/udp
    log_and_run curl -fsSL https://tailscale.com/install.sh | sh
    cd $HOME
}

install_dev_tools() {
    echo "Installing development tools..."
    sh $HOME/asdf.sh
    log_and_run flatpak install org.kde.kontrast io.dbeaver.DBeaverCommunity -y
    log_and_run sudo snap install postman
    cd /tmp
    log_and_run wget -O code.deb https://code.visualstudio.com/sha/download\?build\=stable\&os\=linux-deb-x64
    log_and_run sudo apt install ./code.deb -y
    cd $HOME
}

install_docker() {
    echo "Installing Docker..."
    log_and_run sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    log_and_run sudo apt update
    log_and_run sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

    sudo groupadd docker
    sudo usermod -aG docker $USER
    sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
    sudo chmod g+rwx "$HOME/.docker" -R

    log_and_run sudo systemctl enable docker.service
    log_and_run sudo systemctl enable containerd.service

    cd $HOME
}

system_optimizations() {
    echo "Applying system optimizations..."
    log_and_run sudo systemctl disable apt-daily-upgrade.service
    log_and_run sudo systemctl disable NetworkManager-wait-online.service
    log_and_run sudo systemctl mask NetworkManager-wait-online.service
    log_and_run sudo systemctl disable networkd-dispatcher.service
    log_and_run sudo systemctl disable systemd-networkd.service
}

install_corectrl() {
    echo "Installing CoreCtrl..."
    log_and_run sudo apt install corectrl -y
}

cleanup() {
    echo "Cleaning up system..."
    log_and_run sudo apt autoclean
    log_and_run sudo apt autoremove -y
}

extras() {
    echo "Running extra steps..." | tee -a "$LOG_FILE"
    cd $HOME

    if [ -f "./zsh-tooler.sh" ]; then
        echo "Found zsh-tooler.sh, making it executable and running it..." | tee -a "$LOG_FILE"
        sudo chmod +x ./zsh-tooler.sh
        sudo sh ./zsh-tooler.sh
    else
        echo "Script $HOME/zsh-tooler.sh not found" | tee -a "$LOG_FILE"
    fi
}

main() {
    check_root

    case "$1" in
        --all)
            update_and_upgrade
            install_essential_tools
            # install_stacer
            setup_flatpak
            install_everyday_apps
            setup_remote_access
            install_dev_tools
            install_docker
            system_optimizations
            install_corectrl
            cleanup
            extras
            ;;
        --update) update_and_upgrade ;;
        --install-tools) install_essential_tools ;;
        --install-stacer) install_stacer ;;
        --setup-flatpak) setup_flatpak ;;
        --install-apps) install_everyday_apps ;;
        --setup-remote) setup_remote_access ;;
        --install-dev-tools) install_dev_tools ;;
        --install-docker) install_docker ;;
        --optimize-system) system_optimizations ;;
        --install-corectrl) install_corectrl ;;
        --cleanup) cleanup ;;
        --extras) extras ;;
        --help) usage ;;
        *)
            echo "Invalid option: $1"
            usage
            exit 1
            ;;
    esac
}

main "$@"
