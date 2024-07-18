#!/bin/bash

green="\033[1;32m"
reset="\033[0m"

echo -e "${green}START-AGENT SCRIPT EXECUTED!!!${reset}"

cd /home/mnikolov/myagent || { echo -e "${red}Error: Failed to change directory.${reset}"; exit 1; }

# Runs self-hosted-agent-pool agent in ADO
#sudo ./svc.sh install
#sleep 10
sudo ./svc.sh start
sleep 20

organization="mateynikolov530"
project="mateynikolov530"
pipelineId="1"
personalAccessToken="bdumgvuxsyzckgc2ku5zr3xyzpjhvn3ijv7yy6w6pmtpkr4chvxq"

# Define the REST API URL to trigger the pipeline
apiUrl="https://dev.azure.com/$organization/$project/_apis/pipelines/$pipelineId/runs?api-version=6.0-preview.1"

# Create a JSON payload for the request
payload='{
  "resources": {
    "repositories": {
      "self": {
        "refName": "refs/heads/master"
      }
    }
  }
}'

# Trigger the pipeline
curl -X POST -H "Content-Type: application/json" -u ":$personalAccessToken" -d "$payload" "$apiUrl"
#sleep 10

cd /home/mnikolov/K8s-deployment-ado/ADO-pipelines
./run.sh
