# 🚀 Docker - Day 36: Nginx Container Deployment (Alpine Version)

This project demonstrates the deployment of an **Nginx container** using the lightweight **Alpine** image on **Application Server 1**. 
The container is configured to run in detached mode and remain active after deployment.

---

## 🧰 Task Description

The Nautilus DevOps team is conducting application deployment tests on selected application servers. 
They require an **Nginx container** deployment on **Application Server 1** with the following requirements:

- Container name → `nginx_1` 
- Image → `nginx:alpine` 
- Container should be in **running** state 

---

## ⚙️ Step-by-Step Deployment Guide

### 🪜 Step 1: SSH into Application Server 1
```bash
ssh tony@stapp01
```

---

### 🪜 Step 2: Verify Docker installation
```bash
docker --version
systemctl status docker
```

If Docker is not running, start it:
```bash
sudo systemctl start docker
```

---

### 🪜 Step 3: Pull the Nginx (Alpine) image
```bash
docker pull nginx:alpine
```

---

### 🪜 Step 4: Create and run the container
```bash
docker run -d --name nginx_1 nginx:alpine
```

**Explanation:**
- `-d` → Run container in detached (background) mode 
- `--name nginx_1` → Assigns container name 
- `nginx:alpine` → Lightweight Nginx image based on Alpine Linux 

---

### 🪜 Step 5: Verify container status
```bash
docker ps
```


