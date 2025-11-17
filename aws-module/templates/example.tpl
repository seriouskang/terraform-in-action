#!/bin/bash

yum update
yum install -y nginx

touch /tmp/${region}