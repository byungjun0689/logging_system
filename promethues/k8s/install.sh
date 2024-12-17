#!/bin/bash
LOCAL_PARENTS_PATH=/Users/khc/workspace/lab/system/log/
PROMETHUES_FOLDER=promethues
PROMETHUES_RELEASE_NAME=prometheus

helm install \
    $PROMETHUES_RELEASE_NAME prometheus-community/kube-prometheus-stack \
    -n monitoring \
    --values $LOCAL_PARENTS_PATH/$PROMETHUES_FOLDER/k8s/override_values.yaml \
    --create-namespace