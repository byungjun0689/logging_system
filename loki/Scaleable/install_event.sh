#!/bin/bash

NAMESPACE="monitoring"

helm upgrade --install kubernetes-event-exporter bitnami/kubernetes-event-exporter \
  --namespace ${NAMESPACE} \
  --values exporter_values.yaml \
  --kubeconfig=$KUBE_DEV_PIPELINE_CONFIG