#!/bin/bash

green="\033[1;32m"
reset="\033[0m"
echo
echo -e "${green}RUN SCRIPT STARTED!!!${reset}"
#bash ../myagent/run.sh
#sleep 20
#echo "Crash happens here!"
pwd
cd /home/mnikolov/ADO-pipelines/ADO-pipelines/nginx/
chmod +x deploy-nginx.sh
./deploy-nginx.sh