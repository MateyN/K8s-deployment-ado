#!/bin/bash

cyan="\033[1;36m"
green="\033[1;32m"
yellow="\033[1;33m"
red="\033[0;31m"
reset="\033[0m"

log_file="/home/mnikolov/K8s-deployment-ado/ADO-pipelines/log/deploym.log"
exec > "$log_file" 2>&1

ns="mysql"
echo -e "${yellow}SWITCHING TO mysql namespace...${reset}"
sleep 10
kubens "$ns"
sleep 5

apply_resources() {
    if [ -f "$1" ]; then
        kubectl apply -f "$1"
        sleep 3
    else
        echo -e "${red}Error: The path '$1' does not exist.${reset}"
        exit 1
    fi
}

# Change to the directory where the YAML files are located
cd /home/mnikolov/K8s-deployment-ado/ADO-pipelines/msql || { echo -e "${red}Error: Failed to change directory to /home/mnikolov/K8s-deployment-ado/ADO-pipelines/msql.${reset}"; exit 1; }

apply_resources mysql-deployment.yaml
apply_resources mysql-secret.yaml
apply_resources mysql-storage.yaml

echo
echo -e "${green}SUCCESSFULLY DEPLOYED!${reset}"

flag_file="/tmp/pipeline_triggered"
if [ -f "$flag_file" ]; then
    rm "$flag_file"
    echo "Cleaned up the flag file."
fi

cd /home/mnikolov/K8s-deployment-ado/ADO-pipelines/ && ./cleanup.sh

echo -e "${green}Clean up done!${reset}"
