#!/bin/sh

# Render config file from env variables

echo "Render config from env variables"

cat >./config.yaml <<EOF
---
server:
  sqs:
    enabled: true
    port: ${PORT:-8080}
    keys:
      - access_key: ${ACCESS_KEY_ID:-smoothmq}
        secret_key: ${SECRET_ACCESS_KEY:-smoothmq}
EOF

echo "Starting server"
/usr/local/bin/run-app server --config=./config.yaml
