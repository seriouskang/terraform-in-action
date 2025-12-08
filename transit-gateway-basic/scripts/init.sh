#!/bin/bash

yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>${VPC} - Web Server</h1><p>Private IP: $(hostname -I)</p>" | tee /var/www/html/index.html