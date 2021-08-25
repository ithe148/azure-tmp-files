#!/bin/bash

yum install -y epel-release && echo "install epel" >> /var/log/azure/install.log
yum update -y && echo "update all" >> /var/log/azure/install.log
yum install -y nginx && echo "install nginx" >> /var/log/azure/install.log
systemctl daemon-reload && echo "daemon-reload" >> /var/log/azure/install.log
systemctl enable --now nginx && echo "enable and run nginx" >> /var/log/azure/install.log


exit 0 




