Task -  Day 35

The Nautilus DevOps team aims to containerize various applications following a recent meeting with the application development team. They intend to conduct testing with the following steps:

    Install docker-ce and docker compose packages on App Server 2.

    Initiate the docker service.

🐳 Docker Installation and Setup on App Server 2
Objective

The Nautilus DevOps team aims to containerize applications. As part of the setup, Docker CE and Docker Compose were installed and configured on App Server 2.

Steps Performed
1. Install Required Dependencies

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

2. Add the Docker Repository

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

3. Install Docker CE and Docker Compose

sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

4. Start and Enable Docker Service

sudo systemctl start docker
sudo systemctl enable docker

5. Verify Installation

docker --version
docker-compose version
sudo systemctl status docker

6. Test Docker

sudo docker run hello-world

Result

✅ Docker CE and Docker Compose successfully installed
✅ Docker service is active and enabled at startup
