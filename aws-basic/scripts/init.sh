#!/bin/bash

COUNTER=0

while [ ! -b '${DEVICE}' ] && [ $COUNTER -lt 60 ]; do
  echo "Waiting for ${DEVICE} to be available... ($COUNTER/60)"
  sleep 1
  COUNTER=$((COUNTER + 1))
done

if [ ! -b '${DEVICE}' ]; then
  echo 'Error: Device ${DEVICE} did not become available within 60 seconds'
  exit 1
fi

sudo mkdir -p /data
echo '${DEVICE} /data ext4 defaults 0 0' | sudo tee -a /etc/fstab
sudo mount -a