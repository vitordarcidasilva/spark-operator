#!/bin/bash

# Download the CRDs from the Helm chart
helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
helm repo update
helm pull spark-operator/spark-operator --version 1.1.27 --untar

# Clean the CRDs
for crd in spark-operator/crds/*.yaml; do
  # Remove large annotations
  sed -i '/^    controller-gen.kubebuilder.io\/version:/d' "$crd"
  # Apply the cleaned CRD
  kubectl apply -f "$crd"
done

# Cleanup
rm -rf spark-operator 