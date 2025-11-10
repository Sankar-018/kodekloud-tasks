Task : Last week, the Nautilus DevOps team deployed a redis app on Kubernetes cluster, which was working fine so far. This morning one of the team members was making some changes in this existing setup, but he made some mistakes and the app went down. We need to fix this as soon as possible. Please take a look.


The deployment name is redis-deployment. The pods are not in running state right now, so please look into the issue and fix the same.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

# 🧮 Redis Deployment Troubleshooting (Kubernetes)

## 🧉 Problem Description

The `redis-deployment` in the Kubernetes cluster was not running.
Pods were stuck in `ContainerCreating` state.

### ❌ Issue Found

```
MountVolume.SetUp failed for volume "config" : configmap "redis-cofig" not found

    Pod stuck in Pending due to missing ConfigMap redis-cofig.
    Redis image typo: redis:alpin → should be redis:alpine.

```

The deployment was referencing a **non-existent ConfigMap** (`redis-cofig` instead of `redis-config`).

---

## ⚙️ Step-by-Step Fix

### 🗞 1️⃣ Check Deployment and Pods

```bash
kubectl get deployments.apps
kubectl get pods
kubectl describe pod <pod-name>
```

### 🗞 2️⃣ Verify ConfigMaps

```bash
kubectl get configmaps
```
 output:

```
NAME               DATA   AGE
redis-config       2      4m50s
```

### 🗞 3️⃣ Edit Deployment to Fix ConfigMap Name

```bash
kubectl edit deployment redis-deployment
```

Find this section:

```yaml
configMap:
  name: redis-cofig
```

Change it to:

```yaml
configMap:
  name: redis-config
```

```yaml
image:
  name: redis:alpin
```

Change it to:
```yaml
image:
  name: redis:alpine

```
Save and exit:

```
:wq
```

---

## ✅ 4️⃣ Verify the Fix

```bash
kubectl get pods -w
kubectl get deployments.apps
```

Expected:

```
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
redis-deployment   1/1     1            1           5m
```

---

## 🧠 Root Cause Summary

| Issue                  | Explanation                                                                |
| ---------------------- | -------------------------------------------------------------------------- |
| Typo in ConfigMap name | Deployment referred to `redis-cofig` instead of `redis-config`.            |
| Result                 | Pod couldn’t mount the ConfigMap volume and stayed in `ContainerCreating`. |
| Fix                    | Corrected the ConfigMap reference in deployment spec.                      |
| image typo             | redis:alpin → should be redis:alpine.                                      |

---

---

## 🟢 Final Result

```bash
kubectl get pods
```

Output:

```
NAME                               READY   STATUS    RESTARTS   AGE
redis-deployment-7c8d4f6ddf-xxxxx  1/1     Running   0          2m
```

✅ **Redis deployment is now running successfully!**
