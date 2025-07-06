# Build docker image on your local machine:
# 1. Start Docker Desktop and ensure it is running and you are logged in (e.g. with google account).
# 2. Open a terminal and navigate to the directory containing this Dockerfile.
# 3. Run the command: docker build -t my-literature-server .
# 
# Run the Docker container on your local machine:
# 4. After the build completes, run the command: docker run -p 8080:8080 my-literature-server
# 5. Open a web browser and navigate to http://localhost:8080 to access the server.
#
# Deploy to Deploy to Synology NAS is not posible. DS213 has no docker package
# 11. Copy your project folder to your NAS (e.g., via SMB or SCP).
# 12. Open Docker in DSM.
# 13. Go to Image > Add > Build and select your project folder.
# 14. After building, go to Container > Launch and map port 8080.
#
# Deploy on https://render.com/
# Step-by-Step: Deploy Docker App to Render
# ✅ 1. Push Your Code to GitHub
# Make sure your project is in a GitHub repository and includes:
# 
# Your Dart server code
# A working Dockerfile
# If you need help writing the Dockerfile, let me know!
# 
# ✅ 2. Sign In to Render
# Go to https://render.com
# Sign in with your GitHub account
# ✅ 3. Create a New Web Service
# Click “New +” → “Web Service”
# Select your GitHub repo
# Fill in the settings:
# Name: e.g., my-literature-server
# Environment: Docker
# Region: Choose closest to your users
# Branch: main or whichever branch has your code
# Dockerfile Path: usually just Dockerfile
# Start Command: leave blank if your Dockerfile has CMD or ENTRYPOINT
# Port: set to the port your Dart server listens on (e.g., 8080)
# Instance Type: choose Free
# ✅ 4. Deploy
# Click Create Web Service
# Render will build your Docker image and deploy it
# Once deployed, you’ll get a public URL like:
# https://my-literature-server.onrender.com

FROM dart:stable

WORKDIR /app
COPY . .

RUN dart pub get

CMD ["dart", "bin/my_literature_server.dart"]
