#!/bin/bash

green="\033[1;32m"
reset="\033[0m"

echo -e "${green}START-AGENT SCRIPT EXECUTED!!!${reset}"

cd /home/mnikolov/myagent || { echo -e "${red}Error: Failed to change directory.${reset}"; exit 1; }

# Runs self-hosted-agent-pool agent in ADO in background
./agent.sh
agent_pid=$!

#sleep 15

if ps -p $agent_pid > /dev/null; then
    echo "Agent is running and listening for jobs."
else
    echo "Agent failed to start or stopped unexpectedly."
    exit 1
fi

organization="mateynikolov530"
project="mateynikolov530"
pipelineId="1"
personalAccessToken="767aj6vatva5h56rzu4jezwbehnhe2aaeali2fgwdcnucvfoicva"

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
#sleep 10
echo "Response from Azure DevOps:"
echo "$response"
cd /home/mnikolov/K8s-deployment-ado/ADO-pipelines
./run.sh

echo "Script completed successfully."

