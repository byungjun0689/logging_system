#!/bin/bash

helm repo add airflow-helm https://airflow-helm.github.io/charts
helm repo update

helm show values airflow-helm/airflow > default_values.yaml

