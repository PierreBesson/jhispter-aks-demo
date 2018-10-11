#!/bin/bash
# Files are ordered in proper order with needed wait for the dependent custom resource definitions to get initialized.
# Usage: bash kubectl-apply.sh

kubectl apply -f registry/
kubectl apply -f accountancy/
kubectl apply -f crm/
kubectl apply -f store/
