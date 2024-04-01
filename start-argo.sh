#!/bin/bash

minikube start --driver=docker

kubectl -n argo port-forward service/argo-server 2746:2746
