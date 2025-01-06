#!/bin/bash

echo "Mounting the disk for PostgreSQL data"
mkdir -p /mnt/postgres-data
mount /dev/oracleoci/oraclevdb /mnt/postgres-data
# Check if the volume is already initialized ie: volume and the attachment already existing as /dev/oracleoci/oraclevdb holds the
# data by previous postgres instance we do not need to format the disk, just mount it
if [ ! -f /mnt/postgres-data/PG_VERSION ]; then
  echo "Formatting and initializing the disk initial setup"
  mkfs.ext4 /dev/oracleoci/oraclevdb
  mount /dev/oracleoci/oraclevdb /mnt/postgres-data
  rm -rf /mnt/postgres-data/* # Clear any existing files
  sudo chown -R 1001:1001 /mnt/postgres-data
  echo "/dev/oracleoci/oraclevdb /mnt/postgres-data ext4 defaults 0 0" >>/etc/fstab
else
  echo "Disk already initialized, skipping formatting"
fi

git clone https://github.com/kunalshukla11/mjw-service.git /home/ubuntu/mjw-service
sudo chown -R ubuntu:ubuntu /home/ubuntu/mjw-service
cp /home/ubuntu/.env /home/ubuntu/mjw-service/.env
# Open port for postgres
sudo firewall-cmd --zone=public --permanent --add-port=5432/tcp
sudo firewall-cmd --reload
echo "Finished creating and mounting the disk for PostgreSQL data"
