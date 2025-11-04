# 🐳 Docker - Day37: Copy Encrypted File to Container

Task : The Nautilus DevOps team possesses confidential data on App Server 2 in the Stratos Datacenter. A container named ubuntu_latest is running on the same server. Copy an encrypted file /tmp/nautilus.txt.gpg from the docker host to the ubuntu_latest container located at /opt/. Ensure the file is not modified during this operation.

This task demonstrates how to **copy an encrypted file** from the Docker host to a **running container** without modifying it.  
We’ll transfer `/tmp/nautilus.txt.gpg` into the `/opt/` directory inside the running **ubuntu_latest** container on **App Server 2**.

---

## ⚙️ Steps to Complete the Task

### 1️⃣ SSH into Application Server 2

```bash
ssh steve@stapp02
```

---

### 2️⃣ Verify Docker and Container Status

```bash
docker ps
```

> Ensure that the container **ubuntu_latest** is running.

---

### 3️⃣ Copy the Encrypted File to the Container

```bash
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/opt/
```

> ✅ This command securely copies the file without altering its content.

---

### 4️⃣ Verify File Transfer Inside the Container

```bash
docker exec -it ubuntu_latest ls -l /opt/
```

