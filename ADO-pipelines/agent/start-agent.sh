#!/bin/bash

green="\033[1;32m"
reset="\033[0m"
: <<'END_COMMENT'
# Function to handle Ctrl-C
function ctrl_c() {
    echo ""
    echo "Ctrl-C caught... Stopping agent and exiting."
    # Stop the agent service if it's running
    sudo ./svc.sh stop
    exit 1
}
END_COMMENT
echo -e "${green}START-AGENT SCRIPT EXECUTED!!!${reset}"

cd /home/mnikolov/myagent || { echo -e "${red}Error: Failed to change directory.${reset}"; exit 1; }

# Runs self-hosted-agent-pool agent in ADO in background
./agent.sh
#agent_pid=$!
: <<'END_COMMENT'
# Trap Ctrl-C signal
trap ctrl_c INT

# Wait for the agent to start listening for jobs (adjust sleep duration as needed)
echo "Waiting for agent to start listening for jobs..."
sleep 30  # Adjust this sleep duration based on how long it takes for the agent to start

# Start the agent service
sudo ./svc.sh start
sleep 20
END_COMMENT
#if ps -p $agent_pid > /dev/null; then
#    echo "Agent is running and listening for jobs."
#else
#    echo "Agent failed to start or stopped unexpectedly."
#    exit 1
#fi

organization="mateynikolov530"
project="mateynikolov530"
pipelineId="1"
personalAccessToken="sijnb5ewft44ve3lhtzcfciswey25zijie2jjx4o66yqihpp7bvq"

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

#cd /home/mnikolov/K8s-deployment-ado/ADO-pipelines
#./run.sh

# End of script
echo "Script completed successfully."

