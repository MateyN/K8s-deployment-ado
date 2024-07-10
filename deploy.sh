#!/bin/bash

cyan="\033[1;36m"
green="\033[1;32m"
yellow="\033[1;33m"
red="\033[1;31m"
reset="\033[0m"
echo
cd nginx/
echo -e "${green}MINIKUBE STARTING...${reset}"

minikube start
sleep 10

kubens az-pl
echo -e "${green}SWITCHING TO <NAMESPACE>...${reset}"
sleep 5
kubens

echo -e "${green}APPLYING KUBERNETES PODS...${reset}"
kubectl apply -f deployment.yaml
kubectl get deploy
sleep 3

kubectl apply -f service.yaml
kubectl get svc
sleep 3

kubectl apply -f pod.yaml
kubectl get pod
echo
echo -e "${green}SUCCESS!${reset}"
echo
echo -e "${green}GETTING MINIKUBE'S IP AND PORT...${reset}"
MINIKUBE_IP=$(minikube ip)
SERVICE_PORT=$(kubectl get svc test -o jsonpath='{.spec.ports[0].nodePort}')

sleep 30
echo -e "${green}SETTING UP... (approx.30s)${reset}"

echo -e "${cyan}Application URL:${reset} -> ${green}http://$MINIKUBE_IP:$SERVICE_PORT${reset}"

curl http://$MINIKUBE_IP:$SERVICE_PORT
echo
echo -e "${green}BUILT SUCCESSFULLY!${reset}"
