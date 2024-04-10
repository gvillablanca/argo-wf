#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Run a test container
sudo docker run hello-world

# Add current user to docker group
sudo usermod -aG docker $USER

# Refresh group information
newgrp docker

# Test
docker ps

echo "================================================================================================================================================"
echo "Instalación de Minikube"

# Instalar Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
rm minikube_latest_amd64.deb

# Instalar kubectl
sudo snap install kubectl

# Agregar la ubicación de Minikube al PATH
export PATH=$PATH:/usr/local/bin

# Iniciar Minikube con Docker como driver
minikube start --driver=docker

# Levantar la UI
kubectl -n argo port-forward service/argo-server 2746:2746