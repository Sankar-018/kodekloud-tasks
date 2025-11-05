# 🐍 Dockerized Python Application Deployment
 Task : A python app needed to be Dockerized, and then it needs to be deployed on App Server 3. We have already copied a requirements.txt file (having the app dependencies) under /python_app/src/ directory on App Server 3. Further complete this task as per details mentioned below: Create a Dockerfile under /python_app directory: Use any python image as the base image. Install the dependencies using requirements.txt file. Expose the port 3003. Run the server.py script using CMD. Build an image named nautilus/python-app using this Dockerfile. Once image is built, create a container named pythonapp_nautilus: Map port 3003 of the container to the host port 8098. Once deployed, you can test the app using curl command on App Server 
 
 3. curl http://localhost:8098/


## 🧩 Project Overview
This project involves Dockerizing a Python web application and deploying it on **App Server 3**.  
The application is part of the **xFusionCorp Industries** internal deployment tests.

The project includes:
- A simple Python web app (`server.py`)
- Dependencies listed in `requirements.txt`
- A Dockerfile that builds and runs the app container

---

## 📁 Directory Structure
```
/python_app/
├── Dockerfile
└── src/
    ├── requirements.txt
    └── server.py
```

---

## ⚙️ Deployment Steps

1. **Navigate to the project directory:**
   ```bash
   cd /python_app
   ```

2. **Build the Docker image:**
   ```bash
   sudo docker build -t nautilus/python-app .
   ```

3. **Run the container:**
   ```bash
   sudo docker run -d --name pythonapp_nautilus -p 8098:3003 nautilus/python-app
   ```

4. **Verify the running container:**
   ```bash
   sudo docker ps
   ```

    output:
   ```
   CONTAINER ID   IMAGE                 PORTS                    NAMES
   c18c93cae53c   nautilus/python-app   0.0.0.0:8098->3003/tcp   pythonapp_nautilus
   ```

5. **Test the application:**
   ```bash
   curl http://localhost:8098/
   ```
   output:
   ```
   Welcome to xFusionCorp Industries!
   ```

---

