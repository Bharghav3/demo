#!/bin/bash

# Build Docker image
./mvnw clean package
docker build -t bharghav/myapp:latest .

# Create namespace if it doesn't exist
kubectl create namespace dev

# Deploy Helm chart
helm upgrade --install demo ./myapp-chart --namespace dev
sleep 60
echo "Application deployed successfully!"

# Enable Port forward 
kubectl port-forward svc/demo-myapp-chart 8080:8080 -n dev