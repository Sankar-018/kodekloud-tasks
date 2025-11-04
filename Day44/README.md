# 🐳 Nautilus DevOps - HTTPD Static Website Hosting (Docker Compose)

Task : The Nautilus application development team shared static website content that needs to be hosted on the httpd web server using a containerised platform. The team has shared details with the DevOps team, and we need to set up an environment according to those guidelines. Below are the details:

 a. On App Server 3 in Stratos DC create a container named httpd using a docker compose file /opt/docker/docker-compose.yml (please use the exact name for file).
 
 b. Use httpd (preferably latest tag) image for container and make sure container is named as httpd; you can use any name for service. 
 
 c. Map 80 number port of container with port 3003 of docker host. 
 
 d. Map container's /usr/local/apache2/htdocs volume with /opt/finance volume of docker host which is already there. (please do not modify any data within these locations).

## 📋 Project Overview
This task sets up an **Apache HTTPD** web server using **Docker Compose** on **App Server 3 (stapp03)** in the Stratos Datacenter.  
The container hosts static website content shared by the Nautilus Application Development Team.

---

## ⚙️ Task Requirements

| Requirement | Value |
|--------------|--------|
| **Docker Compose File Path** | `/opt/docker/docker-compose.yml` |
| **Image** | `httpd:latest` |
| **Service Name** | `webserver` (any name is fine) |
| **Container Name** | `httpd` |
| **Host Port** | `3003` |
| **Container Port** | `80` |
| **Host Volume** | `/opt/finance` |
| **Container Volume** | `/usr/local/apache2/htdocs` |

---

## 🏗️ Steps to Complete

### 1️⃣ SSH into App Server 3
```bash
ssh banner@stapp03
```

---

### 2️⃣ Create Directory for Docker Compose File
```bash
sudo mkdir -p /opt/docker
cd /opt/docker
```

---

### 3️⃣ Create the Docker Compose File
```bash
sudo vi /opt/docker/docker-compose.yml
```


```yaml
version: '3.8'

services:
  webserver:
    image: httpd:latest
    container_name: httpd
    ports: 
      - "3003:80"
    volumes:
      - /opt/finance:/usr/local/apache2/htdocs
```

Save and exit (`:wq`).

---

### 4️⃣ Deploy the Container
```bash
cd /opt/docker
sudo docker compose up -d
```

Expected output:
```
[+] Running 1/1
 ⠿ Container httpd  Started
```

---

### 5️⃣ Verify the Container
```bash
sudo docker ps
```

Expected output:
```
CONTAINER ID   IMAGE          COMMAND              STATUS         PORTS
xxxxxxxxxxxx   httpd:latest   "httpd-foreground"   Up ...         0.0.0.0:3003->80/tcp
```

---

### 6️⃣ Test the Web Server
```bash
curl http://localhost:3003
```

You should see the static HTML content from `/opt/finance` displayed in the output.

---

### 7️⃣ (Optional) Stop and Remove the Container
```bash
sudo docker compose down
```

---

## ✅ Verification Summary

| Check | Result |
|--------|---------|
| Docker Compose file created | ✅ |
| HTTPD image used | ✅ httpd:latest |
| Container named `httpd` | ✅ |
| Port mapping `3003 → 80` | ✅ |
| Volume mapped correctly | ✅ |
| Static site served successfully | ✅ |

---

