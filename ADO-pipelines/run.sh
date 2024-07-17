#!/bin/bash

green="\033[1;32m"
reset="\033[0m"
echo
echo -e "${green}RUN SCRIPT STARTED!!!${reset}"
cd /home/mnikolov/K8s-deployment-ado/ADO-pipelines/agent/ || { echo -e "${red}Error: Failed to change directory.${reset}"; exit 1; }

./start-agent.sh
sleep 20
#echo "Crash happens here!"
pwd
cd /home/mnikolov/ADO-pipelines/ADO-pipelines/nginx/ || { echo -e "${red}Error: Failed to change directory.${reset}"; exit 1; }
chmod +x deploy-nginx.sh
./deploy-nginx.sh
