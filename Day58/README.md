The Nautilus DevOps teams is planning to set up a Grafana tool to collect and analyze analytics from some applications. They are planning to deploy it on Kubernetes cluster. Below you can find more details.


1.) Create a deployment named grafana-deployment-datacenter using any grafana image for Grafana app. Set other parameters as per your choice.

2.) Create NodePort type service with nodePort 32000 to expose the app.

You need not to make any configuration changes inside the Grafana app once deployed, just make sure you are able to access the Grafana login page.

Note: The kubectl on jump_host has been configured to work with kubernetes cluster.


# 📊 Grafana Deployment on Kubernetes

This project demonstrates how to deploy **Grafana** on a Kubernetes cluster using a **Deployment** and expose it externally using a **NodePort Service**.

---

## 🎯 Task Objective

* Create a **Deployment** named `grafana-deployment-datacenter`.
* Use the **grafana/grafana:latest** image.
* Container name: `grafana-container`.
* Create a **NodePort Service** named `grafana-service`.
* NodePort should be **32000**.
* Verify that Grafana's login page is accessible at `http://<node-ip>:32000`.

---

## 🧾 Deployment Manifest

Create a file named `grafana-deployment-datacenter.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana-deployment-datacenter
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
        - name: grafana-container
          image: grafana/grafana:latest
          ports:
            - containerPort: 3000
```

Apply the deployment:

```bash
kubectl apply -f grafana-deployment-datacenter.yaml
```

output:

```
deployment.apps/grafana-deployment-datacenter created
```

Verify the deployment:

```bash
kubectl get deployments
kubectl get pods -l app=grafana
```

output:

```
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
grafana-deployment-datacenter 1/1     1            1           40s
```

---

## 🌐 Service Manifest

Create a file named `grafana-service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: grafana-service
spec:
  type: NodePort
  selector:
    app: grafana
  ports:
    - port: 3000
      targetPort: 3000
      nodePort: 32000
```

Apply the service:

```bash
kubectl apply -f grafana-service.yaml
```
output:

```
service/grafana-service created
```

---

## 🔍 Verify Resources

```bash
kubectl get all -l app=grafana
```

output:

```
NAME                                              READY   STATUS    RESTARTS   AGE
pod/grafana-deployment-datacenter-xxxxx-yyyyy     1/1     Running   0          1m

NAME                      TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/grafana-service   NodePort   10.96.15.250    <none>        3000:32000/TCP   10s

NAME                                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/grafana-deployment-datacenter 1/1     1            1           1m
```

---

## 🌍 Access Grafana

```bash

```
http://<node-ip>:32000
```

You should see the **Grafana login page** 🎉

---

## ✅ Summary

| Resource           | Name                            | Description                   |
| ------------------ | ------------------------------- | ----------------------------- |
| **Deployment**     | `grafana-deployment-datacenter` | Deploys Grafana application   |
| **Container name** | `grafana-container`             | Runs Grafana instance         |
| **Image used**     | `grafana/grafana:latest`        | Official Grafana Docker image |
| **Service**        | `grafana-service`               | Exposes Grafana via NodePort  |
| **NodePort**       | `32000`                         | External access port          |
| **Access URL**     | `http://<node-ip>:32000`        | Grafana web interface         |

