#!/bin/bash

NAMESPACE=monitoring

helm install --values loki_values.yaml loki grafana/loki \
--kubeconfig=$KUBE_DEV_PIPELINE_CONFIG \
-n $NAMESPACE