#!/bin/bash

NAMESPACE=monitoring
# tenant_id 값을 넣지 않으면 데이터가 들어가지 않음

helm install promtail grafana/promtail \
--kubeconfig=$KUBE_DEV_PIPELINE_CONFIG \
--set "config.clients[0].url=http://loki-gateway/loki/api/v1/push" \
--set "config.clients[0].tenant_id=default" \
-n NAMESPACE