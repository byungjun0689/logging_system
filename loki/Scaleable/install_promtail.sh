#!/bin/bash

NAMESPACE=monitoring
# tenant_id 값을 넣지 않으면 데이터가 들어가지 않음

helm upgrade --install promtail grafana/promtail \
--kubeconfig=$KUBE_DEV_PIPELINE_CONFIG \
--set "config.clients[0].url=http://loki-gateway.monitoring.svc.cluster.local/loki/api/v1/push" \
--set "config.clients[0].tenant_id=default" \
--set "config.snippets.pipelineStages[1].cri={}" \
--set "config.snippets.pipelineStages[0].multiline.firstline=^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{9}Z" \
--set "config.snippets.pipelineStages[0].multiline.max_wait_time=10s" \
--set "config.snippets.pipelineStages[0].multiline.max_lines=500" \
-n $NAMESPACE


# helm install promtail grafana/promtail \
# --kubeconfig=$KUBE_DEV_PIPELINE_CONFIG \
# --values promtail_values.yaml \
# -n $NAMESPACE