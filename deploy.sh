#!/bin/bash

# Variables
NAMESPACE="dev"
RELEASE_NAME="my-app"

# Create namespace if it doesn't exist
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Deploy Helm chart
helm upgrade --install $RELEASE_NAME ./my-spring-app-chart --namespace $NAMESPACE

echo "Application deployed successfully!"
