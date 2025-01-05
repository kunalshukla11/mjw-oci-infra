#!/bin/bash

echo "Executing compute-app script"

git clone https://github.com/kunalshukla11/mjw-service.git /home/ubuntu/mjw-service
cp /home/ubuntu/.env /home/ubuntu/mjw-service/.env
# Open port for app and mjw-service
sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --zone=public --permanent --add-port=3000/tcp
sudo firewall-cmd --reload
echo "Finished executing compute-app script"
