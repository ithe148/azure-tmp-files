#!/bin/bash

echo "--------------------------------" >>  /var/log/azure/install.log
echo "START INSTALL NGINX"
echo "START INSTALL NGINX" >> /var/log/azure/install.log
echo "install epel" >> /var/log/azure/install.log
yum install -y epel-release
echo "epel was installed " >> /var/log/azure/install.log
echo "update all" >> /var/log/azure/install.log
yum update -y
echo "system was updated" >> /var/log/azure/install.log
echo "install nginx" >> /var/log/azure/install.log
yum install -y nginx
echo "nginx was installed" >> /var/log/azure/install.log
echo "daemon-reload" >> /var/log/azure/install.log
systemctl daemon-reload
echo "daemon-reloaded" >> /var/log/azure/install.log
echo "enable and run nginx" >> /var/log/azure/install.log
systemctl enable --now nginx
echo "Nginx was runned" >> /var/log/azure/install.log

echo "END" >> /var/log/azure/install.log

echo "nginx was installed"






