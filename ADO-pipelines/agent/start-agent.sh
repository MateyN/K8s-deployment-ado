#!/bin/bash

log_file="/home/mnikolov/K8s-deployment-ado/ADO-pipelines/log/start-agent.log"
exec > "$log_file" 2>&1

green="\033[1;32m"
reset="\033[0m"

echo -e "${green}START-AGENT SCRIPT EXECUTED!!!${reset}"

cd /home/mnikolov/myagent || { echo -e "${red}Error: Failed to change directory.${reset}"; exit 1; }

# Runs self-hosted-agent-pool agent in ADO in background
nohup ./agent.sh > agent.log 2>&1 &
agent_pid=$!

sleep 15

if ps -p $agent_pid > /dev/null; then
    echo "Agent is running and listening for jobs."
else
    echo "Agent failed to start or stopped unexpectedly."
    exit 1
fi

flag_file="/tmp/pipeline_triggered"

# Prevent re-triggering if the flag file exists
if [ -f "$flag_file" ]; then
    echo "Pipeline already triggered. Exiting."
    exit 0
fi

organization="mateynikolov530"
project="mateynikolov530"
pipelineId="1"
# personalAccessToken="PAT HERE"
# Add the PAT from Azure here. Deleted for security measures.


# Define the REST API URL to trigger the pipeline
apiUrl="https://dev.azure.com/$organization/$project/_apis/pipelines/$pipelineId/runs?api-version=6.0-preview.1"

# Create a JSON payload for the request
payload=$(cat <<EOF
{
  "resources": {
    "repositories": {
      "self": {
        "refName": "refs/heads/master"
      }
    }
  }
}
EOF
)
# Trigger the pipeline using curl and capture the response
response=$(curl -s -o response.txt -w "%{http_code}" -X POST -H "Content-Type: application/json" -u ":$personalAccessToken" -d "$payload" "$apiUrl")

# Read the response content
response_content=$(cat response.txt)

echo "HTTP Response Code: $response"
echo "Response Content: $response_content"

if [ "$response" -eq 200 ] || [ "$response" -eq 201 ]; then
  echo "Pipeline triggered successfully."
  touch "$flag_file"
else
  echo "Failed to trigger the pipeline."
  rm "$flag_file"
  exit 1
fi

cd /home/mnikolov/K8s-deployment-ado/ADO-pipelines
./run.sh > /dev/null 2>&1

echo "Script completed successfully."

#rm -f "$flag_file"

