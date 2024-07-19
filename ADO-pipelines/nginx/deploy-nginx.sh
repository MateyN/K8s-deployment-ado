#!/bin/bash

log_file="/home/mnikolov/K8s-deployment-ado/ADO-pipelines/log/deploy-nginx.log"
exec > "$log_file" 2>&1

cyan="\033[1;36m"
green="\033[1;32m"
yellow="\033[1;33m"
reset="\033[0m"

echo -e "${yellow}MINIKUBE STARTING...${reset}"
minikube start > /dev/null 2>&1

ns="az-pl"
echo -e "${yellow}SWITCHING TO $namespace namespace...${reset}"
kubens "$ns" > /dev/null 2>&1

apply_resources() {
    kubectl apply -f "$1" > /dev/null 2>&1
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
curl "http://$MINIKUBE_IP:$SERVICE_PORT" && echo > /dev/null 2>&1

echo -e "${green}SUCCESSFULLY DEPLOYED!${reset}"

