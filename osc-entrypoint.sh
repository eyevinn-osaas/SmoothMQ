#!/bin/sh

# Render config file from env variables

echo "Render config from env variables"

cat >/config.yaml <<EOF
---
server:
  sqs:
    enabled: true
    port: ${SQS_PORT:-3001}
    keys:
      - accesskey: ${ACCESS_KEY_ID:-smoothmq}
        secretkey: ${SECRET_ACCESS_KEY:-smoothmq}
  
  dashboard:
    enabled: true
    port: ${DASHBOARD_PORT:-3000}
  
  prometheus:
    enabled: true
    port: ${PROMETHEUS_PORT:-2112}

  sqlite:
    path: smoothmq.sqlite
EOF

echo "Configuring nginx port"
sed -i "s/PORT_PLACEHOLDER/${PORT:-80}/g" /etc/nginx/nginx.conf

echo "Starting nginx"
nginx

echo "Starting server"
cd /data && /usr/local/bin/run-app server --config=/config.yaml
