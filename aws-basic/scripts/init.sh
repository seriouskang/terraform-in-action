#!/bin/bash

sudo mkdir /data
echo '${DEVICE} /data ext4 defaults 0 0' | sudo tee -a /etc/fstab
sudo mount -a