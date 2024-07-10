#!/bin/bash
cd nginx/
minikube start

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f pod.yaml

MINIKUBE_IP=$(minikube ip)
SERVICE_PORT=$(kubectl get svc test -o jsonpath='{.spec.ports[0].nodePort}')

echo "Application url: -> http://$MINIKUBE_IP:$SERVICE_PORT"
curl http://$MINIKUBE_IP:$SERVICE_PORT