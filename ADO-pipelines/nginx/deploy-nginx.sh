#!/bin/bash

cyan="\033[1;36m"
green="\033[1;32m"
yellow="\033[1;33m"
reset="\033[0m"

echo -e "${yellow}MINIKUBE STARTING...${reset}"
minikube start

ns="az-pl"
echo -e "${yellow}SWITCHING TO $namespace namespace...${reset}"
kubens "$ns"

apply_resources() {
    kubectl apply -f "$1"
    sleep 3
}

apply_resources deployment.yaml
apply_resources service.yaml
apply_resources pod.yaml

echo -e "${green}SUCCESS!${reset}"

MINIKUBE_IP=$(minikube ip)
SERVICE_PORT=$(kubectl get svc test -o jsonpath='{.spec.ports[0].nodePort}')

echo -e "${yellow}SETTING UP... (approx. 1 min)${reset}"
sleep 50

echo -e "${cyan}Application URL:${reset} -> ${green}http://$MINIKUBE_IP:$SERVICE_PORT${reset}"
curl "http://$MINIKUBE_IP:$SERVICE_PORT" && echo

echo -e "${green}SUCCESSFULLY DEPLOYED!${reset}"

