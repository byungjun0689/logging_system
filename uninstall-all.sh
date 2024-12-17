#!/bin/bash

# Create Namespace
AIRFLOW_NAMESPACE=hrs
AIRFLOW_RELEASE_NAME=khc-airflow

MONITORING_NAMESPACE=monitoring
LOCAL_PARENTS_PATH=/Users/khc/workspace/lab/system/log/
LOKI_RELEASE_NAME=loki-stack

PROMETHUES_RELEASE_NAME=prometheus

if ! kubectl get namespace $AIRFLOW_NAMESPACE > /dev/null 2>&1; then
  echo "Namespace '$AIRFLOW_NAMESPACE' does not exist."
else
  echo "Namespace '$AIRFLOW_NAMESPACE' already exists. start uninstalling..."
  if helm list -n hrs | grep $AIRFLOW_RELEASE_NAME; then 
    echo "Helm release '$AIRFLOW_RELEASE_NAME' start uninstalling..."
    helm uninstall $AIRFLOW_RELEASE_NAME -n $AIRFLOW_NAMESPACE
    echo "Helm release '$AIRFLOW_RELEASE_NAME' uninstalled."
    kubectl delete namespace $AIRFLOW_NAMESPACE
    echo "Namespace '$AIRFLOW_NAMESPACE' deleted."
  fi
fi

# monitoring
if ! kubectl get namespace $MONITORING_NAMESPACE > /dev/null 2>&1; then
  echo "Namespace '$MONITORING_NAMESPACE' does not exist."
else
  echo "Namespace '$MONITORING_NAMESPACE' already exists."
  if helm list -n $MONITORING_NAMESPACE | grep $LOKI_RELEASE_NAME; then 
    echo "Helm release '$LOKI_RELEASE_NAME' start uninstalling..."
    helm uninstall $LOKI_RELEASE_NAME -n $MONITORING_NAMESPACE
    echo "Helm release '$LOKI_RELEASE_NAME' uninstalled."
  fi
 
  if helm list -n $MONITORING_NAMESPACE | grep $PROMETHUES_RELEASE_NAME; then 
    echo "Helm release '$PROMETHUES_RELEASE_NAME' start uninstalling..."
    helm uninstall $PROMETHUES_RELEASE_NAME -n $MONITORING_NAMESPACE
    echo "Helm release '$PROMETHUES_RELEASE_NAME' uninstalled."
  fi

  kubectl delete namespace $MONITORING_NAMESPACE
fi