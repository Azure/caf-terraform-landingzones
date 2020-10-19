#!/bin/bash

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum -y install azure-cli

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum install -y docker-ce
sudo systemctl daemon-reload
sudo systemctl enable docker
sudo service docker start
sudo docker --version

sudo az login --identity

az acr login --name ${7}
sudo docker pull "${7}/${5}"

for agent_num in $(seq 1 ${6}); do
    name="${4}-${agent_num}"
    sudo docker run -d -v /var/run/docker.sock:/var/run/docker.sock --name ${name} -e AZP_URL=${1} -e AZP_TOKEN=${2} -e AZP_POOL="${3}" -e AZP_AGENT_NAME="${name}" "${7}/${5}"
done