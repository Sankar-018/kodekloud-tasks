# Jenkins Job Setup: install-packages

This README documents the exact steps performed to configure the **install-packages** Jenkins job for installing packages on the storage server in the Stratos Datacenter.

---

## 1️⃣ SSH into Storage Server
Login to the storage server using root credentials:

```bash
ssh root@<storage-server-ip>
```

Use the password provided in the task.

---

## 2️⃣ Log Into Jenkins UI
Open Jenkins in your browser:

```
http://jenkins.stratos.xfusioncorp.com:8080
```

Credentials:
```
Username: admin
Password: Adm!n321
```

---

## 3️⃣ Install Required Jenkins Plugins
Navigate to:

```
Manage Jenkins → Plugins → Available
```

Install:

- **SSH Plugin**

After installation, select:

```
Restart Jenkins when installation is complete and no jobs are running
```

Wait for Jenkins to restart and log in again.

---

## 4️⃣ Add User “natasha”
Go to:

```
Manage Jenkins → Manage Users → Create User
```

Create a new user:

- **Username:** natasha  
- **Password:** (as given in task)  
- **Full Name:** natasha

Click **Create User**.

---

## 5️⃣ Create Jenkins Job: install-packages
Go to:

```
Dashboard → New Item
```

Enter:

- **Name:** install-packages  
- **Type:** Freestyle project  

Click **OK**.

---

## 6️⃣ Add PACKAGE Parameter
In the job configuration:

- Check **This project is parameterized**
- Add → **String Parameter**

| Field | Value |
|-------|--------|
| Name | `PACKAGE` |
| Default Value | httpd *(optional)* |
| Description | Package to install on storage server |

---

## 7️⃣ Add Build Command
Scroll to **Build** → Add build step → **Execute shell**

Enter:

```bash
echo "password" | sudo -S yum install -y $PACKAGE
```

Replace **password** with the correct password for the storage server.

---

## 8️⃣ Test the Job

Click:

```
Build with Parameters
```

Enter a package name:

```
PACKAGE = httpd
```

Verify the console output.

Run again with different packages to ensure the job works consistently.

---

## ✔ Summary

- Logged into storage server  
- Logged into Jenkins UI  
- Installed SSH plugin  
- Added user natasha  
- Created freestyle Jenkins job  
- Added PACKAGE string parameter  
- Added shell command to install package  
- Successfully tested the job  

