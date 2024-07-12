#!/bin/bash

green="\033[1;32m"
reset="\033[0m"
echo
echo -e "${green}START-AGENT SCRIPT EXECUTED!!!${reset}"

#cd /home/mnikolov/myagent
# Runs self-hosted-agent-pool agent in ADO
./run.sh
