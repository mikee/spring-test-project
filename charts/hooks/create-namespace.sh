#!/bin/sh

NAMESPACE="test-one" 

# Check if the namespace exists
if kubectl get namespace "$NAMESPACE" > /dev/null 2>&1; then
  echo "Namespace '$NAMESPACE' already exists. Skipping creation."
else
  # Create the namespace
  kubectl create namespace "$NAMESPACE"
  echo "Namespace '$NAMESPACE' created successfully."
fi
