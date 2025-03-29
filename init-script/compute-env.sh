#!/bin/bash
echo "Creating common env  file"
cat <<EOT >/home/ubuntu/.env
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
POSTGRES_USER=${POSTGRES_USER}
NODE_ENV=production
MJW_SERVICE_URL=${MJW_SERVICE_URL}
MJW_DB_HOST=${MJW_DB_HOST}
EOT
