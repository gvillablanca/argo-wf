#!/bin/bash

echo "Levantar Argo Workflows"
# Create namespace
kubectl create namespace argo

#
echo "================================================================================================================================================"

# Install argo workflows
#kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.2/quick-start-postgres.yaml
#kubectl apply -n argo -f argov3.5.2.yaml
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.2/quick-start-postgres.yaml

#
echo "================================================================================================================================================"

#
kubectl get all -n argo

# Verify pods status if it's running
echo "Esperando que los pods de Argo Workflows estén en estado 'Running'..."
#kubectl wait --for=condition=Ready pod --all -n argo --timeout=300s

#
echo "================================================================================================================================================"
echo "Instalacion de Cliente"

# Download the binary
curl -sLO https://github.com/argoproj/argo-workflows/releases/download/v3.5.5/argo-linux-amd64.gz

# Unzip
gunzip argo-linux-amd64.gz

# Make binary executable
chmod +x argo-linux-amd64

# Move binary to path
mv ./argo-linux-amd64 /usr/local/bin/argo

# Test installation
argo version

echo "================================================================================================================================================"
echo "Prueba cliente Argo"

argo submit -n argo --watch https://raw.githubusercontent.com/argoproj/argo-workflows/main/examples/hello-world.yaml

argo list -n argo

echo "================================================================================================================================================"
echo "parchar argo"

kubectl patch deployment \
  argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
  "server",
  "--auth-mode=server"
]}]'

echo "================================================================================================================================================"
echo "parchar argo"