# ⚙️ Kubernetes Init Container Deployment — ic-deploy-datacenter

Task : There are some applications that need to be deployed on Kubernetes cluster and these apps have some pre-requisites where some configurations need to be changed before deploying the app container. Some of these changes cannot be made inside the images so the DevOps team has come up with a solution to use init containers to perform these tasks during deployment. Below is a sample scenario that the team is going to test first. Create a Deployment named as ic-deploy-datacenter. Configure spec as replicas should be 1, labels app should be ic-datacenter, template's metadata lables app should be the same ic-datacenter. The initContainers should be named as ic-msg-datacenter, use image fedora with latest tag and use command '/bin/bash', '-c' and 'echo Init Done - Welcome to xFusionCorp Industries > /ic/blog'. The volume mount should be named as ic-volume-datacenter and mount path should be /ic. Main container should be named as ic-main-datacenter, use image fedora with latest tag and use command '/bin/bash', '-c' and 'while true; do cat /ic/blog; sleep 5; done'. The volume mount should be named as ic-volume-datacenter and mount path should be /ic. Volume to be named as ic-volume-datacenter and it should be an emptyDir type. Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

This task demonstrates how to use **Init Containers** to configure pre-requisites before running the main application container in Kubernetes.

---

## 🧱 Step 1 — Create Deployment Manifest

```bash
vi ic-deploy-datacenter.yaml
```

### YAML Definition
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ic-deploy-datacenter
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ic-datacenter
  template:
    metadata:
      labels:
        app: ic-datacenter
    spec:
      initContainers:
      - name: ic-msg-datacenter
        image: fedora:latest
        command: ["/bin/bash", "-c", "echo Init Done - Welcome to xFusionCorp Industries > /ic/blog"]
        volumeMounts:
        - name: ic-volume-datacenter
          mountPath: /ic

      containers:
      - name: ic-main-datacenter
        image: fedora:latest
        command: ["/bin/bash", "-c", "while true; do cat /ic/blog; sleep 5; done"]
        volumeMounts:
        - name: ic-volume-datacenter
          mountPath: /ic

      volumes:
      - name: ic-volume-datacenter
        emptyDir: {}
```

---

## 🚀 Step 2 — Apply Deployment

```bash
kubectl apply -f ic-deploy-datacenter.yaml
```

Check the deployment and pod status:

```bash
kubectl get deployments
kubectl get pods
```

✅ Output:
```
NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
ic-deploy-datacenter   1/1     1            1           1m

NAME                                    READY   STATUS    RESTARTS   AGE
ic-deploy-datacenter-xxxxxxx-xxxxx      1/1     Running   0          1m
```

---

## 🔍 Step 3 — Check Pod Logs

```bash
kubectl logs -f ic-deploy-datacenter-xxxxxxx-xxxxx
```

✅ Output:
```
Init Done - Welcome to xFusionCorp Industries
Init Done - Welcome to xFusionCorp Industries
...
```

(The message repeats every 5 seconds, confirming the main container is running correctly.)

---

## 🧩 Step 4 — Verify Init Container

```bash
kubectl describe pod ic-deploy-datacenter-xxxxxxx-xxxxx | grep -A3 "Init Containers"
```

✅ Snippet:
```
Init Containers:
  ic-msg-datacenter:
    State:          Terminated
    Reason:         Completed
```

---

### 🏁 Result Summary
| Component | Purpose |
|------------|----------|
| **Init Container (`ic-msg-datacenter`)** | Writes “Init Done - Welcome to xFusionCorp Industries” to `/ic/blog` |
| **Main Container (`ic-main-datacenter`)** | Reads `/ic/blog` continuously every 5 seconds |
| **Volume (`ic-volume-datacenter`)** | Shared `emptyDir` volume used by both containers |

✅ **Init container completed successfully**  
✅ **Main container continuously reads from shared volume**  
✅ **Deployment running as expected** 🚀
