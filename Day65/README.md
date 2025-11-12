# 🧠 Redis Deployment with ConfigMap — Nautilus DevOps Task

Task : The Nautilus application development team observed some performance issues with one of the application that is deployed in Kubernetes cluster. After looking into number of factors, the team has suggested to use some in-memory caching utility for DB service. After number of discussions, they have decided to use Redis. Initially they would like to deploy Redis on kubernetes cluster for testing and later they will move it to production. Please find below more details about the task: Create a redis deployment with following parameters: Create a config map called my-redis-config having maxmemory 2mb in redis-config. Name of the deployment should be redis-deployment, it should use redis:alpine image and container name should be redis-container. Also make sure it has only 1 replica. The container should request for 1 CPU. Mount 2 volumes: a. An Empty directory volume called data at path /redis-master-data. b. A configmap volume called redis-config at path /redis-master. c. The container should expose the port 6379. Finally, redis-deployment should be in an up and running state. Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

This document describes the full setup, configuration, and validation of a **Redis deployment** on a Kubernetes cluster as part of the Nautilus DevOps performance improvement project.

The goal was to use a **ConfigMap** to define a custom Redis configuration (`maxmemory 2mb`) and mount it into the Redis container for runtime usage.

---

## 🧱 Task Summary

| Component | Requirement |
|------------|--------------|
| **ConfigMap Name** | `my-redis-config` |
| **ConfigMap Key** | `redis-config` with value `maxmemory 2mb` |
| **Deployment Name** | `redis-deployment` |
| **Container Name** | `redis-container` |
| **Image** | `redis:alpine` |
| **Replicas** | `1` |
| **CPU Request** | `1` |
| **Port** | `6379` |
| **Volumes** | `data` (emptyDir) → `/redis-master-data`<br>`redis-config` (ConfigMap) → `/redis-master` |

---

## ⚙️ Step 1 — Create ConfigMap (CLI Method)

```bash
kubectl create configmap my-redis-config --from-literal=redis-config="maxmemory 2mb"
```

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-redis-config
data:
  redis-config: |
    maxmemory 2mb

```

Verify the ConfigMap:

```bash
kubectl get configmap my-redis-config -o yaml
```

Expected output snippet:

```yaml
data:
  redis-config: maxmemory 2mb
```

---

## ⚙️ Step 2 — Create Deployment YAML

Below is the final, corrected version of the Redis deployment YAML.

### ✅ redis-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-deployment
  labels:
    app: redis
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
        - name: redis-container
          image: redis:alpine
          ports:
            - containerPort: 6379
          resources:
            requests:
              cpu: "1"
          command: ["redis-server", "/redis-master/redis-config"]
          volumeMounts:
            - name: data
              mountPath: /redis-master-data
            - name: redis-config
              mountPath: /redis-master
      volumes:
        - name: data
          emptyDir: {}
        - name: redis-config
          configMap:
            name: my-redis-config
```

Apply the YAML file:

```bash
kubectl apply -f redis-deployment.yaml
```

---

## 🔍 Step 3 — Verification

Check resources:

```bash
kubectl get deployments
kubectl get pods
```

output:

```
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
redis-deployment   1/1     1            1           30s
```

Inspect details:

```bash
kubectl describe pod -l app=redis
```
---

## 🧪 Step 4 — Validate Redis Configuration

Connect to Redis shell:

```bash
kubectl exec -it $(kubectl get pod -l app=redis -o name) -- redis-cli
```

Run:

```
127.0.0.1:6379> CONFIG GET maxmemory
```

✅ Expected Output:

```
1) "maxmemory"
2) "2097152"
```

That confirms Redis is using the `maxmemory 2mb` configuration from the mounted ConfigMap.

---
---

## ✅ Final Status

| Resource | Status |
|-----------|---------|
| ConfigMap | ✅ Created (maxmemory 2mb) |
| Deployment | ✅ Running (1/1 Ready) |
| Volumes | ✅ Mounted correctly |
| Redis Config | ✅ Applied successfully (`maxmemory 2mb`) |

---