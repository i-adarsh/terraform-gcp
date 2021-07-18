#!/bin/bash

# Removing the Older Contents
sudo rm -rf /var/lib/apt/lists/*

# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get update -y

# Installing Docker
sudo apt install docker.io -y 

# Starting Docker Services
sudo systemctl enable docker --now

# Intializing Docker Swarm
sudo docker swarm init

# Installin wget for downloading photos
sudo apt install wget -y

# Pulling Docker Image
sudo docker pull nginx:stable

# Launching New Container
sudo docker run -dit -p 8080:80 --name=dunhummby nginx:stable

# Making Restart Script so that docker services continues running even after restart
sudo echo -e '#!/bin/bash\nsudo docker start dunhummby' >> /restartService.sh

# Making Script Executable
sudo chmod +x /restartService.sh

# Setting up Cron Job to run the Script on every Reboot
sudo crontab -l | { sudo cat; sudo echo "@reboot /restartService.sh"; } | sudo crontab -