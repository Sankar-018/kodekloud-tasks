# Webserver Sidecar Pod - Log Shipping Example

This project demonstrates the **Sidecar Pattern** in Kubernetes using a shared `emptyDir` volume to aggregate logs from an Nginx web server.

---

## 🎯 Task Objective

We need to:

* Create a Pod named **`webserver`**.
* Use a shared **`emptyDir`** volume called `shared-logs`.
* Run two containers:

  * **nginx-container** → `nginx:latest`
  * **sidecar-container** → `ubuntu:latest`
* Mount `/var/log/nginx` from the shared volume on both containers.
* The sidecar continuously outputs both `access.log` and `error.log` every 30 seconds.

---

## 🧾 YAML Manifest

Create a file named `webserver.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: webserver
spec:
  volumes:
    - name: shared-logs
      emptyDir: {}
  containers:
    - name: nginx-container
      image: nginx:latest
      volumeMounts:
        - name: shared-logs
          mountPath: /var/log/nginx

    - name: sidecar-container
      image: ubuntu:latest
      command: ["sh", "-c", "while true; do cat /var/log/nginx/access.log /var/log/nginx/error.log; sleep 30; done"]
      volumeMounts:
        - name: shared-logs
          mountPath: /var/log/nginx
```

---

## ⚙️ Apply Configuration

Apply the manifest to create the Pod:

```bash
kubectl apply -f webserver.yaml
```

Check Pod status:

```bash
kubectl get pods -w
```

Expected output:

```
NAME         READY   STATUS    RESTARTS   AGE
webserver    2/2     Running   0          30s
```

---

## 📈 Generate Logs

Trigger Nginx to create access logs:

```bash
kubectl exec -it webserver -c nginx-container -- curl -s http://localhost >/dev/null
```

Run the above command multiple times to generate more logs.

---

## 🔍 Verify Shared Logs

List log files from **nginx container**:

```bash
kubectl exec -it webserver -c nginx-container -- ls -l /var/log/nginx
```

List log files from **sidecar container**:

```bash
kubectl exec -it webserver -c sidecar-container -- ls -l /var/log/nginx
```

You should see:

```
access.log
error.log
```

---

## 🧾 View Combined Logs from Sidecar

The sidecar container prints logs every 30 seconds:

```bash
kubectl logs webserver -c sidecar-container
```

Sample output:

```
127.0.0.1 - - [12/Nov/2025:18:40:23 +0000] "GET / HTTP/1.1" 200 615 "-" "curl/7.68.0"
```
---

## 💡 Concept Overview

| Component              | Description                                                                                     |
| ---------------------- | ----------------------------------------------------------------------------------------------- |
| **Pod name**           | `webserver`                                                                                     |
| **nginx-container**    | Serves web traffic and generates logs                                                           |
| **sidecar-container**  | Reads logs continuously and ships to aggregation service                                        |
| **shared-logs volume** | `emptyDir` shared between both containers                                                       |
| **Mount path**         | `/var/log/nginx`                                                                                |
| **Sidecar command**    | `sh -c "while true; do cat /var/log/nginx/access.log /var/log/nginx/error.log; sleep 30; done"` |

---

## ✅ Task Verification

* Pod name: `webserver`
* Volume: `shared-logs` (`emptyDir`)
* Containers: `nginx-container`, `sidecar-container`
* Both mount `/var/log/nginx`
* Logs visible in sidecar every 30 seconds
