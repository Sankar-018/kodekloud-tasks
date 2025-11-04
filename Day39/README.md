# 🐳 Docker - Day39: Create Image from a Running Container

Task : One of the Nautilus developer was working to test new changes on a container. He wants to keep a backup of his changes to the container. A new request has been raised for the DevOps team to create a new image from this container. Below are more details about it: a. Create an image blog:devops on Application Server 1 from a container ubuntu_latest that is running on same server.


This task demonstrates how to **create a new Docker image** (`blog:devops`) from an existing **running container** (`ubuntu_latest`) on **Application Server 1**.

---

## ⚙️ Steps to Complete the Task

### 1️⃣ SSH into Application Server 1

```bash
ssh tony@stapp01
```

---

### 2️⃣ Verify Running Containers

```bash
docker ps
```

> Ensure that the container **ubuntu_latest** is running.

---

### 3️⃣ Commit the Container to Create a New Image

```bash
docker commit ubuntu_latest blog:devops
```

> ✅ This command creates a new image named **blog** with the tag **devops**, based on the current state of the running container.

---

### 4️⃣ Verify the Newly Created Image

```bash
docker images
```


---


## ✅  Output

| REPOSITORY | TAG     | IMAGE ID | CREATED | SIZE |
|-------------|---------|-----------|----------|------|
| blog        | devops  | (new ID)  | seconds ago | ~size of container |

> The new image **blog:devops** is successfully created from the container **ubuntu_latest**.

---
