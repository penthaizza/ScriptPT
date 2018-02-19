#!/bin/sh
echo "Yum Update"
sudo yum update -y

echo "Uninstall old version docker"
sudo yum remove docker \
	            docker-common \
	            docker-selinux \
	            docekr-engine -y

echo "Set up the repository"
sudo yum install -y yum-utils \
device-mapper-persistent-data \
lvm2
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

echo "Install docker"
sudo yum install docker-ce -y
sudo yum list docker-ce --showduplicate | sort -r
sudo systemctl start docker
sudo systemctl enable docker

echo "Check Version Docker"
sudo docker -v

echo "Stop & Delete old helloword container"
sudo docker stop $(docker ps -a -q)
sudo docker rm $(docker ps -a -q)

echo "run docker helloworld"
sudo docker run hello-world