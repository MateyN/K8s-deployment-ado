#!/bin/bash

green="\033[1;32m"
reset="\033[0m"
echo
echo -e "${green}RUN SCRIPT STARTED!!!${reset}"
#bash ../myagent/run.sh
cd nginx/
chmod +x deploy-nginx.sh
./deploy-nginx.sh