#!/bin/sh
echo "Yum Update"
sudo yum update -y

echo "Stop old MongoDB"
sudo service mongod stop

echo "Remove Packages"
sudo yum erase $(rpm -qa | grep mongodb-org)

echo "Remove Data Directories"
sudo rm -r /var/log/mongod
sudo rm -r /var/lib/mongo

echo "Remove old MongoDB Repo"
sudo rm -rf /etc/yum.repos.d/mongodb-org-3.4.repo

echo "Add MongoDB Repo"
echo "[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.6/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc" > /etc/yum.repos.d/mongodb-org-3.6.repo

echo "Install MongoDB Package and associated tools"
sudo yum install -y mongodb-org

echo "Configure SELinux"
setenforce 0

echo "Start MongoDB"
sudo systemctl start mongod
sudo systemctl enable mongod

echo "Verify MongoDB"
mongod --version
