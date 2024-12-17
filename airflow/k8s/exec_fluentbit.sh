#!/bin/bash
export AIRFLOW_NAMESPACE=hrs
export AIRFLOW_WOKRER_CONTAINE=airflow-worker
export AIRFLOW_POD_NAME=khc-airflow-worker-0

kubectl exec -n $AIRFLOW_NAMESPACE $AIRFLOW_POD_NAME -c $AIRFLOW_WOKRER_CONTAINE -- /bin/bash -c "sudo /opt/fluent-bit/bin/fluent-bit -c /opt/fluent-bit/airflow.conf 2>&1 &"