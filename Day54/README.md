# Volume Share DevOps Pod

Task : Create a pod named volume-share-devops. For the first container, use image debian with latest tag only and remember to mention the tag i.e debian:latest, container should be named as volume-container-devops-1, and run a sleep command for it so that it remains in running state. Volume volume-share should be mounted at path /tmp/news. For the second container, use image debian with the latest tag only and remember to mention the tag i.e debian:latest, container should be named as volume-container-devops-2, and again run a sleep command for it so that it remains in running state. Volume volume-share should be mounted at path /tmp/cluster. Volume name should be volume-share of type emptyDir. After creating the pod, exec into the first container i.e volume-container-devops-1, and just for testing create a file news.txt with any content under the mounted path of first container i.e /tmp/news. The file news.txt should be present under the mounted path /tmp/cluster on the second container volume-container-devops-2 as well, since they are using a shared volume. Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

This task demonstrates how to create a multi-container Pod in Kubernetes that shares data between containers using an `emptyDir` volume.

---

## Task Objectives

* Create a Pod named **volume-share-devops**.
* Use two containers:

  * **volume-container-devops-1** → `debian:latest`, mounts volume at `/tmp/news`
  * **volume-container-devops-2** → `debian:latest`, mounts volume at `/tmp/cluster`
* Both containers share an **emptyDir** volume named `volume-share`.
* Verify that a file created in one container appears in the other.

---

## 1. Pod Manifest File

Create a YAML file named `volume-share-devops.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: volume-share-devops
spec:
  containers:
    - name: volume-container-devops-1
      image: debian:latest
      command: ["sleep", "infinity"]
      volumeMounts:
        - name: volume-share
          mountPath: /tmp/news

    - name: volume-container-devops-2
      image: debian:latest
      command: ["sleep", "infinity"]
      volumeMounts:
        - name: volume-share
          mountPath: /tmp/cluster

  volumes:
    - name: volume-share
      emptyDir: {}
```

---

## 2. Apply the Pod

```bash
kubectl apply -f volume-share-devops.yaml
```

Verify Pod status:

```bash
kubectl get pods
```

Expected output:

```
NAME                  READY   STATUS    RESTARTS   AGE
volume-share-devops   2/2     Running   0          30s
```

---

## 3. Test the Shared Volume

### Create a file in the first container:

```bash
kubectl exec -it volume-share-devops -c volume-container-devops-1 -- bash
echo "This is a shared DevOps test file" > /tmp/news/news.txt
exit
```

### Verify file in the second container:

```bash
kubectl exec -it volume-share-devops -c volume-container-devops-2 -- bash
cat /tmp/cluster/news.txt
```

Expected output:

```
This is a shared DevOps test file
```

---

## 4. Clean Up (Optional)

```bash
kubectl delete pod volume-share-devops
```

---

## Key Concepts

* **emptyDir Volume:** Temporary shared directory for containers within the same Pod.
* **volumeMounts:** Defines the path inside containers where volumes are mounted.
* **sleep infinity:** Keeps containers running for testing.
* **kubectl exec:** Allows shell access inside specific containers.

---

### ✅ Task Verification

Your Pod should show `2/2` containers running and the file created in `/tmp/news` should appear in `/tmp/cluster` of the second container.
