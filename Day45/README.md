# 🐳 Nautilus DevOps - Fixed HTTPD Dockerfile (App Server 2)

Task : The Nautilus DevOps team is working to create new images per requirements shared by the development team. One of the team members is working to create a Dockerfile on App Server 2 in Stratos DC. While working on it she ran into issues in which the docker build is failing and displaying errors. Look into the issue and fix it to build an image as per details mentioned below:

a. The Dockerfile is placed on App Server 2 under /opt/docker directory.

b. Fix the issues with this file and make sure it is able to build the image.

c. Do not change base image, any other valid configuration within Dockerfile, or any of the data been used — for example, index.html.

Note: Please note that once you click on FINISH button all the existing containers will be destroyed and new image will be built from your Dockerfile.

## 📋 Project Overview
This task involved fixing a **broken Dockerfile** on **App Server 2 (stapp02)** under `/opt/docker/`.  
The fixed Dockerfile successfully builds a custom **Apache HTTPD (2.4.43)** image configured to:
- Listen on port **8080** instead of 80  
- Enable SSL modules (`mod_ssl`, `mod_socache_shmcb`)  
- Use provided SSL certificates  
- Serve static HTML content (`index.html`) from `/usr/local/apache2/htdocs/`

---

## ⚙️ Task Requirements

| Parameter | Configuration |
|------------|----------------|
| **Base Image** | `httpd:2.4.43` |
| **Port Change** | `Listen 80 → Listen 8080` |
| **SSL Modules** | Enabled |
| **Certificates** | `/opt/docker/certs/server.crt`, `/opt/docker/certs/server.key` |
| **Static Content** | `/opt/docker/html/index.html` |
| **Exposed Port** | 8080 |
| **Command** | `httpd-foreground` |

---

## 🧱 Fixed Dockerfile

```Dockerfile
FROM httpd:2.4.43

# Update default port and enable SSL modules
RUN sed -i 's/Listen 80/Listen 8080/g' /usr/local/apache2/conf/httpd.conf &&     sed -i '/LoadModule ssl_module modules\/mod_ssl.so/s/^#//g' /usr/local/apache2/conf/httpd.conf &&     sed -i '/LoadModule socache_shmcb_module modules\/mod_socache_shmcb.so/s/^#//g' /usr/local/apache2/conf/httpd.conf &&     sed -i '/Include conf\/extra\/httpd-ssl.conf/s/^#//g' /usr/local/apache2/conf/httpd.conf

# Copy SSL certificates
COPY certs/server.crt /usr/local/apache2/conf/server.crt
COPY certs/server.key /usr/local/apache2/conf/server.key

# Copy HTML website files
COPY html/index.html /usr/local/apache2/htdocs/

# Expose custom port
EXPOSE 8080

# Start Apache in foreground
CMD ["httpd-foreground"]
```

---

## 🧰 Build Instructions

### 1️⃣ Navigate to the directory
```bash
cd /opt/docker
```

### 2️⃣ Build the Docker image
```bash
sudo docker build -t custom-httpd:fixed /opt/docker
```

Expected output:
```
Successfully built <image_id>
Successfully tagged custom-httpd:fixed
```

---

## 🚀 Run and Test the Container

### 1️⃣ Start the container
```bash
sudo docker run -d -p 8080:8080 custom-httpd:fixed
```

### 2️⃣ Verify using curl
```bash
curl http://localhost:8080
```
Expected output:
```
This Dockerfile works!
```

---

## ✅ Verification Summary

| Check | Status |
|--------|---------|
| Dockerfile syntax fixed | ✅ |
| Port changed to 8080 | ✅ |
| SSL modules enabled | ✅ |
| Certificates copied | ✅ |
| index.html served successfully | ✅ |
| Image built successfully | ✅ |
| Container runs and serves content | ✅ |

---
