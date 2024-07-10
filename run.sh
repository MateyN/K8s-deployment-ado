#!/bin/bash

green="\033[1;32m"
reset="\033[0m"
echo
echo -e "${green}RUN SCRIPT STARTED!!!${reset}"
#bash ../myagent/run.sh
chmod +x deploy.sh
./deploy.sh