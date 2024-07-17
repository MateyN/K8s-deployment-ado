#!/bin/bash

cyan="\033[1;36m"
green="\033[1;32m"
yellow="\033[1;33m"
red="\033[1;31m"
reset="\033[0m"
echo
#echo -e "${yellow}MINIKUBE STARTING...${reset}"

#minikube start

echo -e "${yellow}SWITCHING TO <NAMESPACE>...${reset}"
kubens mysql && echo
sleep 3
kubens && echo

echo -e "${yellow}APPLYING KUBERNETES PODS...${reset}"
kubectl apply -f mysql-deployment.yaml
sleep 3
kubectl get deploy && echo
sleep 3

kubectl apply -f mysql-secret.yaml
sleep 3
#kubectl get svc && 
echo
sleep 3

kubectl apply -f mysql-storage.yaml
sleep 3
kubectl get pod && echo

echo -e "${green}SUCCESS!${reset}"
echo

# echo -e "${yellow}GETTING MINIKUBE'S IP AND PORT...${reset}"
# MINIKUBE_IP=$(minikube ip)
# SERVICE_PORT=$(kubectl get svc test -o jsonpath='{.spec.ports[0].nodePort}')
# echo -e "${yellow}SETTING UP... (approx. 1 min)${reset}"
# sleep 50
# #echo -e "${yellow}SETTING UP... (approx. 1 min)${reset}"

# echo -e "${cyan}Application URL:${reset} -> ${green}http://$MINIKUBE_IP:$SERVICE_PORT${reset}"

# curl http://$MINIKUBE_IP:$SERVICE_PORT
echo

echo -e "${green}BUILT SUCCESSFULLY!${reset}"
