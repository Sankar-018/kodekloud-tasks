# 🚀 Docker Compose Setup for PHP-Apache and MariaDB Stack

Task : The Nautilus Application development team recently finished development of one of the apps that they want to deploy on a containerized platform. The Nautilus Application development and DevOps teams met to discuss some of the basic pre-requisites and requirements to complete the deployment. The team wants to test the deployment on one of the app servers before going live and set up a complete containerized stack using a docker compose fie. Below are the details of the task: On App Server 1 in Stratos Datacenter create a docker compose file /opt/itadmin/docker-compose.yml (should be named exactly). The compose should deploy two services (web and DB), and each service should deploy a container as per details below: For web service: a. Container name must be php_host. b. Use image php with any apache tag. Check here for more details. c. Map php_host container's port 80 with host port 8082 d. Map php_host container's /var/www/html volume with host volume /var/www/html. For DB service: a. Container name must be mysql_host. b. Use image mariadb with any tag (preferably latest). Check here for more details. c. Map mysql_host container's port 3306 with host port 3306 d. Map mysql_host container's /var/lib/mysql volume with host volume /var/lib/mysql. e. Set MYSQL_DATABASE=database_host and use any custom user ( except root ) with some complex password for DB connections. After running docker-compose up you can access the app with curl command curl <server-ip or hostname>:8082/ For more details check here. Note: Once you click on FINISH button, all currently running/stopped containers will be destroyed and stack will be deployed again using your compose file.

## 🧩 Project Overview
This project deploys a simple **two-tier application stack** using Docker Compose.  
The setup includes:
- A **PHP-Apache web server** container (`php_host`)
- A **MariaDB database** container (`mysql_host`)

The application is part of the **xFusionCorp Industries** internal deployment testing.

---

## 📁 File Location
Docker Compose file path:
```
/opt/itadmin/docker-compose.yml
```

---

## ⚙️ Steps to Deploy

1. **Navigate to directory:**
   ```bash
   cd /opt/itadmin
   ```

2. **Ensure host volumes exist:**
   ```bash
   sudo mkdir -p /var/www/html /var/lib/mysql
   ```

3. **Deploy containers using Docker Compose:**
   ```bash
   sudo docker compose up -d
   ```

4. **Verify containers are running:**
   ```bash
   sudo docker ps
   ```

    output:
   ```
   CONTAINER ID   IMAGE            COMMAND                  PORTS
   5265cc709b6e   php:apache       "docker-php-entrypoi…"   0.0.0.0:8082->80/tcp
   d9fc58328bbb   mariadb:latest   "docker-entrypoint.s…"   0.0.0.0:3306->3306/tcp
   ```

5. **Test the application:**
   ```bash
   curl http://localhost:8082/
   ```
   Expected output:
   ```html
   <html>
       <head>
           <title>Welcome to xFusionCorp Industries!</title>
       </head>
       <body>
           Welcome to xFusionCorp Industries!
       </body>
   </html>
   ```

---
