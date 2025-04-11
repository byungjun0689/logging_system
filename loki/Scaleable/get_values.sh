#!/bin/bash

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm show values grafana/loki >> override-values.yaml