#!/bin/bash

NAMESPACE=monitoring

# DEV_NFS_IP 환경변수 설정필요
# DEV_NFS_FOLDER 환경변수 설정필요

helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=$DEV_NFS_IP \
    --set nfs.path=$DEV_NFS_FOLDER \
    --set storageClass.reclaimPolicy=Retain \
    --kubeconfig=$KUBE_DEV_PIPELINE_CONFIG \
    -n $NAMESPACE
