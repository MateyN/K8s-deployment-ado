#!/bin/bash

green="\033[1;32m"
reset="\033[0m"
echo
echo -e "${green}START-AGENT SCRIPT EXECUTED!!!${reset}"

cd /home/mnikolov/myagent
# Runs self-hosted-agent-pool agent in ADO
./run.sh

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
        "refName": "refs/heads/master"  # Specify the branch you want to trigger
      }
    }
  }
}'

# Trigger the pipeline using curl
curl -X POST -H "Content-Type: application/json" -u ":$personalAccessToken" -d "$payload" "$apiUrl"
