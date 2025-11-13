Day 70: Configure Jenkins User Access

The Nautilus team is integrating Jenkins into their CI/CD pipelines. After setting up a new Jenkins server, they're now configuring user access for the development team, Follow these steps:

1. Click on the Jenkins button on the top bar to access the Jenkins UI. Login with username admin and password Adm!n321.

2. Create a Jenkins user named ravi with the password YchZHRcLkL. Their full name should match Ravi.

3. Utilize the Project-based Matrix Authorization Strategy to assign overall read permission to the ravi user.

4. Remove all permissions for Anonymous users (if any) ensuring that the admin user retains overall Administer permissions.

5. For the existing job, grant ravi user only read permissions, disregarding other permissions such as Agent, SCM etc.

Note:

You may need to install plugins and restart Jenkins service. After plugins installation, select Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page.

After restarting the Jenkins service, wait for the Jenkins login page to reappear before proceeding. Avoid clicking Finish immediately after restarting the service.

Capture screenshots of your configuration for review purposes. Consider using screen recording software like loom.com for documentation and sharing.

Solution

## ⚙️ Steps to Configure

### **1️⃣ Access Jenkins UI**
Open your browser and go to:  
👉 [http://jenkins.stratos.xfusioncorp.com:8080](http://jenkins.stratos.xfusioncorp.com:8080)

Login with:
```
Username: admin
Password: Adm!n321
```

---

### **2️⃣ Install “Matrix Authorization Strategy” Plugin**
1. Navigate to **Manage Jenkins → Plugins → Available**
2. Search for `Matrix Authorization Strategy`
3. Check the box next to it.
4. Click **Install without restart**
5. After installation, check **Restart Jenkins when installation is complete and no jobs are running**.

Wait for Jenkins to restart, then log in again as `admin`.

---

### **3️⃣ Create Jenkins User: `ravi`**
1. Go to **Manage Jenkins → Security → Manage Users**
2. Click **Create User**
3. Enter the following details:

| Field | Value |
|--------|--------|
| **Username** | `ravi` |
| **Password** | `YchZHRcLkL` |
| **Full Name** | `Ravi` |


4. Click **Create User**

---

### **4️⃣ Configure Global Security (Matrix Authorization)**
1. Go to **Manage Jenkins → System**
2. Scroll down to **Authorization**
3. Select **Project-based Matrix Authorization Strategy**

Now configure as follows:

| User | Permissions |
|------|--------------|
| `admin` | ✅ All permissions (Administer) |
| `ravi` | ✅ Overall → Read |
| `Anonymous` | ❌ None |

💾 Click **Save**.

---

| User | Permission |
|------|-------------|
| `ravi` | ✅ Job → Read |
| `admin` | ✅ All Job Permissions |

💾 Click **Save**

---
