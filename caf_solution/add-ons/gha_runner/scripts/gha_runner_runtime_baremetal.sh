#!/usr/bin/env bash

set -euxo pipefail

GH_ORG=${1}
TOKEN=${2}
PREFIX=${3}
ADMIN_USER=${4}
NUM_RUNNERS=${5}

RUNNER_URL="https://github.com/actions/runner/releases/download/v2.292.0/actions-runner-linux-x64-2.292.0.tar.gz"
RUNNER_TOKEN_URL="https://api.github.com/orgs/${GH_ORG}/actions/runners/registration-token"

export DEBIAN_FRONTEND=noninteractive
echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

echo "Installing dependencies"
sleep 10
apt-get update
apt-get install -y --no-install-recommends \
  docker.io \
  jq

echo "Setting up docker"
usermod -aG docker ${ADMIN_USER}
systemctl daemon-reload
systemctl enable docker --now
docker --version

echo "Downloading runner package"
curl -sSL ${RUNNER_URL} -o /home/${ADMIN_USER}/$(basename ${RUNNER_URL})

for i in $(seq 1 ${NUM_RUNNERS}); do
  runner_name=${PREFIX}-${i}
  echo "Install ${runner_name}"

  mkdir /home/${ADMIN_USER}/${runner_name}
  pushd /home/${ADMIN_USER}/${runner_name}
  tar zxf ../$(basename ${RUNNER_URL})
  chown -R ${ADMIN_USER}: .

  echo "Fetching runner registration token from Github"
  RUNNER_TOKEN=$(curl -sS -X POST --url ${RUNNER_TOKEN_URL} -H "Authorization: Bearer ${TOKEN}" \
    -H 'Content-Type: application/json' | jq -r .token)

  sudo -u ${ADMIN_USER} ./config.sh --unattended --url https://github.com/${GH_ORG} \
    --token ${RUNNER_TOKEN} --replace --name ${runner_name}
  ./svc.sh install
  ./svc.sh start

  popd
done
