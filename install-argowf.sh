#!/bin/bash

# Create namespace
kubectl create namespace argo

# Install argo workflows
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.2/quick-start-postgres.yaml
#kubectl apply -n argo -f argov3.5.2.yaml

# Verify pods status if it's running
echo "Esperando que los pods de Argo Workflows estén en estado 'Running'..."
kubectl wait --for=condition=Ready pod --all -n argo --timeout=300s

# Get argo workflows URL
argo_url=$(minikube service -n argo argo-server --url)
echo $argo_url
