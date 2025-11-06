# ☸️ Kubernetes Nginx + PHP-FPM Troubleshooting

Task : We encountered an issue with our Nginx and PHP-FPM setup on the Kubernetes cluster this morning, which halted its functionality. Investigate and rectify the issue: The pod name is nginx-phpfpm and configmap name is nginx-config. Identify and fix the problem. Once resolved, copy /home/thor/index.php file from the jump host to the nginx-container within the nginx document root. After this, you should be able to access the website using Website button on the top bar. Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.


## 🧩 Task Overview
Fix the issue with the `nginx-phpfpm` pod that prevented the Nginx + PHP-FPM setup from serving the website correctly, then copy the PHP file and verify access.

---

## ⚙️ Steps to Complete the Task

### 1. **Check Pod and ConfigMap**
```bash
kubectl get pods
kubectl get configmap nginx-config -o yaml
```
Ensure the ConfigMap contains:
```nginx
fastcgi_pass 127.0.0.1:9000;
root /var/www/html;
```


### 2. **Copy the PHP File to the Document Root**
```bash
kubectl cp /home/thor/index.php nginx-phpfpm:/var/www/html/index.php -c nginx-container
```

---

### 4. **Verify File Presence**
```bash
kubectl exec -it nginx-phpfpm -c nginx-container -- ls /var/www/html
```
Output:
```
index.php
```

---

### 5. **Test Application**
```bash
kubectl exec -it nginx-phpfpm -c nginx-container -- curl localhost:8099
```
output:
```html
<?php
phpinfo();
?>
```

Then confirm the website loads successfully via the **Website** button in the lab.

---

## ✅ Result
- Nginx ConfigMap corrected (`root /var/www/html;`)
- Directory `/var/www/html` created
- `index.php` copied successfully
- Website accessible on port `8099`

---
