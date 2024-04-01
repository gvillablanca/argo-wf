#!/bin/bash

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

