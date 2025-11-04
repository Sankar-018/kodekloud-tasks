# 🐳 Nautilus DevOps - NGINX Container Setup

Task : The Nautilus DevOps team is planning to host an application on a nginx-based container. There are number of tickets already been created for similar tasks. One of the tickets has been assigned to set up a nginx container on Application Server 2 in Stratos Datacenter. Please perform the task as per details mentioned below: a. Pull nginx:stable docker image on Application Server 2. b. Create a container named demo using the image you pulled. c. Map host port 8082 to container port 80. Please keep the container in running state.

## 📋 Project Overview
This task sets up an **NGINX-based container** on **Application Server 2 (stapp02)** in the Stratos Datacenter.  
The container runs an NGINX web server using the **nginx:stable** image, mapped to port **8082** on the host.

---

## ⚙️ Task Requirements

| Requirement | Value |
|--------------|--------|
| **Base Image** | `nginx:stable` |
| **Container Name** | `demo` |
| **Host Port** | `8082` |
| **Container Port** | `80` |
| **State** | Running |

---

## 🏗️ Steps to Complete

### 1️⃣ SSH into App Server 2
```bash
ssh steve@stapp02
```

---

### 2️⃣ Pull the NGINX Stable Image
```bash
sudo docker pull nginx:stable
```

Expected output:
```
Status: Downloaded newer image for nginx:stable
```

---

### 3️⃣ Run the Container
```bash
sudo docker run -d --name demo -p 8082:80 nginx:stable
```

Explanation:
- `-d` → Run container in detached mode  
- `--name demo` → Name of the container  
- `-p 8082:80` → Maps host port 8082 to container port 80  
- `nginx:stable` → Image name  

---

### 4️⃣ Verify Container Status
```bash
sudo docker ps
```

Expected output:
```
CONTAINER ID   IMAGE          COMMAND                  STATUS         PORTS
xxxxxxxxxxxx   nginx:stable   "/docker-entrypoint.…"   Up ...         0.0.0.0:8082->80/tcp
```

---

### 5️⃣ Test the NGINX Web Server
```bash
curl http://localhost:8082
```

Expected output:
```
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
...
```


## ✅ Verification Summary

| Check | Result |
|--------|---------|
| NGINX image pulled | ✅ |
| Container created | ✅ |
| Port mapping 8082 → 80 | ✅ |
| Container running | ✅ |
| Web server accessible | ✅ |

