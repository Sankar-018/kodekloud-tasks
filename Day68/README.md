The DevOps team at xFusionCorp Industries is initiating the setup of CI/CD pipelines and has decided to utilize Jenkins as their server. Execute the task according to the provided requirements:

    Install Jenkins on the jenkins server using the yum utility only, and start its service.

If you face a timeout issue while starting the Jenkins service, refer to this.

    Jenkin's admin user name should be theadmin, password should be Adm!n321, full name should be Yousuf and email should be yousuf@jenkins.stratos.xfusioncorp.com.

Note:

    To access the jenkins server, connect from the jump host using the root user with the password S3curePass.

    After Jenkins server installation, click the Jenkins button on the top bar to access the Jenkins UI and follow on-screen instructions to create an admin user.

Solution
Step 1: Connect to Jenkins Server

ssh root@jenkins.stratos.xfusioncorp.com
# password: S3curePass

# Make it executable
chmod +x install.sh

# Run the installation script
./install.sh

Step 3: Access Jenkins UI

    Open browser and navigate to: http://jenkins.stratos.xfusioncorp.com:8080
    Enter the initial admin password (displayed by the install script)
    Create admin user with the specified credentials:
        Username: theadmin
        Password: Adm!n321
        Full name: Yousuf
        Email: yousuf@jenkins.stratos.xfusioncorp.com
    Complete the setup wizard
