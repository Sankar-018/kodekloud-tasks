# 🧾 Print Environment Variables Pod - Kubernetes Task

Task : The Nautilus DevOps team is working on to setup some pre-requisites for an application that will send the greetings to different users. There is a sample deployment, that needs to be tested. Below is a scenario which needs to be configured on Kubernetes cluster. Please find below more details about it. Create a pod named print-envars-greeting. Configure spec as, the container name should be print-env-container and use bash image. Create three environment variables: a. GREETING and its value should be Welcome to b. COMPANY and its value should be Stratos c. GROUP and its value should be Industries

This project demonstrates how to create a **Kubernetes Pod** that prints environment variables using the **bash** image and exits after execution.

---

## 🎯 Task Objective

* Create a Pod named `print-envars-greeting`.
* Use container name `print-env-container`.
* Use `bash` image.
* Define three environment variables:

  * `GREETING = Welcome to`
  * `COMPANY = Stratos`
  * `GROUP = Industries`
* Use the command:
  `[/bin/sh, -c, 'echo "$(GREETING) $(COMPANY) $(GROUP)"']`
* Set the restart policy to `Never`.

---

## 🧾 YAML Manifest

Create the file `print-envars-greeting.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: print-envars-greeting
spec:
  restartPolicy: Never
  containers:
    - name: print-env-container
      image: bash
      command: ["/bin/sh", "-c", "echo \"$(GREETING) $(COMPANY) $(GROUP)\""]
      env:
        - name: GREETING
          value: "Welcome to"
        - name: COMPANY
          value: "Stratos"
        - name: GROUP
          value: "Industries"
```

---

## ⚙️ Apply the Pod

```bash
kubectl apply -f print-envars-greeting.yaml
```

Expected output:

```
pod/print-envars-greeting created
```

---

## 🧩 Check Pod Status

```bash
kubectl get pods
```

Output:

```
NAME                     READY   STATUS      RESTARTS   AGE
print-envars-greeting    0/1     Completed   0          8s
```

### ✅ Why `0/1 Completed`?

* The pod’s command (`echo ...`) runs once and exits successfully.
* `STATUS: Completed` means it finished without errors.
* `READY: 0/1` means it’s no longer running (since restartPolicy is `Never`).

---

## 📜 View the Output

```bash
kubectl logs print-envars-greeting
```

output:

```
Welcome to Stratos Industries
```

---

## ✅ Summary

| Component           | Description                                         |
| ------------------- | --------------------------------------------------- |
| **Pod name**        | `print-envars-greeting`                             |
| **Container name**  | `print-env-container`                               |
| **Image**           | `bash`                                              |
| **Env Vars**        | GREETING, COMPANY, GROUP                            |
| **Command**         | `/bin/sh -c 'echo $(GREETING) $(COMPANY) $(GROUP)'` |
| **Restart Policy**  | `Never`                                             |
| **Expected Output** | `Welcome to Stratos Industries`                     |

---
