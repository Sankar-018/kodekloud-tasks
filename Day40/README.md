
# 🐳 Docker - Day 40

One of the Nautilus DevOps team members was working to configure services on a kkloud container that is running on App Server 1 in Stratos Datacenter. Due to some personal work he is on PTO for the rest of the week, but we need to finish his pending work ASAP. Please complete the remaining work as per details given below: a. Install apache2 in kkloud container using apt that is running on App Server 1 in Stratos Datacenter. b. Configure Apache to listen on port 8087 instead of default http port. Do not bind it to listen on specific IP or hostname only, i.e it should listen on localhost, 127.0.0.1, container ip, etc. c. Make sure Apache service is up and running inside the container. Keep the container in running state at the end.

## 🧩 Task: Configure Apache in kkloud Container

The Nautilus DevOps team needs to complete pending configuration work inside the **kkloud** container running on **Application Server 1** in the **Stratos Datacenter**.

This involves installing Apache, configuring it to listen on **port 8087**, and ensuring it remains running inside the container.

---

## ⚙️ Steps to Complete the Task

### 1️⃣ Access the Application Server and Container

```bash
ssh tony@stapp01
docker exec -it kkloud bash
```

---

### 2️⃣ Update and Install Apache2

```bash
apt-get update -y
apt-get install apache2 -y
```

---

### 3️⃣ Change Apache to Listen on Port 8087

```bash
sed -i 's/80/8087/g' /etc/apache2/ports.conf
sed -i 's/:80/:8087/g' /etc/apache2/sites-available/000-default.conf
```

---

### 4️⃣ Start and Verify Apache Service

```bash
service apache2 start
apt-get install net-tools -y
netstat -tulnp | grep 8087
# or check with curl
curl http://localhost:8087
```

---

### 5️⃣ Exit Container and Verify it’s Still Running

```bash
exit
sudo docker ps | grep kkloud
```

---
