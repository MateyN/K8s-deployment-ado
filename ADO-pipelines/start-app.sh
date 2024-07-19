#!/bin/bash

green="\033[1;32m"
reset="\033[0m"
echo
cd /home/mnikolov/K8s-deployment-ado/ADO-pipelines/agent/ || { echo -e "${red}Error: Failed to change directory.${reset}"; exit 1; }

./start-agent.sh
