#!/bin/bash

MONITORING_NAMESPACE=monitoring

admin_password=$(kubectl get secret loki-stack-grafana -n $MONITORING_NAMESPACE -o jsonpath="{.data.admin-password}" | base64 --decode)

echo "Admin ID: admin"
echo "Admin Password: $admin_password"