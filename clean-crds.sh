#!/bin/bash

# Download the CRDs
kubectl get crd sparkapplications.sparkoperator.k8s.io -o yaml > sparkapplications.yaml
kubectl get crd scheduledsparkapplications.sparkoperator.k8s.io -o yaml > scheduledsparkapplications.yaml

# Remove large annotations
sed -i '/^    controller-gen.kubebuilder.io\/version:/d' sparkapplications.yaml
sed -i '/^    controller-gen.kubebuilder.io\/version:/d' scheduledsparkapplications.yaml

# Apply the cleaned CRDs
kubectl apply -f sparkapplications.yaml
kubectl apply -f scheduledsparkapplications.yaml

# Clean up
rm sparkapplications.yaml scheduledsparkapplications.yaml 