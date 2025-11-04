# 🐳 Docker - Day38: Retag BusyBox Image

Task : Nautilus project developers are planning to start testing on a new project. As per their meeting with the DevOps team, they want to test containerized environment application features. As per details shared with DevOps team, we need to accomplish the following task: a. Pull busybox:musl image on App Server 1 in Stratos DC and re-tag (create new tag) this image as busybox:local.

This task demonstrates how to **pull an existing Docker image** (`busybox:musl`) from Docker Hub and **create a new local tag** (`busybox:local`) on **Application Server 1**.

---

## ⚙️ Steps to Complete the Task

### 1️⃣ SSH into Application Server 1

```bash
ssh tony@stapp01
```

---

### 2️⃣ Verify Docker Installation

```bash
docker --version
systemctl status docker
```

> Ensure Docker is installed and running properly.

---

### 3️⃣ Pull the BusyBox Image (musl version)

```bash
docker pull busybox:musl
```

> This will download the lightweight BusyBox image with the musl variant.

---

### 4️⃣ Re-tag the Pulled Image as `busybox:local`

```bash
docker tag busybox:musl busybox:local
```

> ✅ This creates a new tag (`local`) for the same image, without duplicating layers.

---

### 5️⃣ Verify the Image Tags

```bash
docker images | grep busybox
```

---

## ✅ Output

| REPOSITORY | TAG   | IMAGE ID | SIZE |
|-------------|-------|-----------|------|
| busybox     | musl  | (same ID) | ~1MB |
| busybox     | local | (same ID) | ~1MB |

> Both tags should point to the same image ID.

---

### 🧠 Key Docker Commands Used

| Command | Description |
|----------|-------------|
| `docker pull` | Download image from Docker Hub |
| `docker tag` | Create a new tag for an existing image |
| `docker images` | List all local images |
