#!/bin/bash

export AIRFLOW_NAMESPACE="hrs"

kubectl exec -i -t -n $AIRFLOW_NAMESPACE khc-airflow-worker-0 -c airflow-worker -- sh -c "clear; (bash || ash || sh)" 