#!/bin/bash

NAMESPACE=monitoring

kubectl create secret generic my-grafana-secret \
  --from-literal=admin-user=test \
  --from-literal=admin-password=test1234! \
  -n $NAMESPACE \
  --kubeconfig=$KUBE_DEV_PIPELINE_CONFIG
  
helm install grafana grafana/grafana \
  -n $NAMESPACE \
  --values grafana_values.yaml \
  --kubeconfig=$KUBE_DEV_PIPELINE_CONFIG