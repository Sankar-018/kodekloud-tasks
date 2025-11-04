# 🐳 Nautilus DevOps - Docker Network Setup

Task : The Nautilus DevOps team needs to set up several docker environments for different applications. One of the team members has been assigned a ticket where he has been asked to create some docker networks to be used later. Complete the task based on the following ticket description: a. Create a docker network named as official on App Server 2 in Stratos DC. b. Configure it to use bridge drivers. c. Set it to use subnet 192.168.30.0/24 and iprange 192.168.30.0/24.

## 📋 Project Overview
As per the Nautilus Application Development team's requirements, this task involves creating a **custom Docker network** on **App Server 2** in Stratos Datacenter.  
The network will be used for different application environments.

---

## ⚙️ Task Requirements

| Requirement | Value |
|--------------|--------|
| **Network Name** | `official` |
| **Driver** | `bridge` |
| **Subnet** | `192.168.30.0/24` |
| **IP Range** | `192.168.30.0/24` |

---

## 🏗️ Steps to Complete

### 1️⃣ SSH into App Server 2
```bash
ssh steve@stapp02
```

### 2️⃣ Verify Docker is Installed and Running
```bash
sudo systemctl status docker
sudo systemctl start docker   # if not running
```

### 3️⃣ Create Docker Network
```bash
sudo docker network create   --driver bridge   --subnet 192.168.30.0/24   --ip-range 192.168.30.0/24   official
```

### 4️⃣ Verify the Network Creation
```bash
sudo docker network ls
```

Expected output:
```
NETWORK ID     NAME       DRIVER    SCOPE
xxxxxx         official   bridge    local
```

### 5️⃣ Inspect Network Details
```bash
sudo docker network inspect official
```

Ensure the output includes:
```
"Driver": "bridge"
"Subnet": "192.168.30.0/24"
"IPRange": "192.168.30.0/24"
```

---

## 🧪 Test the Network

### Run a Test Container
```bash
sudo docker run -dit --name test1 --network official ubuntu:24.04 bash
```

### Verify Container IP
```bash
sudo docker inspect test1 | grep IPAddress
```
