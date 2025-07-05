# Build docker image on your local machine:
# 1. Start Docker Desktop and ensure it is running and you are logged in (e.g. with google account).
# 2. Open a terminal and navigate to the directory containing this Dockerfile.
# 3. Run the command: docker build -t my-literature-server .
# 
# Run the Docker container on your local machine:
# 4. After the build completes, run the command: docker run -p 8080:8080 my-literature-server
# 5. Open a web browser and navigate to http://localhost:8080 to access the server.
#
# Deploy to Deploy to Synology NAS:
# 11. Copy your project folder to your NAS (e.g., via SMB or SCP).
# 12. Open Docker in DSM.
# 13. Go to Image > Add > Build and select your project folder.
# 14. After building, go to Container > Launch and map port 8080.
FROM dart:stable

WORKDIR /app
COPY . .

RUN dart pub get

CMD ["dart", "bin/my_literature_server.dart"]
