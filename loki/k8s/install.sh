#!/bin/bash
#helm show values grafana/loki-stack > default-values.yaml

MONITORING_NAMESPACE=monitoring
LOCAL_PARENTS_PATH=/Users/khc/workspace/lab/system/log/
LOKI_FOLDER=loki
LOKI_RELEASE_NAME=loki-stack

helm upgrade --install \
    $LOKI_RELEASE_NAME grafana/loki-stack \
    --values $LOCAL_PARENTS_PATH/$LOKI_FOLDER/k8s/override-values.yaml \
    -n $MONITORING_NAMESPACE \
    --create-namespace
