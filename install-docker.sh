#!/usr/bin/env bash 
# maintainer: Bilal Kalem
# maintainer: bkalem@ios.dz

## Script to install docker-ce on Red Hat Entrerpise Linux (Rocky Linux)
## Run using `sudo ./install-docker.sh`

# Ensuring "GROUP" variable has not been set elsewhere
unset GROUP

echo "Removing podman and installing Requirement"
dnf remove -y podman buildah
dnf install -y curl wget git 

echo "installing Docker CE"
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf -y install docker-ce docker-ce-cli containerd.io curl wget git

echo "Setting up docker service"
systemctl enable docker
systemctl start docker

echo "installing Docker Compose"
DOCKER_COMPOSE_VERSION="v2.23.3"
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "Install Docker completed"
docker version

echo "Install Docker Compose completed"
docker-compose version


echo "Adding permissions to current user for docker, attempting to reload group membership"
usermod -aG docker -a $USER
GROUP=$(id -g)
newgrp docker
newgrp $GROUP
unset GROUP
