# 🐳 Nautilus DevOps - Custom Apache Docker Image

Task : As per recent requirements shared by the Nautilus application development team, they need custom images created for one of their projects. Several of the initial testing requirements are already been shared with DevOps team. Therefore, create a docker file /opt/docker/Dockerfile (please keep D capital of Dockerfile) on App server 1 in Stratos DC and configure to build an image with the following requirements: a. Use ubuntu:24.04 as the base image. b. Install apache2 and configure it to work on 8085 port. (do not update any other Apache configuration settings like document root etc).

## 📋 Project Overview
As per the Nautilus Application Development team's recent requirement, this project creates a **custom Docker image** based on **Ubuntu 24.04**.  
It installs **Apache2** and configures it to run on **port 8085** instead of the default port 80.  

The image is used for internal testing and web service hosting on a non-default port.

---

## ⚙️ Dockerfile Location
```
/opt/docker/Dockerfile
```

---

## 🏗️ Build Instructions

### 1️⃣ Navigate to the directory
```bash
cd /opt/docker
```

### 2️⃣ Build the Docker image
```bash
docker build -t custom-apache:latest .
```

---

## 🚀 Run the Container

### 1️⃣ Start a new container
```bash
docker run -d -p 8085:8085 custom-apache
```

### 2️⃣ Verify that Apache is running
```bash
curl http://localhost:8085
```

---

## 🧩 Dockerfile Configuration Details

| Step | Description |
|------|--------------|
| **Base Image** | `ubuntu:24.04` |
| **Package Installed** | `apache2` |
| **Port Configuration** | Apache modified to listen on port **8085** |
| **Exposed Port** | `8085` |
| **Startup Command** | `apache2ctl -D FOREGROUND` |

---

---

## ✅ Verification
After running the container:
```bash
curl http://localhost:8085
```
