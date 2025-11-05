# ☸️ Kubernetes Pod with Resource Requests and Limits

Task : The Nautilus DevOps team has noticed performance issues in some Kubernetes-hosted applications due to resource constraints. To address this, they plan to set limits on resource utilization. Here are the details: Create a pod named httpd-pod with a container named httpd-container. Use the httpd image with the latest tag (specify as httpd:latest). Set the following resource limits: Requests: Memory: 15Mi, CPU: 100m Limits: Memory: 20Mi, CPU: 100m Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster

## 🧩 Project Overview
This task demonstrates how to create a **Kubernetes Pod** with resource **requests** and **limits** to control CPU and memory utilization.  
This helps prevent resource starvation and ensures fair allocation of cluster resources.

---

## 📁 Pod Specifications

| Property | Value |
|-----------|--------|
| **Pod Name** | `httpd-pod` |
| **Container Name** | `httpd-container` |
| **Image** | `httpd:latest` |
| **Requests** | Memory: `15Mi`, CPU: `100m` |
| **Limits** | Memory: `20Mi`, CPU: `100m` |

---

## 🧾 YAML Manifest

Create a file named **`httpd-pod.yaml`** with the following content:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: httpd-pod
spec:
  containers:
    - name: httpd-container
      image: httpd:latest
      resources:
        requests:
          memory: "15Mi"
          cpu: "100m"
        limits:
          memory: "20Mi"
          cpu: "100m"
```

---

## ⚙️ Deployment Steps

1. **Create the pod manifest**
   ```bash
   vi httpd-pod.yaml
   ```
   Paste the YAML content above and save the file.

2. **Apply the pod to the cluster**
   ```bash
   kubectl apply -f httpd-pod.yaml
   ```

   Expected output:
   ```
   pod/httpd-pod created
   ```

3. **Verify the pod status**
   ```bash
   kubectl get pods
   ```

   Example output:
   ```
   NAME         READY   STATUS    RESTARTS   AGE
   httpd-pod    1/1     Running   0          10s
   ```

4. **Check resource configuration**
   ```bash
   kubectl describe pod httpd-pod | grep -A5 "Limits:"
   ```

   Expected snippet:
   ```
   Limits:
     cpu:     100m
     memory:  20Mi
   Requests:
     cpu:     100m
     memory:  15Mi
   ```

---

