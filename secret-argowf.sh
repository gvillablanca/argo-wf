#!/bin/bash

# Insert secret argo wf
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: argowf-user-token
  annotations:
    kubernetes.io/service-account.name: argo
type: kubernetes.io/service-account-token
EOF

# Bearer
ARGO_TOKEN="Bearer $(kubectl get secret argowf-user-token -o=jsonpath='{.data.token}' -n argo| base64 --decode)"
echo $ARGO_TOKEN

# Creation SA 
kubectl get secret argowf-user-token

# Creation role nessesary
kubectl create role argowf-user --verb=list,update,get,watch,create,update,patch,delete --resource=workflows.argoproj.io -n argo

#
