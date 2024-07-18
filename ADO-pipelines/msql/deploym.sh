#!/bin/bash

cyan="\033[1;36m"
green="\033[1;32m"
yellow="\033[1;33m"
reset="\033[0m"

ns="mysql"
echo -e "${yellow}SWITCHING TO mysql namespace...${reset}"
kubens "$ns"

apply_resources() {
    kubectl apply -f "$1"
    sleep 3
}

apply_resources mysql-deployment.yaml
apply_resources mysql-secret.yaml
apply_resources mysql-storage.yaml

echo
echo -e "${green}SUCCESSFULLY DEPLOYED!${reset}"

sleep 50

cd /home/mnikolov/myagent/
sudo ./svc.sh stop
