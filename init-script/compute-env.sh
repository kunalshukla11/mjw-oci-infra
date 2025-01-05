#!/bin/bash
echo "Creating common env file"
cat <<EOT >/home/ubuntu/.env
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
POSTGRES_USER=${POSTGRES_USER}
EOT
