#!/bin/bash

if [ -f /tmp/agent.pid ]; then
    agent_pid=$(cat /tmp/agent.pid)

    kill $agent_pid

    rm /tmp/agent.pid

    echo "Agent process stopped and PID file cleaned up."
else
    echo "No PID file found. The agent may not be running."
fi

kubectl get pods
kubectl delete pod msql && sleep 5
kubectl get deploys && sleep 5
kubectl delete deploy msql && sleep 5
kubens az-pl && sleep 5
kubectl get pods && sleep 5
kubectl delete pod nginx && sleep 5
kubectl get deploy && sleep 5
kubectl delete deploy nginx && sleep 5

minikube stop

#sleep 10
#cd /home/mnikolov/K8s-deployment-ado/ADO-pipelines/log/ && rm -rf *.log
