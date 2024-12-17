#!/bin/bash

# Create Namespace
AIRFLOW_NAMESPACE=hrs
AIRFLOW_RELEASE_NAME=khc-airflow

MONITORING_NAMESPACE=monitoring
LOCAL_PARENTS_PATH=/Users/khc/workspace/lab/system/log/
LOKI_RELEASE_NAME=loki-stack

PROMETHUES_RELEASE_NAME=prometheus

if ! kubectl get namespace $AIRFLOW_NAMESPACE > /dev/null 2>&1; then
  kubectl create namespace $AIRFLOW_NAMESPACE
  echo "Namespace '$AIRFLOW_NAMESPACE' created."

  sh $LOCAL_PARENTS_PATH/airflow/k8s/install.sh
else
  echo "Namespace '$AIRFLOW_NAMESPACE' already exists."
  if helm list -n hrs | grep $AIRFLOW_RELEASE_NAME; then 
    echo "Helm release '$AIRFLOW_RELEASE_NAME' already installed."
  else 
    echo "Helm release '$AIRFLOW_RELEASE_NAME' not installed. start installing..."
    sh $LOCAL_PARENTS_PATH/airflow/k8s/install.sh
  fi
fi

# monitoring
if ! kubectl get namespace $MONITORING_NAMESPACE > /dev/null 2>&1; then
  kubectl create namespace $MONITORING_NAMESPACE
  echo "Namespace '$MONITORING_NAMESPACE' created."

  sh $LOCAL_PARENTS_PATH/loki/k8s/install.sh
else
  echo "Namespace '$MONITORING_NAMESPACE' already exists."
  if helm list -n $MONITORING_NAMESPACE | grep $LOKI_RELEASE_NAME; then 
    echo "Helm release '$LOKI_RELEASE_NAME' already installed."
  else 
    echo "Helm release '$LOKI_RELEASE_NAME' not installed. start installing..."
    sh $LOCAL_PARENTS_PATH/loki/k8s/install.sh
  fi

  if helm list -n $MONITORING_NAMESPACE | grep $PROMETHUES_RELEASE_NAME; then 
    echo "Helm release '$PROMETHUES_RELEASE_NAME' already installed."
  else 
    echo "Helm release '$PROMETHUES_RELEASE_NAME' not installed. start installing..."
    sh $LOCAL_PARENTS_PATH/promethues/k8s/install.sh
  fi
fi
