# Kubernetes Secret Pod — Nautilus DevOps Task

Task : The Nautilus DevOps team is working to deploy some tools in Kubernetes cluster. Some of the tools are licence based so that licence information needs to be stored securely within Kubernetes cluster. Therefore, the team wants to utilize Kubernetes secrets to store those secrets. Below you can find more details about the requirements:


    We already have a secret key file media.txt under /opt location on jump host. Create a generic secret named media, it should contain the password/license-number present in media.txt file.

    Also create a pod named secret-datacenter.

    Configure pod's spec as container name should be secret-container-datacenter, image should be debian with latest tag (remember to mention the tag with image). Use sleep command for container so that it remains in running state. Consume the created secret and mount it under /opt/apps within the container.

    To verify you can exec into the container secret-container-datacenter, to check the secret key under the mounted path /opt/apps. Before hitting the Check button please make sure pod/pods are in running state, also validation can take some time to complete so keep patience.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

## 🧩 Task Objective

The Nautilus DevOps team wanted to securely store application license information inside a Kubernetes cluster using **Secrets**.
The task involved creating a **Secret** and a **Pod** that consumes it via a mounted volume.

---

## ⚙️ Task Requirements

1. Create a **Secret** named `media` from `/opt/media.txt` on the jump host.
2. Create a **Pod** named `secret-datacenter` with:

   * **Container name:** `secret-container-datacenter`
   * **Image:** `debian:latest`
   * **Command:** `sleep infinity`
   * Mount the secret inside the container at `/opt/apps`.
3. Verify the secret inside the container.

---

### 1️⃣ Verify the Secret File

```bash
cd /opt
cat media.txt
# Output:
# *x*x*x
```

### 2️⃣ Create the Secret

```bash
kubectl create secret generic media --from-file=/opt/media.txt
```

Verify:

```bash
kubectl get secrets
kubectl describe secret media
```

Expected:

```
Name:         media
Type:         Opaque
Data
====
media.txt:    7 bytes
```

---

### 3️⃣ Create the Pod Definition

```bash
vi secret-datacenter.yaml
```

**secret-datacenter.yaml**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-datacenter
spec:
  containers:
  - name: secret-container-datacenter
    image: debian:latest
    command: ["/bin/bash", "-c", "sleep infinity"]
    volumeMounts:
    - name: secret-volume
      mountPath: "/opt/apps"
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: media
```

---

### 4️⃣ Deploy the Pod

```bash
kubectl apply -f secret-datacenter.yaml
kubectl get pods -w
```

✅ Output:

```
NAME                READY   STATUS    RESTARTS   AGE
secret-datacenter   1/1     Running   0          20s
```

---

### 5️⃣ Verify Inside the Pod

```bash
kubectl exec -it secret-datacenter -- bash
```

Inside the pod:

```bash
ls /opt/apps
cat /opt/apps/media.txt
```

✅ Output:

```
media.txt
"*x*x*x"
```

---

## 🌟 Result

* Secret `media` was created successfully.
* Pod `secret-datacenter` mounted it at `/opt/apps`.
* The secret data was readable inside the container.

This completes the **Kubernetes Secret Management** task successfully 🚀

---