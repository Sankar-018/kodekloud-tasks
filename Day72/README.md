# 1) Access the Jenkins UI
# Open your browser and go to: http://jenkins.stratos.xfusioncorp.com:8080
# Login with:
#   Username: admin
#   Password: Adm!n321

# 2) Create a new job
# - Click "New Item"
# - Enter the name: parameterized-job
# - Select "Freestyle project" and click OK

# 3) Add parameters
# - Check "This project is parameterized"
# - Add "String Parameter":
#     Name: Stage
#     Default Value: Build
# - Add "Choice Parameter":
#     Name: env
#     Choices: Development, Staging, Production (one per line)

# 4) Configure build step
# - Add a "Build" step: "Execute shell"
# - Command:
#     echo "Stage: $Stage"
#     echo "Environment: $env"

# 5) Save the job

# 6) Build the job
# - Click "Build with Parameters"
# - Set env to "Production" and build
# - Confirm the build passes and the console output shows the correct parameter values

