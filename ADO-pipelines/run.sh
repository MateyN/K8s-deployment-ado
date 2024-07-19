#!/bin/bash

log_file="/home/mnikolov/K8s-deployment-ado/ADO-pipelines/log/run.log"
exec > "$log_file" 2>&1

green="\033[1;32m"
reset="\033[0m"
echo
echo -e "${green}RUN SCRIPT STARTED!!!${reset}"
pwd
cd /home/mnikolov/K8s-deployment-ado/ADO-pipelines/nginx || { echo -e "${red}Error: Failed to change directory.${reset}"; exit 1; }
chmod +x deploy-nginx.sh
./deploy-nginx.sh > /dev/null 2>&1

