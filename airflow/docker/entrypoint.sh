#!/bin/bash

echo "실행함"

# celery worker 실행
airflow celery worker

## fluent-bit service restart
/opt/fluent-bit/bin/fluent-bit -c /opt/fluent-bit/airflow.conf >> /opt/fluent-bit/tmp.log 2>&1 &