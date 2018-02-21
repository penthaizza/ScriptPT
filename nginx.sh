#!/bin/sh
echo "+++++++++++++++++++++++ Check Old Version & Remove +++++++++++++++++++++++++"
sudo nginx -v
sudo yum remove nginx -y

echo "+++++++++++++++++++++++ Add Repo NGINX +++++++++++++++++++++++++++"
echo "[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/centos/7/x86_64/
gpgcheck=0
enabled=1" > /etc/yum.repos.d/nginx.repo

echo "+++++++++++++++++++++++ Update Repository ++++++++++++++++++++++++++"
sudo yum update -y

echo "+++++++++++++++++++++++ Install NGINX +++++++++++++++++++++++++++"
sudo yum install nginx -y

echo "+++++++++++++++++++++++ Start NGINX +++++++++++++++++++++++++"
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx

echo "+++++++++++++++++++++++ Check Version NGINX ++++++++++++++++++++++++++"
sudo nginx -v
sudo curl -I 127.0.0.1

echo "+++++++++++++++++++++++ Disable SELINUX +++++++++++++++++++++++"