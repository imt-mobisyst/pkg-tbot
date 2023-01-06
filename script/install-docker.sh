#!/usr/bin/env bash

# Cf. https://docs.docker.com/engine/install/ubuntu/

# Cleaning before to go:
sudo apt remove -y docker docker-engine docker.io containerd runc
sudo apt update

# Somme dependancies:
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# reference the repo:
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# lets install docker:
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "%sudo   ALL=(ALL) NOPASSWD: /usr/bin/docker" | sudo tee /etc/sudoers > /dev/null

# pull kobuki image:
sudo docker pull lozenge14/imt-mobisyst:u16kobuki
