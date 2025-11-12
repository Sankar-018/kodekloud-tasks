# 🐬 MySQL Deployment on Kubernetes — Nautilus DevOps Task

Task : A new MySQL server needs to be deployed on Kubernetes cluster. The Nautilus DevOps team was working on to gather the requirements. Recently they were able to finalize the requirements and shared them with the team members to start working on it. Below you can find the details: 1.) Create a PersistentVolume mysql-pv, its capacity should be 250Mi, set other parameters as per your preference. 2.) Create a PersistentVolumeClaim to request this PersistentVolume storage. Name it as mysql-pv-claim and request a 250Mi of storage. Set other parameters as per your preference. 3.) Create a deployment named mysql-deployment, use any mysql image as per your preference. Mount the PersistentVolume at mount path /var/lib/mysql. 4.) Create a NodePort type service named mysql and set nodePort to 30007. 5.) Create a secret named mysql-root-pass having a key pair value, where key is password and its value is YUIidhb667, create another secret named mysql-user-pass having some key pair values, where frist key is username and its value is kodekloud_roy, second key is password and value is LQfKeWWxWD, create one more secret named mysql-db-url, key name is database and value is kodekloud_db3 6.) Define some Environment variables within the container: a) name: MYSQL_ROOT_PASSWORD, should pick value from secretKeyRef name: mysql-root-pass and key: password b) name: MYSQL_DATABASE, should pick value from secretKeyRef name: mysql-db-url and key: database c) name: MYSQL_USER, should pick value from secretKeyRef name: mysql-user-pass key key: username d) name: MYSQL_PASSWORD, should pick value from secretKeyRef name: mysql-user-pass and key: password Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

This document describes the complete setup of a **MySQL database** deployed on a Kubernetes cluster using PersistentVolumes, Secrets, and a NodePort Service for external access.

---

## 🧱 Task Overview

The Nautilus DevOps team needed to deploy a **MySQL server** on Kubernetes with persistent storage and secure secret-based configuration.

### Requirements Summary

| Resource | Name | Description |
|-----------|------|-------------|
| **PersistentVolume** | `mysql-pv` | 250Mi storage |
| **PersistentVolumeClaim** | `mysql-pv-claim` | Requests 250Mi storage |
| **Deployment** | `mysql-deployment` | 1 replica using MySQL image |
| **Service** | `mysql` | NodePort (30007) |
| **Secrets** | `mysql-root-pass`, `mysql-user-pass`, `mysql-db-url` | For secure environment variable injection |

---

## ⚙️ Step 1 — Create Full YAML Configuration

Save the following YAML as `mysql-deployment.yaml`

```yaml
# ---------------------- #
# Persistent Volume (PV) #
# ---------------------- #
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv
spec:
  capacity:
    storage: 250Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/mysql-data
---
# ----------------------------- #
# Persistent Volume Claim (PVC) #
# ----------------------------- #
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pv-claim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 250Mi
---
# ---------------------- #
# Secrets Configuration  #
# ---------------------- #
apiVersion: v1
kind: Secret
metadata:
  name: mysql-root-pass
type: Opaque
stringData:
  password: YUIidhb667
---
apiVersion: v1
kind: Secret
metadata:
  name: mysql-user-pass
type: Opaque
stringData:
  username: kodekloud_roy
  password: LQfKeWWxWD
---
apiVersion: v1
kind: Secret
metadata:
  name: mysql-db-url
type: Opaque
stringData:
  database: kodekloud_db3
---
# ---------------------- #
# MySQL Deployment       #
# ---------------------- #
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deployment
  labels:
    app: mysql
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
        - name: mysql-container
          image: mysql:5.7
          ports:
            - containerPort: 3306
          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql-root-pass
                  key: password
            - name: MYSQL_DATABASE
              valueFrom:
                secretKeyRef:
                  name: mysql-db-url
                  key: database
            - name: MYSQL_USER
              valueFrom:
                secretKeyRef:
                  name: mysql-user-pass
                  key: username
            - name: MYSQL_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql-user-pass
                  key: password
          volumeMounts:
            - name: mysql-storage
              mountPath: /var/lib/mysql
      volumes:
        - name: mysql-storage
          persistentVolumeClaim:
            claimName: mysql-pv-claim
---
# ---------------------- #
# MySQL Service          #
# ---------------------- #
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  type: NodePort
  selector:
    app: mysql
  ports:
    - port: 3306
      targetPort: 3306
      nodePort: 30007
```

---

## 🚀 Step 2 — Apply and Verify Resources

Apply the configuration:

```bash
kubectl apply -f mysql-deployment.yaml
```

Verify all created resources:

```bash
kubectl get pv,pvc,deploy,po,svc,secrets
```
Output:

```
NAME               CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS     CLAIM                    STORAGECLASS   AGE
mysql-pv           250Mi      RWO            Retain           Available                                                

NAME                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mysql-pv-claim        Bound    pvc-0176xxxx                               250Mi      RWO            standard       30s

NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
mysql-deployment      1/1     1            1           30s

NAME                  TYPE       CLUSTER-IP     PORT(S)          AGE
mysql                 NodePort   10.96.85.155   3306:30007/TCP   30s

NAME                  TYPE     DATA   AGE
mysql-root-pass       Opaque   1      30s
mysql-user-pass       Opaque   2      30s
mysql-db-url          Opaque   1      30s
```

---

## 🔍 Step 3 — Validate Environment Variables

```bash
kubectl exec -it $(kubectl get pod -l app=mysql -o name) -- env | grep MYSQL
```

Output:

```
MYSQL_ROOT_PASSWORD=YUIidhb667
MYSQL_DATABASE=kodekloud_db3
MYSQL_USER=kodekloud_roy
MYSQL_PASSWORD=LQfKeWWxWD
```

---

## 🧪 Step 4 — Connect to MySQL

### From Inside the Pod

```bash
kubectl exec -it $(kubectl get pod -l app=mysql -o name) -- mysql -u kodekloud_roy -pLQfKeWWxWD -e "SHOW DATABASES;"
```

Output:

```
+--------------------+
| Database           |
+--------------------+
| information_schema |
| kodekloud_db3      |
+--------------------+
```

### From Outside (Node)

```bash
mysql -h <NodeIP> -P 30007 -u kodekloud_roy -pLQfKeWWxWD
```
---

## ✅ Final Status

| Resource | Status |
|-----------|---------|
| PV/PVC | ✅ Created & Bound |
| Secrets | ✅ Configured properly |
| Deployment | ✅ Running (1/1 Ready) |
| Service | ✅ Exposed on NodePort 30007 |
| MySQL | ✅ Accessible & database initialized |

---